//
//  CenterAlignedImageButton.m
//  NextMeet
//
//  Created by Viktória Sipos on 2017. 07. 16..
//  Copyright © 2017. MyItSolver. All rights reserved.
//

#import "CenterAlignedImageButton.h"

@implementation CenterAlignedImageButton

-(void)awakeFromNib{
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.tintColor = self.tintColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
