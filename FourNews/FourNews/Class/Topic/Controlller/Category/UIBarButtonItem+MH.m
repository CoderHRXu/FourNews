//
//  UIBarButtonItem+MH.m
//  FourNews
//
//  Created by xuxisong on 16/4/20.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "UIBarButtonItem+MH.h"

@implementation UIBarButtonItem (MH)

+(UIBarButtonItem *)itemWithimage:(UIImage *)imageName highted:(UIImage *)highted
                        addTarget:(id)targer action:(nonnull SEL)action

{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:imageName forState:UIControlStateNormal];
    [leftButton setImage:highted forState:UIControlStateHighlighted];
    
//    [leftButton addTarget:self action:@selector(setun) forControlEvents:UIControlEventTouchUpInside];
    [leftButton addTarget:targer action:action forControlEvents:UIControlEventTouchUpInside];
    [leftButton sizeToFit];
    UIView *leftView = [[UIView alloc]initWithFrame:leftButton.bounds];
    [leftView addSubview:leftButton];
    return [[UIBarButtonItem alloc]initWithCustomView:leftView];
}
@end
