//
//  FNTopicViewItem.h
//  FourNews
//
//  Created by xuxisong on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

//模型
@interface FNTopicViewItem : NSObject

@property (nonatomic, strong) NSString *description;

@property (nonatomic, strong) NSString *classification;

@property (nonatomic, assign) int state;

@property (nonatomic, assign) int expertState;

@property (nonatomic, strong) NSString *picurl;

@property (nonatomic, assign) NSString * concernCount;

@property (nonatomic, assign) int questionCount;

@property (nonatomic, strong) NSString *headpicurl;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) int answerCount;

@property (nonatomic, strong) NSString *stitle;

@property (nonatomic, strong) NSString *alias;

@property (nonatomic, assign) int createTime;

@property (nonatomic, strong) NSString *expertId;

@property (nonatomic, strong) NSString *name;


@end
