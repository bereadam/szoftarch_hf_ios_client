//
//  RegistrationViewController.m
//  POIapp
//
//  Created by Viktória Sipos on 2017. 10. 14..
//  Copyright © 2017. MyITSolver. All rights reserved.
//

#import "RegistrationViewController.h"
#import "NetworkManager.h"

@interface RegistrationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property User* user;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.user = [User new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)regTapped:(id)sender {
    if (self.emailTextField.text.length && self.passTextField.text.length) {
        self.user.email = self.emailTextField.text;
        self.user.password = self.passTextField.text;
        [self registerUser];
    }
}
- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

-(void)registerUser{
    [[NetworkManager new] registerUser:self.user successBlock:^(id result) {
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController* VC = [sb instantiateViewControllerWithIdentifier:@"mainVC"];
        [self.navigationController pushViewController:VC animated:true];
    } errorBlock:^(ErrorMessage *error) {
        
    }];
}

@end
