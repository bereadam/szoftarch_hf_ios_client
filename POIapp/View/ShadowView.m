//
//  ShadowView.m
//  ShareForHelp
//
//  Created by Viktória Sipos on 2017. 07. 30..
//  Copyright © 2017. MyItSolver. All rights reserved.
//

#import "ShadowView.h"
#import "UIView+Shadow.h"

@implementation ShadowView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setShadowWithRadius:4 opacity:0.4 offset:CGSizeZero];
}

@end
