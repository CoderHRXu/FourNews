//
//  YJWaveAnimation.h
//  WaveAnimate
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 xmg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, speedType) {
    speedTypeMoreSlowly = 1,
    speedTypeSlowly = 2,
    speedTypeDefault = 3,
    speedTypeFast = 4,
    speedTypeMoreFast = 5,
};

@interface YJWaveAnimationTool : NSObject

+(instancetype)shareWaveAnimationTool;

@end


@interface UIView (waveAnimation)

- (void)addWaveAnimationWithWaveHeight:(CGFloat)height alpha:(CGFloat)alpha;


@end
