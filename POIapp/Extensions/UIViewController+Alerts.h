//
//  UIViewController+Alerts.h
//  MediMap
//
//  Created by Viktória Sipos on 12/09/16.
//  Copyright © 2016 Viki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alerts)

-(void) showAlertWithTitle:(NSString*)title andMessage:(NSString*)message;
-(void) showAlertWithTitle:(NSString*)title andMessage:(NSString*)message andButtonCompletionBlock:(nonnull void (^)())completion;
-(void) showTwoButtonAlertWithTitle:(NSString*)title andMessage:(NSString*)message andCompletionButtonTitle:(NSString*)completionButtonTitle andButtonCompletionBlock:(nonnull void (^)())completion;
-(void)showNoNetworkAlert;
-(void)showInternalServerError;


@end
