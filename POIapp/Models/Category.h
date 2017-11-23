//
//  Category.h
//  POIapp
//
//  Created by Viktória Sipos on 2017. 11. 23..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Poi.h"

@interface Category : NSObject

@property NSString* name;
@property NSNumber* id;
@property NSArray<Category*>* subCategories;
@property NSArray<Poi*>* pois;

@end
