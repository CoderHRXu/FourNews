//
//  FNANDetailItem.h
//  FourNews
//
//  Created by haoran on 16/5/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNANRecItem : NSObject

/** 视频标题  */
@property (nonatomic, strong) NSString *title;
/** 视频评论数  */
@property (nonatomic, strong) NSString *replyCount;
/** 话题描述  */
@property (nonatomic, strong) NSString *topicDesc;
/** 话题图片  */
@property (nonatomic, strong) NSString *topicImg;
/** 视频缩略图片  */
@property (nonatomic, strong) NSString *cover;
/** 播放次数  */
@property (nonatomic, strong) NSString *playCount;
/** 视频时长  */
@property (nonatomic, strong) NSString *length;
/** 视频URL  */
@property (nonatomic, strong) NSString *mp4_url;
/** 话题名称  */
@property (nonatomic, strong) NSString *topicName;

@end
