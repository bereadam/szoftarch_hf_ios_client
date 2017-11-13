//
//  LoginViewController.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 10. 14..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

- (IBAction)loginTapped:(id)sender {
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController* VC = [sb instantiateViewControllerWithIdentifier:@"mainVC"];
    [self.navigationController pushViewController:VC animated:true];
}

- (IBAction)registerTapped:(id)sender {
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController* VC = [sb instantiateViewControllerWithIdentifier:@"registerVC"];
    [self.navigationController pushViewController:VC animated:true];
}

@end
