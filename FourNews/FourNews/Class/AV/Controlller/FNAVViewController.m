//
//  AVViewController.m
//  FourNews
//
//  Created by haoran on 16/3/27.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVViewController.h"
#import "FNAVListViewController.h"
#import "FNAVGetAllCollumns.h"

@implementation FNAVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题和背景色
    self.navigationItem.title = @"视频";
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.878 alpha:1]];
    
    UIImageView * backgoundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"newsTitleImage"]];
    [self.view addSubview:backgoundImageView];
    backgoundImageView.size = CGSizeMake(141, 67);
    backgoundImageView.center = self.view.center;
    
    // 获取各个View的URL字段
    [FNAVGetAllCollumns getAllColumns:^(NSArray * array) {
        [self setupAllChildViewControllersWithArray:array];
        [self setAllpreparation];
    }];
    
    
}

// 获取各个View的URL字段
-(void)setupAllChildViewControllersWithArray:(NSArray *)columnsArray{
    
    for (NSDictionary *dic in columnsArray) {
        FNAVListViewController *listVC = [[FNAVListViewController alloc] init];
        listVC.title = dic[@"tname"];
        listVC.tid = dic[@"tid"];
        [self addChildViewController:listVC];
    }
    
}


@end
