//
//  FNMeController.m
//  FourNews
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNMeController.h"
#import "FNHeardView.h"
#import "FNSettingViewController.h"
@interface FNMeController ()
@property(nonatomic,strong)FNHeardView * heardView;
@end

@implementation FNMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加自定义的view
    FNHeardView * heardView = [FNHeardView getHeadView];
    heardView.frame = CGRectMake(0, 0, 375, 250);
    self.tableView.tableHeaderView = heardView;
    self.heardView = heardView;
    
    //添加顶部红色
    UIView * redView = [[UIView alloc]init];
    redView.frame = CGRectMake(0, -500, 375, 500);
    redView.backgroundColor =FNColor(222, 10, 27);
    [self.tableView addSubview:redView];
    [self getNotice];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    FNHeardView * heardView = [FNHeardView getHeadView];
    heardView.frame = CGRectMake(0, 0, 375, 250);
    self.tableView.tableHeaderView = heardView;
    self.heardView = heardView;

}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    FNHeardView * heardView = [FNHeardView getHeadView];
    heardView.frame = CGRectMake(0, 0, 375, 250);
    self.tableView.tableHeaderView = heardView;
    self.heardView = heardView;
}

-(void)getNotice
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushToSetting) name:@"settingBtnClick" object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)pushToSetting
{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"FNSettingViewController" bundle:nil];
    FNSettingViewController * settingVC = [storyBoard instantiateInitialViewController];
    [self.navigationController pushViewController:settingVC animated:YES];
    
    
}

@end
