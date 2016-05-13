//
//  YJWaveAnimation.m
//  WaveAnimate
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 xmg. All rights reserved.
//

#import "YJWaveAnimation.h"

@interface YJWaveAnimationTool ()


@property (nonatomic, strong) CALayer *waveLayer;

@property (nonatomic, weak) UIImageView *circleRotaV;
@property (nonatomic, weak) UIView *circleV;
@property (nonatomic, weak) UIImageView *circleWaveImgV;

@end

@implementation YJWaveAnimationTool

//1.静态变量
static YJWaveAnimationTool *_instance;

//2.重写分配空间的方法
//alloc --->allocWithZone
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    
    //解决安全问题
    /*
     @synchronized(self) {
     if (_instance == nil) {
     _instance = [super allocWithZone:zone];
     }
     }
     */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

//3.提供类方法
+(instancetype)shareWaveAnimationTool
{
    return [[self alloc]init];
}

- (void)addWaveAnimationWithWaveHeight:(CGFloat)height view:(UIView *)view alpha:(CGFloat)alpha
{
    
    UIView *boxView = [[UIView alloc] init];
    
    boxView.frame = view.bounds;
    boxView.alpha = alpha;
    [view addSubview:boxView];
    view.clipsToBounds = YES;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat waveW = view.frame.size.width;
    CGFloat waveH = view.frame.size.height;
//    NSLog(@"%f,%f",waveW,waveH);
//    NSLog(@"%f",height);
    [path moveToPoint:CGPointMake(0, waveH/2+(waveH-height))];
//     NSLog(@"Point1-----%@",NSStringFromCGPoint(CGPointMake(0, waveH/2+(waveH-height))));
    [path addLineToPoint:CGPointMake(waveW, waveH/2+(waveH-height))];
//    NSLog(@"Point-----%@",NSStringFromCGPoint(CGPointMake(waveW, waveH/2+(waveH-height))));
    
    CALayer *waveLayer = [CALayer layer];
    self.waveLayer = waveLayer;
    [boxView.layer addSublayer:waveLayer];
    UIImage *waveImg = [UIImage imageNamed:@"fb_wave"];
    
    waveLayer.frame = CGRectMake(0, 0, 4*waveW, waveH);
    waveLayer.contents = (__bridge id _Nullable)(waveImg.CGImage);
    
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"position";
    
    anim.duration = 2;
    anim.path = path.CGPath;
    anim.repeatCount = MAXFLOAT;
    
    [self.waveLayer addAnimation:anim forKey:nil];
}

@end


@implementation UIView (waveAnimation)

- (void)addWaveAnimationWithWaveHeight:(CGFloat)height alpha:(CGFloat)alpha
{
    [[YJWaveAnimationTool shareWaveAnimationTool] addWaveAnimationWithWaveHeight:height view:self  alpha:alpha];
}

@end