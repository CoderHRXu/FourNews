//
//  FNAdItem.h
//  FourNews
//
//  Created by caroline on 16/4/15.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNAdItem : NSObject
/** 广告图片*/
@property (nonatomic ,strong) NSString *w_picurl;
/** 广告界面跳转地址*/
@property (nonatomic ,strong) NSString *ori_curl;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;

@end
