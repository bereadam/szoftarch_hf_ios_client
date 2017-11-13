//
//  ParentViewController.h
//  StylePlus
//
//  Created by Viktória Sipos on 2017. 05. 02..
//  Copyright © 2017. MyItSolver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Alerts.h"
#import <CoreLocation/CoreLocation.h>

@interface ParentViewController : UIViewController

-(void)startLoading;
-(void) stopLoading;

@property CLLocationCoordinate2D currentLocation;
-(void) setupLocationManager;

@end
