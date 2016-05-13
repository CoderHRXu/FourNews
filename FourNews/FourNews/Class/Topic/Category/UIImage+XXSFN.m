//
//  UIImage+XXSFN.m
//  FourNews
//
//  Created by xuxisong on 16/4/20.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "UIImage+XXSFN.h"

@implementation UIImage (XXSFN)
//设置一个类方法调用这个方法把图标改成圆形
+(UIImage *)circleImageWithBorder:(CGFloat)borderW color:(UIColor *)boderColor image:(UIImage *)orgImage {

    //确定边框的大小
//    CGFloat borderW =10;
//    UIImage *orgImage = [UIImage imageNamed:@"阿里头像"];
    CGSize size = CGSizeMake(orgImage.size.width+2*borderW, orgImage.size.height+2*borderW);
    UIGraphicsBeginImageContext(size);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width,size.height)];
    [boderColor set];
    [path fill];
     UIBezierPath *minPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, orgImage.size.width, orgImage.size.height)];
    [minPath addClip];
    [orgImage drawAtPoint:CGPointMake(borderW, borderW)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
//设置一个方法把图片编程椭圆
@end
