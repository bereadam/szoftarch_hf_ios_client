//
//  JSONParser.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 11. 23..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "JSONParser.h"
#import "PropertyUtil.h"

@implementation JSONParser

-(Poi*)parsePoi:(NSDictionary*)d{
    return (Poi*) [PropertyUtil createObject:[Poi class] fromDictionary:d];
}
-(Category*)parseCategory:(NSDictionary*)d{
    if ([d isKindOfClass:[NSDictionary class]]) {
        Category* c = (Category*)[PropertyUtil createObject:[Category class] fromDictionary:d];
        c.subCategories =  [self parseCategories:d[@"subcategories"]];
        c.pois = [self parsePois:d[@"pois"]];
        return c;
    }
    return nil;
}
-(NSArray<Poi*>*)parsePois:(NSArray*)a{
    NSMutableArray* arr = [NSMutableArray array];
    for (NSDictionary* d in a) {
        [arr addObject:[self parsePoi:d]];
    }
    return arr;
}
-(NSArray<Category*>*)parseCategories:(NSArray*)a{
    NSMutableArray* arr = [NSMutableArray array];
    for (NSDictionary* d in a) {
        if ([d isKindOfClass:[NSDictionary class]]) {
            [arr addObject:[self parseCategory:d]];
        }
    }
    return arr;
}

@end
