//
//  FNHeardView.m
//  FourNews
//
//  Created by caroline on 16/4/15.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNHeardView.h"
#import "YJWaveAnimation.h"
#import "FNSettingViewController.h"
@interface  FNHeardView()
@property (weak, nonatomic) IBOutlet UILabel * memoryLable;

@property (weak, nonatomic) IBOutlet UIView *WaveBackGroundVie;


@end

@implementation FNHeardView
-(void)awakeFromNib
{
    
}


+(instancetype)getHeadView
{
    FNHeardView * headView = [[[NSBundle mainBundle]loadNibNamed:@"FNHeardView" owner:nil options:nil]lastObject];
    return headView;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    [_WaveBackGroundVie addWaveAnimationWithWaveHeight:40 alpha:0.2];
}

- (IBAction)settingBtnClick:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"settingBtnClick" object:nil];
}


@end
