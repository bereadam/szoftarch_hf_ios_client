//
//  UIView+Shadow.m
//  BookMyCharging
//
//  Created by Viktória Sipos on 2017. 06. 05..
//  Copyright © 2017. MyItSolver. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

-(void)setShadowWithRadius:(CGFloat)radius opacity:(CGFloat)opacity offset:(CGSize)offset{
    [self.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.layer setShadowOffset:offset];
    [self.layer setShadowRadius:radius];
    [self.layer setShadowOpacity:opacity];
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
}


@end
