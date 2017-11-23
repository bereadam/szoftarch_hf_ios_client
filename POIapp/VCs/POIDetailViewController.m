//
//  POIDetailViewController.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 10. 14..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "POIDetailViewController.h"
#import <MapKit/MapKit.h>
#import "FavoritesViewController.h"
#import "NetworkManager.h"

@interface POIDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property BOOL inFavorites;

@end

@implementation POIDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inFavorites = false;
    if ([self.navigationController.parentViewController isKindOfClass:[FavoritesViewController class]]) {
        self.inFavorites = true;
    }
    
    self.titleLabel.text = self.poi.name;
    self.distanceLabel.text = [[self.poi.distance stringValue] stringByAppendingString:@"m"];
    self.descTextView.text = self.poi.desc;
    if (self.inFavorites) {
        [self.favButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }
    else{
        [self.favButton setImage:[UIImage imageNamed:@"like_unfilled"] forState:UIControlStateNormal];
    }
    
    if (self.poi.lat.doubleValue > 90) {
        self.poi.lat= @0;
    }
    if (self.poi.lon.doubleValue > 180) {
        self.poi.lon = @0;
    }
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(self.poi.lat.doubleValue, self.poi.lon.doubleValue);
    [self.mapView addAnnotation:annotation];
    
    MKCoordinateRegion region;
    region.center = CLLocationCoordinate2DMake(self.poi.lat.doubleValue, self.poi.lon.doubleValue);
    region.span.latitudeDelta = 0.05;
    region.span.longitudeDelta = 0.05;
    [self.mapView setRegion:region animated:true];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.descTextView setContentOffset:CGPointZero];
    
}
- (IBAction)favTapped:(id)sender {
    if (self.inFavorites) {
        [self setPoiUnfavorite];
    }
    else{
        [self setPoiFavorite];
    }
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


#pragma mark - Networking
-(void)setPoiFavorite{
    [[NetworkManager new] addPoiToFavorite:self.poi.id successBlock:^(id result) {
        self.favButton.hidden = true;
        [self showAlertWithTitle:@"Poi successfully added to favorites" andMessage:@""];
    } errorBlock:^(ErrorMessage *error) {
        
    }];
}

-(void)setPoiUnfavorite{
    [[NetworkManager new] removePoiFromFavorite:self.poi.id successBlock:^(id result) {
        self.favButton.hidden = true;
        [self showAlertWithTitle:@"Poi successfully removed from favorites" andMessage:@""];
    } errorBlock:^(ErrorMessage *error) {
        
    }];
}

@end
