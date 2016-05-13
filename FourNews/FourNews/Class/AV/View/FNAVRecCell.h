//
//  FNAVRecCell.h
//  FourNews
//
//  Created by haoran on 16/5/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNAVListItem;

@interface FNAVRecCell : UITableViewCell

/** 模型 **/
@property (nonatomic, strong) FNAVListItem *item;
/** 视频标题  */
@property (weak, nonatomic) IBOutlet UILabel *videoTitleLabel;

@end
