//
//  PoiDistanceManager.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 11. 24..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "PoiDistanceManager.h"


@implementation PoiDistanceManager

-(NSArray<Poi*>*)calculateDistancAndSortPois:(NSArray<Poi*>*)pois currentLocation:(CLLocationCoordinate2D)location{
    NSMutableArray* poisMut = [pois mutableCopy];
    for (Poi* poi in pois) {
        if (poi.lat.doubleValue > 90) {
            poi.lat= @0;
        }
        if (poi.lon.doubleValue > 180) {
            poi.lon = @0;
        }
        NSInteger distance = [self getDistanceFromCoordinateLatitude:poi.lat.doubleValue andLongitude:poi.lon.doubleValue currentLoc:location];
        poi.distance=[NSNumber numberWithInteger:distance];
    }
    [poisMut sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber* dist1 = ((Poi*)obj1).distance;
        NSNumber* dist2 = ((Poi*)obj2).distance;
        return [dist1 compare:dist2];
    }];
    return poisMut;
}

- (NSInteger)getDistanceFromCoordinateLatitude:(double)lat andLongitude:(double)lon currentLoc:(CLLocationCoordinate2D)location
{
    CLLocation *tmpLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    CLLocation* current = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    CLLocationDistance distance = [current distanceFromLocation:tmpLocation];
    return (NSInteger)distance;
    
    
}

@end
