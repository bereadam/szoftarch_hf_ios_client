//
//  JSONParser.h
//  POIapp
//
//  Created by Viktória Sipos on 2017. 11. 23..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Poi.h"
#import "Category.h"

@interface JSONParser : NSObject

-(Poi*)parsePoi:(NSDictionary*)d;
-(Category*)parseCategory:(NSDictionary*)d;
-(NSArray<Poi*>*)parsePois:(NSArray*)a;
-(NSArray<Category*>*)parseCategories:(NSArray*)a;

@end
