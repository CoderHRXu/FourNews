//
//  FNAVDetailTopicCell.m
//  FourNews
//
//  Created by haoran on 16/5/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVDetailTopicCell.h"
#import "FNAVListItem.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FNAVDetailTopicCell ()
// 话题图片
@property (weak, nonatomic) IBOutlet UIImageView *topicImageView;
// 话题名
@property (weak, nonatomic) IBOutlet UILabel *topicNameLabel;

// 话题描述
@property (weak, nonatomic) IBOutlet UILabel *topicDescriptionLabel;

@end


@implementation FNAVDetailTopicCell

-(void)awakeFromNib{
    [super awakeFromNib];
    // 设置圆角
    [self.topicImageView.layer setCornerRadius:5 ];
    self.topicImageView.layer.masksToBounds = YES;
    self.autoresizingMask = UIViewAutoresizingNone;
}



-(void)setItem:(FNAVListItem *)item{
    _item = item;

    [self.topicImageView sd_setImageWithURL:[NSURL URLWithString:item.topicImg]];
    self.topicNameLabel.text = item.topicName;
    self.topicDescriptionLabel.text = item.topicDesc;
}

-(void)setFrame:(CGRect)frame{
    
    frame.size.height -= 10;
    
    //给frame赋值
    [super setFrame:frame];
}

+(instancetype)topicCell{
    return [[NSBundle mainBundle]loadNibNamed:@"FNAVDetailTopicCell" owner:nil options:nil].lastObject;

}


@end
