//
//  LoginViewController.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 10. 14..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "LoginViewController.h"
#import "NetworkManager.h"

@interface LoginViewController()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *pasTextField;
@property User* user;
@end

@implementation LoginViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.user = [User new];
}

- (IBAction)loginTapped:(id)sender {
    if (self.emailTextField.text.length && self.pasTextField.text.length) {
        self.user.email = self.emailTextField.text;
        self.user.password = self.pasTextField.text;
        [self login];
    }
}

- (IBAction)registerTapped:(id)sender {
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController* VC = [sb instantiateViewControllerWithIdentifier:@"registerVC"];
    [self.navigationController pushViewController:VC animated:true];
}

#pragma mark - Networking

-(void)login{
    [[NetworkManager new] login:self.user successBlock:^(id result) {
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController* VC = [sb instantiateViewControllerWithIdentifier:@"mainVC"];
        [self.navigationController pushViewController:VC animated:true];
    } errorBlock:^(ErrorMessage *error) {
        
    }];
}

@end
