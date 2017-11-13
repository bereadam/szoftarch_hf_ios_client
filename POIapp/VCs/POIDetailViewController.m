//
//  POIDetailViewController.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 10. 14..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "POIDetailViewController.h"
#import <MapKit/MapKit.h>

@interface POIDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;

@end

@implementation POIDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(47, 19);
    [self.mapView addAnnotation:annotation];
    
    MKCoordinateRegion region;
    region.center = CLLocationCoordinate2DMake(47, 19);
    region.span.latitudeDelta = 0.05;
    region.span.longitudeDelta = 0.05;
    [self.mapView setRegion:region animated:true];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.descTextView setContentOffset:CGPointZero];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)navigateTapped:(id)sender {
    MKPlacemark* placeMark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(47, 19) addressDictionary:nil];
    MKMapItem* destination =  [[MKMapItem alloc] initWithPlacemark:placeMark];
    destination.name=@"POI";
    [destination openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
