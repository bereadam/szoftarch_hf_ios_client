//
//  ParentViewController.m
//  StylePlus
//
//  Created by Viktória Sipos on 2017. 05. 02..
//  Copyright © 2017. MyItSolver. All rights reserved.
//

#import "ParentViewController.h"
#import "MBProgressHUD.h"


@interface ParentViewController () <CLLocationManagerDelegate>

@property CLLocationManager* locationManager;

@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)startLoading{
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
}

-(void) stopLoading{
    [MBProgressHUD hideHUDForView:self.view animated:true];
}

-(void) setupLocationManager{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    [self showAlertWithTitle:NSLocalizedString(@"Error", @"") andMessage:NSLocalizedString(@"location_error", @"")];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil ) {
        if (self.currentLocation.latitude== 0 && self.currentLocation.longitude==0) {
            self.currentLocation = currentLocation.coordinate;
        }
        self.currentLocation = currentLocation.coordinate;
    }
}


@end
