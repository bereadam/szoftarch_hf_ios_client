//
//  FavoritesViewController.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 10. 14..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()
@property UINavigationController* myNavigationController;
@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.childViewControllers.count) {
        self.myNavigationController = self.childViewControllers.firstObject;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
