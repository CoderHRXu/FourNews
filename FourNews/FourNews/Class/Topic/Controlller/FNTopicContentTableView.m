//
//  FNTopicContentTableView.m
//  FourNews
//
//  Created by xuxisong on 16/4/20.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopicContentTableView.h"
#import <UIImageView+WebCache.h>
#import "FNTopicViewItem.h"
#import "FNTopToolView.h"
#import "FNTopocListItem.h"
#import <MJRefresh.h>
@interface FNTopicContentTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *arrayItem;
@property (nonatomic,strong) FNTopocListItem*topoclist;
@property (nonatomic,strong) UILabel *labelV;
@property (nonatomic,weak) UIImageView *imageV;
@end
@implementation FNTopicContentTableView
static NSString *const ID = @"cell";
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //加载里面的数据
    [self addSubives];
    //设置上面imagev里面的设置
    [self setundown];
    [self setInsetV];
    [self setQuesAnsTableV];
    //输入网络数据
    [self getupdownLoad];
    //刷新我们的下赚
    //刷新我们的上啦
    
    
}
//设置我们的图片的imageV
-(void)addSubives
{
    UIImageView *imagev = [[UIImageView alloc]init];
    imagev.frame = CGRectMake(0, -40, FNScreenW, 200+40);
    [imagev sd_setImageWithURL:[NSURL URLWithString:self.item.picurl]];
    [self.view addSubview:imagev];
    self.imageV = imagev;
    
}
#pragma mark --setundown
-(void)setundown
{
    FNTopToolView *toolView = [[NSBundle mainBundle] loadNibNamed:@"FNTopToolView" owner:nil options:0].lastObject;
    toolView.backBlock =^{
        [self backBtnClick];
    };
    toolView.frame = CGRectMake(0, 20, FNScreenW, 40);
    UILabel *topL = [[UILabel alloc]init];
    topL.bounds = CGRectMake(0, 0, FNScreenW -80, 40);
    topL.center = CGPointMake(FNScreenW /2, 20);
    topL.text = self.item.alias;
    topL.textColor = [UIColor whiteColor];
//    topL.backgroundColor = [UIColor clearColor];
    topL.font = [UIFont systemFontOfSize:15];
    [toolView addSubview:topL];
    [self.view addSubview:toolView];
    self.labelV = topL;
    
}
//设置我们的settitle
-(void)setInsetV
{   FNTopocListItem *topC = [FNTopocListItem FNTopocListItem];
    topC.item =self.item;
    topC.frame = CGRectMake(0, 64, FNScreenW, 136);
    [self.view addSubview:topC];
    self.topoclist = topC;
    
    
}
//设置我们的table的设置
-(void)setQuesAnsTableV
{
    UITableView *quesAnstable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, FNScreenW, FNScreenH-64) style:UITableViewStylePlain];
    
    quesAnstable.delegate =self;
    quesAnstable.dataSource = self;
    quesAnstable.contentInset = UIEdgeInsetsMake(136, 0, 0, 0);
    quesAnstable.backgroundColor = [UIColor clearColor];
    quesAnstable.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:quesAnstable];
//    [self.view bringSubviewToFront:quesAnstable];
    [quesAnstable registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];

}
#pragma mark --设置我们的 导航条
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
#pragma mark --刷新网络数据
-(void)getupdownLoad
{


}


#pragma mark --设置tableview代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    return cell;

}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --设置table的代理滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  
    //最开始-136.往上滚动设置它的+滚动的范围136
    CGFloat panS= scrollView.contentOffset.y +136;
      NSLog(@"%lf",panS);//最大是滚动136；
    //请alpha 值
    CGFloat alpha = panS/136.0;
    NSLog(@"%lf",alpha);//当到达1的时候就会题目的显示就完全消失。那个标志就会显示出来
    if (alpha >1) {
        alpha = 0.99;
    }
    self.imageV.frame = CGRectMake(0, -40 +alpha *40, FNScreenW, 200+40);
    self.topoclist.frame = CGRectMake(0, 64-panS, FNScreenW, 136);
    self.topoclist.topLable.alpha = 1- panS/80.0;//让里面的toplabel变消失
    self.topoclist.alpha =1-panS/100.0;//让整体在消失
    self.labelV.alpha =alpha;
    
    
}
@end
