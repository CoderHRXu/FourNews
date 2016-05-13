//
//  TopicViewController.m
//  FourNews
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "FNTopTableViewCell.h"
#import "FNTopicViewItem.h"
#import <UIImageView+WebCache.h>
#import "UIBarButtonItem+MH.h"
#import <MJRefresh.h>
#import "FNTopicContentTableView.h"
//#import "NSObject+Log.h"
#import <MJExtension/MJExtension.h>
static NSString *const ID =@"xxs";
@interface FNTopicViewController ()
//设置一个可变的数组
@property (nonatomic,strong)NSMutableArray *arrItem;

@end
@implementation FNTopicViewController


//view加载
-(void)viewDidLoad
{// 调用我们的super
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置右边的图标设置
    [self tabBarLeft];
//    [self setItem];
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setItem)];
    //上啦设置
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(addsetItem)];
    [self.tableView.mj_header beginRefreshing];
    
//设置我们的背影颜色
//    [self.view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
    //设置我们的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"FNTopTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    //设置它的大概缓存为
    self.tableView.estimatedRowHeight = 150;
    
 }
//设置它的leftButton;
-(void)tabBarLeft
{

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"tabbar_icon_me_highlight"] highted:[UIImage imageNamed:@"tabbar_icon_me_normal"] addTarget:self action:@selector(setun)];
    
}
//点击事件跳转它的view
-(void)setun
{
    NSLog(@"ss");
}


-(void)setItem
{
    //建立请求回话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //在发送请求之前加这句话
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 发送请求
    [manager  GET:@"http://c.m.163.com/newstopic/list/expert/0-10.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        //是一个网站
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        //字符转换nsdata2进制
        //        NSLog(@"%@",result);
        NSData *date = [result dataUsingEncoding:NSUTF8StringEncoding];
        //2进制转字典
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:date options:kNilOptions error:nil];
        
        //        NSLog(@"%@",dict);
        //字典里提取我们要的数组
        NSDictionary *array = dict[@"data"];
        NSArray *arrayM = array[@"expertList"];
        //读出我们的模型类型，写出
        //        [NSObject resolveDict:arrayM[0]];
        //字典转模型

            _arrItem = [FNTopicViewItem mj_objectArrayWithKeyValuesArray:arrayM];
      
                [self.tableView reloadData];
        [arrayM writeToFile:@"/Users/xuxisong/Desktop/UI高级/0409/123.plist" atomically:YES];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    

}
 static NSInteger i = 1;
-(void)addsetItem
{
    //建立请求回话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置一个index
   
    NSString *path = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/expert/%zd-10.html",i*10];
                      
    //在发送请求之前加这句话
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 发送请求
    [manager  GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        //是一个网站
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        //字符转换nsdata2进制
        //        NSLog(@"%@",result);
        NSData *date = [result dataUsingEncoding:NSUTF8StringEncoding];
        //2进制转字典
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:date options:kNilOptions error:nil];
        
        //        NSLog(@"%@",dict);
        //字典里提取我们要的数组
        NSDictionary *array = dict[@"data"];
        NSArray *arrayM = array[@"expertList"];
        //读出我们的模型类型，写出
        //        [NSObject resolveDict:arrayM[0]];
        //字典转模型
        
        NSArray *arryItem = [FNTopicViewItem mj_objectArrayWithKeyValuesArray:arrayM];
        [self.arrItem addObjectsFromArray:arryItem];
        
        [self.tableView reloadData];
//        [arrayM writeToFile:@"/Users/xuxisong/Desktop/UI高级/0409/123.plist" atomically:YES];
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    i++;
    


}

//多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.arrItem.count;
    
}
//一个控制器显示tabbbar
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

// cell
-(FNTopTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    FNTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.arrItem[indexPath.row];
    
    return cell;
}
//设置它的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;

}
//代理方法清除缓存
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[SDImageCache sharedImageCache] clearMemory];

}
#pragma mark --点击了cell选中响应的cell进入
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zd",indexPath.row);
    FNTopicViewItem *item = self.arrItem[indexPath.row];
   //吧这个模型给我们的下一个table
    FNTopicContentTableView *topicContent = [[FNTopicContentTableView alloc]init];
    
    topicContent.item = item;
    [self.navigationController pushViewController:topicContent animated:YES];
    
}

@end
