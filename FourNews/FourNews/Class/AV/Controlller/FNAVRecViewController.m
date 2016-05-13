//
//  FNAVRecViewController.m
//  FourNews
//
//  Created by haoran on 16/5/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVRecViewController.h"
#import "FNAVListItem.h"
#import "FNAVRecCell.h"
#define topViewH 50


@interface FNAVRecViewController ()<UITableViewDataSource, UITableViewDelegate>
/** <#名称#>  */
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation FNAVRecViewController


static NSString * ID = @"tuijian";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.autoresizingMask = NO;
    [self setupTopView];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

}

-(void)setupTableView {

    
    CGRect frame = CGRectMake(0, topViewH, FNScreenW, FNScreenH - videoViewH - 20 - topViewH);
    UITableView * tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    // 设置背景色
    tableView.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1];
   

    tableView.separatorInset = UIEdgeInsetsZero;
    
    // 注册cell
    [tableView registerNib:[UINib nibWithNibName:@"FNAVRecCell" bundle:nil] forCellReuseIdentifier:ID];
    
    // 设置数据源和代理
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;

}

-(void)setupTopView{
    UIView * topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0 , 0, FNScreenW, 50);
    topView.backgroundColor = [UIColor whiteColor];
    
    // 设置推荐label
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 50)];
    label.text = @"推荐";
    
    // 设置关闭按钮
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(FNScreenW - 24 - 15, (50 - 24)*0.5 , 30, 30);
    [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    // 设置分割线
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, FNScreenW, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1];
    
    [topView addSubview:lineView];
    [topView addSubview:btn];
    [topView addSubview:label];

    [self.view addSubview:topView];
}


#pragma mark - 按钮事件
-(void)close{
    // 发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"closeBtnClick" object:nil];
  
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNAVRecCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    FNAVListItem * item = self.itemArray[indexPath.row];
    cell.item = item;
    return cell;
}



//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//
//    return @"推荐";
//
//}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView * view = [[UIView alloc]init];
//    view.frame = CGRectMake(0 , 0, FNScreenW, 50);
//    view.backgroundColor = [UIColor whiteColor];
//    
//    // 设置推荐label
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 50)];
//    label.text = @"推荐";
//    
//    // 设置关闭按钮
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(FNScreenW - 24 - 15, (50 - 24)*0.5 , 30, 30);
//    [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//    // 设置分割线
//    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, FNScreenW, 1)];
//    lineView.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1];
//    
//    [view addSubview:lineView];
//    [view addSubview:btn];
//    [view addSubview:label];
//    return view;
//    
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 50;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 取出模型
//    FNAVListItem * selItem = self.itemArray[indexPath.row];
    if (_CellSelectBlock){
        _CellSelectBlock(indexPath.row);
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"shouldChangeVideo"  object:nil userInfo:@{@"index" : indexPath }];
    
    // 取出cell
    FNAVRecCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.videoTitleLabel.highlightedTextColor = [UIColor redColor];
    
}


@end
