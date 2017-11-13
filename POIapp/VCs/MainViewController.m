//
//  MainViewController.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 10. 14..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property UINavigationController* myNavigationController;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.childViewControllers.count) {
        self.myNavigationController = self.childViewControllers.firstObject;
    }
    self.backView.hidden = true;
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
}

- (IBAction)favorieTapped:(id)sender {
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController* VC = [sb instantiateViewControllerWithIdentifier:@"favVC"];
    [self.navigationController pushViewController:VC animated:true];
}

- (IBAction)logoutTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

-(void)setBackActive:(BOOL)active{
    self.backView.hidden = !active;
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
