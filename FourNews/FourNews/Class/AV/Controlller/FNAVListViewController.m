//
//  FNAVListViewController.m
//  FourNews
//
//  Created by haoran on 16/4/11.
//  Copyright © 2016年 xuhaoran. All rights reserved.
//

#import "FNAVListViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "FNAVListItem.h"
#import "FNAVListCell.h"
#import <MJRefresh/MJRefresh.h>
#import "FNAVGetAllCollumns.h"
#import "FNAVGetNewList.h"
#import "FNAVDetailViewController.h"
#import "FNAVTopicViewController.h"
#import "FNTopicContentTableView.h"

static NSString * ID = @"cell";

@interface FNAVListViewController ()

/** 模型数组 **/
@property (nonatomic, strong) NSMutableArray * itemArray;
/** 起始编号 **/
@property (nonatomic, assign) NSInteger starNum;
/** 结束编号 **/
@property (nonatomic, assign) NSInteger endNum;

@property (nonatomic, assign) NSInteger refreshCount;

@property (nonatomic, assign) NSIndexPath *previousIndexPath;

@end

@implementation FNAVListViewController



#pragma mark - 懒加载
-(NSMutableArray *)itemArray{
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }

    return _itemArray;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    
    self.starNum = 1;
    self.endNum = 10;
    
    [super viewDidLoad];
    // 设置背景色
    self.view.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1];
    [self.navigationItem setTitle:@"视频"];
    
    // 获取各个页面数据
    // 设置内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0 , 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"FNAVListCell" bundle:nil] forCellReuseIdentifier:ID];
    
        
    // 设置header
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
     [self.tableView.mj_header beginRefreshing];
    // 设置footer
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 取消隐藏导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 取消隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - 获取数据

-(void)footerRefresh{

    [FNAVGetNewList getAVNewsListWithTid:self.tid :++self.refreshCount :^(NSArray *array) {
        [self.itemArray addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)headerRefresh{
    
    [FNAVGetNewList getAVNewsListWithTid:self.tid :0 :^(NSArray *array) {
        self.itemArray = (NSMutableArray *)array;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }];
}




#pragma mark - tableView代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    FNAVListItem * item = self.itemArray[indexPath.row];
    FNAVDetailViewController * vc = [[FNAVDetailViewController alloc]init];
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = !self.itemArray.count;
    
    return self.itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FNAVListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FNAVListItem *item = self.itemArray[indexPath.row];
    cell.item = item;
    cell.jumptoTopicBlock = ^(FNAVListItem *item){
        FNTopicContentTableView * vc =[[FNTopicContentTableView alloc]init];
        vc.view.frame = CGRectMake(0, 0, FNScreenW, FNScreenH);
        [self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

// 返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FNAVListItem *item = self.itemArray[indexPath.row];
    return item.cellHeight;
}




@end
