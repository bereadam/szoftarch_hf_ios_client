//
//  FavoritesViewController.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 10. 14..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "FavoritesViewController.h"
#import "NetworkManager.h"
#import "PoiListViewController.h"
#import "PoiDistanceManager.h"

@interface FavoritesViewController ()
@property UINavigationController* myNavigationController;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.childViewControllers.count) {
        self.myNavigationController = self.childViewControllers.firstObject;
    }
    [self getFavorites];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backTapped:(id)sender {
    if(self.myNavigationController.viewControllers.count == 1){
        [self.navigationController popViewControllerAnimated:true];
    }
    else{
        [self.myNavigationController popViewControllerAnimated:true];
    }
}

-(void)getFavorites{
    [[NetworkManager new] getFavoritesWithSuccessBlock:^(NSArray<Poi *> *result) {
        PoiListViewController* VC = (PoiListViewController*)self.myNavigationController.viewControllers.firstObject;
        VC.pois = [[PoiDistanceManager new] calculateDistancAndSortPois:result currentLocation:self.currentLoc];
        VC.search = false;
        [VC reloadTableView];
    } errorBlock:^(ErrorMessage *error) {
        
    }];
}


@end
