//
//  UIView+Extension.m
//  MyEventApp
//
//  Created by Tiyasi Acharya on 09/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIView+Extension.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (Extension)

-(void)setBorderWidth:(CGFloat)width withColor:(UIColor *)borderColor withCornerRadius:(CGFloat)radius
{
    CALayer * layer = [self layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:radius]; //note that when radius is 0, the border is a rectangle
    [layer setBorderWidth:width];
    [layer setBorderColor:[borderColor CGColor]];
}

@end
