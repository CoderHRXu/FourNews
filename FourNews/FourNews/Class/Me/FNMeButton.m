//
//  FNMeButton.m
//  FourNews
//
//  Created by caroline on 16/4/22.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNMeButton.h"
#import <UIKit/UIKit.h>

@implementation FNMeButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    [self.imageView sizeToFit];
    
    CGPoint p = self.imageView.center;
    p.x = 46;
    self.imageView.center = p;
    CGPoint p1 = self.titleLabel.center;
    p1.x = 46;
    self.titleLabel.center = p1;
    [self.titleLabel sizeToFit];
    [self.imageView sizeToFit];

    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.y = 10;
    self.imageView.frame = imageFrame;
    
    CGRect lableFrame = self.imageView.frame;
    lableFrame.origin.y = 40;
    lableFrame.size.width = self.imageView.frame.size.width + 40;
    self.titleLabel.frame = lableFrame;
    
//    NSLog(@"%f",self.titleLabel.y);
    

}


@end
