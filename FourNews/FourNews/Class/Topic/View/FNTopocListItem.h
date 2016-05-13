//
//  FNTopocListItem.h
//  FourNews
//
//  Created by xuxisong on 16/4/20.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNTopicViewItem;
@interface FNTopocListItem : UIView
@property (weak, nonatomic) IBOutlet UILabel *topLable;
@property (nonatomic,strong)FNTopicViewItem *item;

+(instancetype)FNTopocListItem;
@end
