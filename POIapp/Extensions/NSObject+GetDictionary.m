//
//  NSObject+GetDictionary.m
//  ShareForHelp
//
//  Created by Viktória Sipos on 2017. 07. 17..
//  Copyright © 2017. MyItSolver. All rights reserved.
//

#import "NSObject+GetDictionary.h"
#import "PropertyUtil.h"

@implementation NSObject (GetDictionary)

-(NSDictionary*)getDictionary{
    return [PropertyUtil createDictionaryFromObject:self];
}

@end
