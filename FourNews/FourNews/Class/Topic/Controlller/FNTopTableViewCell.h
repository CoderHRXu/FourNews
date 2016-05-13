//
//  FNTopTableViewCell.h
//  FourNews
//
//  Created by xuxisong on 16/4/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNTopicViewItem;
@interface FNTopTableViewCell : UITableViewCell
//建立一个模型属性
@property (nonatomic,strong)FNTopicViewItem *item;

@end
