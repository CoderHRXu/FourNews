//
//  FNAdViewController.m
//  FourNews
//
//  Created by caroline on 16/4/15.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAdViewController.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>
#import "FNAdItem.h"
#import <MJExtension/MJExtension.h>
#import "ChooseRootVC.h"
@interface FNAdViewController ()
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
@property(nonatomic,strong) NSTimer * timer;
@property(nonatomic,strong) FNAdItem * item;
@end
#define BaseUrl @"http://mobads.baidu.com/cpro/ui/mads.php"
#define Code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuV"


@implementation FNAdViewController
-(UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self.adView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [_imageView addGestureRecognizer:tap];
        
    }
    return _imageView;
}
-(void)tap
{
    UIApplication * app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:self.item.ori_curl]]) {
        [app openURL:[NSURL URLWithString:self.item.ori_curl]];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAdView];
   _timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];

}
- (IBAction)jumpBtnClick:(id)sender {
    [UIApplication sharedApplication].keyWindow.rootViewController = [ChooseRootVC chooseRootViewController];
    [_timer invalidate];
}
//当时间改变的时候
-(void)timeChange
{
        static int i = 3;
        if (i <=0 ) {
            [self jumpBtnClick:nil];
        }
        NSString * str = [NSString stringWithFormat:@"跳过(%d)",i];
        [self.jumpBtn setTitle:str forState:UIControlStateNormal];
        i--;
        
    }
//设置广告界面,下载数据
-(void)setUpAdView
{
    //创建会话管理者
    AFHTTPSessionManager * mag = [AFHTTPSessionManager manager];
    //发送get请求
    //设置请求参数
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] =Code2;
    [mag GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        //写入plist文件
        NSDictionary * dict = [responseObject[@"ad"]firstObject];
        [responseObject writeToFile:@"/Users/caroline/Desktop/网易新闻项目/FourNews/FourNews/ad.plist" atomically:YES];
        //字典转模型

        _item = [FNAdItem mj_objectWithKeyValues:dict];
        // 展示界面
        CGFloat w = FNScreenW;
        CGFloat h = 550;
        self.imageView.frame = CGRectMake(0, 0, w, h);
        // 加载广告图片
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
    }];
}

@end
