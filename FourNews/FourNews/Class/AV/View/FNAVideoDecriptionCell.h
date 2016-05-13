//
//  FNAVideoDecriptionCell.h
//  FourNews
//
//  Created by haoran on 16/5/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNAVListItem;
@interface FNAVideoDecriptionCell : UITableViewCell
/** 模型 **/
@property (nonatomic, strong) FNAVListItem *item;
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;

/** 视频标题 **/
@property (weak, nonatomic) IBOutlet UILabel *videoTitleLabel;
/** 视频详情 **/
@property (weak, nonatomic) IBOutlet UILabel *videoSubtitleLabel;
/** <#名称#>  */
@property (nonatomic, strong) void(^CellBtnClickBlock)(FNAVListItem *);
@end
