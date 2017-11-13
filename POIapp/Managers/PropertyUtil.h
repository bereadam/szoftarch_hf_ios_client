//
//  PropertyUtils.h
//  KuponMap
//
//  Created by Viktória Sipos on 12/01/17.
//  Copyright © 2017 Viki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyUtil : NSObject

//+ (NSDictionary *)classPropsFor:(Class)klass;

+ (NSObject*)createObject:(Class)klass fromDictionary:(NSDictionary*)dic;
+ (void)populateObject:(NSObject*)object withPropertiesOfObject:(NSObject*)fromObject;
+(NSDictionary*) createDictionaryFromObject:(NSObject*) object;
+(NSDictionary*) createDictionaryFromObjectWithoutNull:(NSObject*) object;
+ (NSObject*)createObject:(Class)klass fromDictionary:(NSDictionary*)dic withEmbeddedObjects:(NSArray<Class>*)classes;
+(NSDictionary*) deleteNotJSONCompatibleValues:(NSDictionary*)dic;
+(void)populateEncoder:(NSCoder*)encoder withObject:(NSObject*)object;
+(void)populateObject:(NSObject*)object withDecoder:(NSCoder*)decoder;


@end
