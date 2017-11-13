//
//  PropertyUtils.m
//  KuponMap
//
//  Created by Viktória Sipos on 12/01/17.
//  Copyright © 2017 Viki. All rights reserved.
//

#import "PropertyUtil.h"
#import <objc/runtime.h>

@implementation PropertyUtil

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}


+ (NSDictionary *)classPropsFor:(Class)klass
{
    if (klass == NULL) {
        return nil;
    }
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [results setObject:propertyType forKey:propertyName];
        }
    }
    free(properties);
    
    // returning a copy here to make sure the dictionary is immutable
    return [NSDictionary dictionaryWithDictionary:results];
}

+(void)populateEncoder:(NSCoder*)encoder withObject:(NSObject*)object{
    Class klass = [object class];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            //const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSObject* value =[object valueForKey:propertyName];
            [encoder encodeObject:value forKey:propertyName];
        }
    }
    free(properties);
}

+(void)populateObject:(NSObject*)object withDecoder:(NSCoder*)decoder{
    Class klass = [object class];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            NSObject* value =[decoder decodeObjectForKey:propertyName];
            BOOL assignable =[value isKindOfClass:NSClassFromString(propertyType)];
            if (value && assignable){
                [object setValue:value forKey:propertyName];
            }
        }
    }
    free(properties);
}


+ (NSObject*)createObject:(Class)klass fromDictionary:(NSDictionary*)dic
{
    if (klass == NULL || [dic isKindOfClass:[NSNull class]] || dic == nil) {
        return nil;
    }
    NSObject* object = [[klass alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            NSObject* value =[dic objectForKey:propertyName];
            BOOL assignable =[value isKindOfClass:NSClassFromString(propertyType)];
            if (value && assignable){
                [object setValue:value forKey:propertyName];
            }
        }
    }
    free(properties);
    return object;
}

+ (NSObject*)createObject:(Class)klass fromDictionary:(NSDictionary*)dic withEmbeddedObjects:(NSArray<Class>*)classes
{
    if (klass == NULL) {
        return nil;
    }
    NSObject* object = [[klass alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            NSObject* value =[dic objectForKey:propertyName];
            BOOL assignable =[value isKindOfClass:NSClassFromString(propertyType)];
            if (value && assignable){
                [object setValue:value forKey:propertyName];
            }
            else if([value isKindOfClass:[NSDictionary class]]){
                for (Class c in classes) {
                    if (NSClassFromString(propertyType) == c) {
                        NSObject* embeddedObject = [PropertyUtil createObject:c fromDictionary:(NSDictionary*)value];
                        [object setValue:embeddedObject forKey:propertyName];
                    }
                }
            }
        }
    }
    free(properties);
    return object;
}

+ (void)populateObject:(NSObject*)object withPropertiesOfObject:(NSObject*)fromObject
{
    Class klass = [object class];
    NSDictionary* fromProperties = [PropertyUtil classPropsFor:[fromObject class]];
    NSArray<NSString*>* fromKeys = [fromProperties allKeys];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            
            if (![fromKeys containsObject:propertyName]) {
                continue;
            }
    
            NSObject* value =[fromObject valueForKey:propertyName];
            BOOL assignable =[value isKindOfClass:NSClassFromString(propertyType)];
            if (value && assignable){
                [object setValue:value forKey:propertyName];
                
            }
        }
    }
    free(properties);
}

+(NSDictionary*) createDictionaryFromObject:(NSObject*) object{
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyName = [NSString stringWithUTF8String:propName];
             NSObject* value =[object valueForKey:propertyName];
            if (value) {
                if (![value isKindOfClass:[NSDate class]]) {
                     [results setObject:value forKey:propertyName];
                }
            }
            else{
                [results setObject:[NSNull null] forKey:propertyName];
            }
        }
    }
    free(properties);
    
    // returning a copy here to make sure the dictionary is immutable
    return [NSDictionary dictionaryWithDictionary:results];
}

+(NSDictionary*) createDictionaryFromObjectWithoutNull:(NSObject*) object{
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSObject* value =[object valueForKey:propertyName];
            if (value) {
                if (![value isKindOfClass:[NSDate class]]) {
                    [results setObject:value forKey:propertyName];
                }
            }
        }
    }
    free(properties);
    
    // returning a copy here to make sure the dictionary is immutable
    return [NSDictionary dictionaryWithDictionary:results];
}

+(NSDictionary*) deleteNotJSONCompatibleValues:(NSDictionary*)dic{
    NSMutableDictionary* d = [dic mutableCopy];
    for (NSString* key in dic.allKeys) {
        id value = [dic objectForKey:key];
        if (![value isKindOfClass:[NSString class]] && ![value isKindOfClass:[NSNumber class]]) {
            [d removeObjectForKey:key];
        }
    }
    return d;
}


@end
