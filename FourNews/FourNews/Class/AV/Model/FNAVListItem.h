//
//  FNAVListItem.h
//  Video练习
//
//  Created by haoran on 16/4/11.
//  Copyright © 2016年 xuhaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNAVListItem : NSObject
/** 左下角视频类别图片 **/
@property (nonatomic, strong) NSString *topicImg;
/** 视频遮盖 **/
@property (nonatomic, strong) NSString *cover;
/** 评论数 **/
@property (nonatomic, assign) NSInteger replyCount;
/** 视频来源 **/
@property (nonatomic, strong) NSString *videosource;
/** 主题描述 **/
@property (nonatomic, strong) NSString *topicDesc;
/** 标题 **/
@property (nonatomic, strong) NSString *title;
/** 视频地址 **/
@property (nonatomic, strong) NSString *mp4_url;
/** 评论参数 **/
@property (nonatomic, strong) NSString *replyid;
/** 视频长度 **/
@property (nonatomic, assign) NSInteger length;
/** 视频播放次数 **/
@property (nonatomic, assign) NSInteger playCount;
/** 左下角主题名 **/
@property (nonatomic, strong) NSString *topicName;
/** 发布日期 **/
@property (nonatomic, strong) NSString *ptime;
/** 新闻描述 **/
@property (nonatomic, strong) NSString *descrip;

@property (nonatomic, strong) NSString *replyBoard;
/** 用于视频详情页请求的vid  */
@property (nonatomic, strong) NSString *vid;
/** 自己添加的属性,为方便开发 **/

/** 视频cell的高度 **/
@property (nonatomic, assign) CGFloat cellHeight;

/** 视频详情cell的高度 **/
@property (nonatomic, assign) CGFloat decriptionCellHeight;

@end
