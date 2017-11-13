//
//  UIViewController+Alerts.m
//  MediMap
//
//  Created by Viktória Sipos on 12/09/16.
//  Copyright © 2016 Viki. All rights reserved.
//

#import "UIViewController+Alerts.h"

@implementation UIViewController (Alerts)

-(void) showAlertWithTitle:(NSString*)title andMessage:(NSString*)message{
    UIAlertController* alert;
    alert= [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* action = [UIAlertAction actionWithTitle:NSLocalizedString(@"close", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:true completion:^{
    }];
}
-(void) showAlertWithTitle:(NSString*)title andMessage:(NSString*)message andButtonCompletionBlock:(nonnull void (^)())completion{
    UIAlertController* alert;
    alert= [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* action = [UIAlertAction actionWithTitle:NSLocalizedString(@"close", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion();
    }];
    [alert addAction:action];
    
    [self presentViewController:alert animated:true completion:^{
    }];
}

-(void) showTwoButtonAlertWithTitle:(NSString*)title andMessage:(NSString*)message andCompletionButtonTitle:(NSString*)completionButtonTitle andButtonCompletionBlock:(nonnull void (^)())completion{
    UIAlertController* alert;
    alert= [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* action = [UIAlertAction actionWithTitle:completionButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion();
    }];
    UIAlertAction* action2 = [UIAlertAction actionWithTitle:NSLocalizedString(@"back", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action2];
    [alert addAction:action];
    
    
    [self presentViewController:alert animated:true completion:^{
    }];
}

-(void)showNoNetworkAlert{
    [self showAlertWithTitle:NSLocalizedString(@"communication_error_title", @"") andMessage: NSLocalizedString(@"communication_error_text", @"")];
}

-(void)showInternalServerError{
    [self showAlertWithTitle:NSLocalizedString(@"Szerver hiba", @"") andMessage: @""];
}
@end
