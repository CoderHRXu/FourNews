//
//  FNAVListCell.h
//  Video练习
//
//  Created by haoran on 16/4/11.
//  Copyright © 2016年 xuhaoran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNAVListItem;
@interface FNAVListCell : UITableViewCell
/** 模型 **/
@property (nonatomic, strong) FNAVListItem *item;

/** 跳转到话题页面 **/
@property (nonatomic, strong) void(^jumptoTopicBlock)(FNAVListItem  *);
@end
