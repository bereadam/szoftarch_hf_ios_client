//
//  MainViewController.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 10. 14..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "MainViewController.h"
#import "NetworkManager.h"
#import "PoiListViewController.h"
#import "PoiDistanceManager.h"
#import "FavoritesViewController.h"

@interface MainViewController ()

@property UINavigationController* myNavigationController;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.childViewControllers.count) {
        self.myNavigationController = self.childViewControllers.firstObject;
    }
    self.backView.hidden = true;
    [self setupLocationManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backTapped:(id)sender {
    [self.myNavigationController popViewControllerAnimated:true];
    if(self.myNavigationController.viewControllers.count == 1){
        [self setBackActive:false];
    }
}

- (IBAction)searchTapped:(id)sender {
    if (self.searchTextField.text.length) {
        [self sendSearch];
    }
}

- (IBAction)favorieTapped:(id)sender {
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    FavoritesViewController* VC = [sb instantiateViewControllerWithIdentifier:@"favVC"];
    VC.currentLoc = self. currentLocation;
    [self.navigationController pushViewController:VC animated:true];
}

- (IBAction)logoutTapped:(id)sender {
    [self logout];
}

-(void)setBackActive:(BOOL)active{
    self.backView.hidden = !active;
}

-(void)navigateToPoiList:(NSArray<Poi*>*)pois{
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PoiListViewController* VC = [sb instantiateViewControllerWithIdentifier:@"poiListVC"];
    VC.pois = [[PoiDistanceManager new] calculateDistancAndSortPois:pois currentLocation:self.currentLocation];
    VC.search = true;
    [self.myNavigationController pushViewController:VC animated:true];
}

#pragma mark - Networking

-(void)sendSearch{
    [[NetworkManager new] searchPoi:self.searchTextField.text successBlock:^(NSArray<Poi *> *result) {
        if ([self.myNavigationController.viewControllers.lastObject isKindOfClass:[PoiListViewController class]]) {
            PoiListViewController* VC = self.myNavigationController.viewControllers.lastObject;
            if (VC.search) {
                VC.pois = result;
                [VC reloadTableView];
            }
            else{
                [self navigateToPoiList:result];
            }
        }
        else{
            [self navigateToPoiList:result];
        }
        [self setBackActive:true];
    } errorBlock:^(ErrorMessage *error) {
        
    }];
}

-(void)logout{
    [[NetworkManager new] logoutWithSuccessBlock:^(id result) {
        [self.navigationController popToRootViewControllerAnimated:true];
    } errorBlock:^(ErrorMessage *error) {
        [self.navigationController popToRootViewControllerAnimated:true];
    }];
}

@end
