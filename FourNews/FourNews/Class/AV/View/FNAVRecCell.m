//
//  FNAVRecCell.m
//  FourNews
//
//  Created by haoran on 16/5/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVRecCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FNAVListItem.h"


@interface FNAVRecCell()
/** 视频缩略图  */
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
/** 视频时长  */
@property (weak, nonatomic) IBOutlet UILabel *videoTime;

/** 头像  */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/** 名称  */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 跟帖数  */
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end
@implementation FNAVRecCell


-(void)setItem:(FNAVListItem *)item{
    _item = item;
    // 设置视频缩略图
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:item.cover]];
    // 设置话题头像
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.topicImg]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    // 设置视频标题
    self.videoTitleLabel.text = item.title;
    // 设置话题名
    self.nameLabel.text = item.topicName;
    // 设置跟帖数
    if (item.replyCount > 0) {
        self.commentLabel.text = [NSString stringWithFormat:@"%zd跟帖", item.replyCount];
    }else{
        self.commentLabel.text = @"";
    }
    // 设置音频时间
    self.videoTime.text = [NSString stringWithFormat:@"%02zd:%02zd",item.length / 60, item.length % 60];

    
    
}

-(void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.iconImageView.layer setCornerRadius:self.iconImageView.bounds.size.width * 0.5];
    self.iconImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
