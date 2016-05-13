//
//  FNAVListCell.m
//  Video练习
//
//  Created by haoran on 16/4/11.
//  Copyright © 2016年 xuhaoran. All rights reserved.
//

#import "FNAVListCell.h"
#import "FNAVListItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FNAVTopicViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "FNAVTopicViewController.h"


@interface FNAVListCell ()

@property (weak, nonatomic) IBOutlet UILabel *tittleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *AVImageView;

@property (weak, nonatomic) IBOutlet UIView *bottomBar;

@property (weak, nonatomic) IBOutlet UIImageView *topicImage;

@property (weak, nonatomic) IBOutlet UILabel *topicDescLabel;

@property (weak, nonatomic) IBOutlet UIView *grayView;

@property (weak, nonatomic) IBOutlet UIButton *videoPlayButton;

@property (weak, nonatomic) IBOutlet UIButton *cmtButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UILabel *videoCountLabel;

@property (weak, nonatomic) IBOutlet UIView *playView;
@property (weak, nonatomic) IBOutlet UIView *coverView;

@end

@implementation FNAVListCell
#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    // 设置圆角
    [self.grayView.layer setCornerRadius:self.grayView.bounds.size.height *0.5];
    [self.topicImage.layer setCornerRadius:self.topicImage.bounds.size.height * 0.5];
    self.topicImage.layer.masksToBounds = YES;
    self.grayView.layer.masksToBounds = YES;
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 添加点击播放视频的手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modalVideo)];
    [self.AVImageView addGestureRecognizer:tap1];
    
    // 添加点击手势进入话题页面
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumptoTopicView)];
    [self.grayView addGestureRecognizer:tap2];
    
}


#pragma mark - 按钮点击

- (IBAction)shareButtonClick:(id)sender {
    NSLog(@"分享页面尚未开发");
}
- (IBAction)cmtButtonClick:(id)sender {
    NSLog(@"跳到视频详情");
}
- (IBAction)videoPlayButtonClick:(id)sender {
    
    [self modalVideo];
    
}

// 弹出播放视频
-(void)modalVideo{

    if (!_item.mp4_url) return;
        MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:_item.mp4_url]];
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    
}




// 跳转话题界面
-(void)jumptoTopicView{

    _jumptoTopicBlock(_item);

}

#pragma mark - 模型set方法
-(void)setItem:(FNAVListItem *)item{
    
    _item = item;
    // 1.设置标题
    self.tittleLabel.text = item.title;
    // 2.设置视频缩略图
    [self.AVImageView sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:[UIImage imageNamed:@"12.pic"]];
    // 3.设置底部
    
    [self.topicImage sd_setImageWithURL:[NSURL URLWithString:item.topicImg]];
    self.topicDescLabel.text =item.topicName;
    
    // 4.视频播放次数
    if (item.playCount >= 10000) {
        
        NSString *str = [NSString stringWithFormat:@" %02zd:%02zd/%.1f万次播放",item.length / 60,item.length % 60 ,item.playCount / 10000.0];
        self.videoCountLabel.text = str;
    }else{
        NSString *str = [NSString stringWithFormat:@" %02zd:%02zd/%zd次播放",item.length / 60,item.length % 60 ,item.playCount];
        self.videoCountLabel.text = str;
    }
    
    [self.cmtButton setTitle:[NSString stringWithFormat:@"%zd",item.replyCount] forState:UIControlStateNormal];
}


-(void)setFrame:(CGRect)frame{
    
    frame.size.height -= 10;
    
    //给frame赋值
    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
