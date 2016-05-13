//
//  UIBarButtonItem+MH.h
//  FourNews
//
//  Created by xuxisong on 16/4/20.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MH)

+(UIBarButtonItem *)itemWithimage:(UIImage *)imageName highted:(UIImage *)highted
                        addTarget:(id)targer action:(nonnull SEL)action;

@end
