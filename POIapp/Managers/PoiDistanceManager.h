//
//  PoiDistanceManager.h
//  POIapp
//
//  Created by Viktória Sipos on 2017. 11. 24..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Poi.h"
#import <CoreLocation/CoreLocation.h>

@interface PoiDistanceManager : NSObject

-(NSArray<Poi*>*)calculateDistancAndSortPois:(NSArray<Poi*>*)pois currentLocation:(CLLocationCoordinate2D)location;

@end
