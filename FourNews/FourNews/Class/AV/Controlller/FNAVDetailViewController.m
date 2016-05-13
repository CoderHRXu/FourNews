//
//  FNAVDetailViewController.m
//  FourNews
//
//  Created by haoran on 16/5/7.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVDetailViewController.h"
#import "FNAVListItem.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "FNAVDetailTopicCell.h"
#import "FNAVRecCell.h"
#import "FNAVideoDecriptionCell.h"
#import "FNAVGetRecmdCollumns.h"
#import "FNAVMoreCell.h"
#import "FNAVRecViewController.h"


#define backBtnWH 40

@interface FNAVDetailViewController()<UITableViewDataSource,UITableViewDelegate>
/** 视频播放控制器 **/
@property (nonatomic, strong) AVPlayerViewController *playerVC;

/** 播放视频的标题 */
@property (nonatomic, strong) UILabel *videoTitleLabel;
/** <#名称#> **/
@property (nonatomic, strong) UITableView *tableView;
/** 推荐模型数组  */
@property (nonatomic, strong) NSArray *itemArray;
/** 视频详情cell按钮是否选中标识符  */
@property (nonatomic, assign) BOOL isSelected;

/** 推荐视频子TableView  */
@property (nonatomic, strong) FNAVRecViewController *subTableViewVC;
@end



@implementation FNAVDetailViewController

/** 话题cell的标识  */
static NSString * topicID = @"topicCell";
/** 推荐cell的标识  */
static NSString * rcmdID =@"tuijian";
/** 视频详情cell的标识  */
static NSString * descripID =@"descrip";
/** 查看更多推荐  */
static NSString * moreID =@"more";


#pragma mark - 懒加载

-(FNAVRecViewController *)subTableViewVC{
    if (_subTableViewVC == nil) {
        _subTableViewVC = [[FNAVRecViewController alloc]init];
        _subTableViewVC.view.frame = CGRectMake(0, FNScreenH, FNScreenW, FNScreenH -videoViewH -20);
        _subTableViewVC.itemArray = self.itemArray;
    }
    return _subTableViewVC;

}

- (AVPlayerViewController *)playerVC
{
    if (!_playerVC) {
        _playerVC = [[AVPlayerViewController alloc] init];
        _playerVC.showsPlaybackControls = YES;
        _playerVC.view.translatesAutoresizingMaskIntoConstraints = YES;

    }
    return _playerVC;
}

-(UILabel *)videoTitleLabel{
    if (_videoTitleLabel == nil) {
        _videoTitleLabel = [[UILabel alloc]init];
        _videoTitleLabel.textColor = [UIColor whiteColor];
        
    }
    return _videoTitleLabel;
}




#pragma mark - 初始化
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES ;
    // 默认不选中
    self.isSelected = NO;
    // 添加播放器
    [self setupVideoView];
    // 添加tableView
    [self setupTableView];
    // 获取推荐书籍
    [FNAVGetRecmdCollumns getRecmdColumnsWith:self.item.vid :^(NSArray *itemArray) {
        
        if (itemArray.count > 0) {
            self.itemArray = itemArray;
            [self.tableView reloadData];
        }
    }];

    // 添加监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNoti) name:@"closeBtnClick" object:nil];
    [[NSNotificationCenter defaultCenter]addObserverForName:@"shouldChangeVideo" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        // 取出通知参数
        NSIndexPath *indexPath = note.userInfo[@"index"];
        // 取出模型
        FNAVListItem * item = self.itemArray[indexPath.row];
        // 切换视频更改标题
        [self replacePlayerItemWithVideoUrlStr:item];

    }];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.playerVC.player = nil;
}



-(void)setItem:(FNAVListItem *)item{
    _item = item;
    
    AVPlayerItem * playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:item.mp4_url]];
    AVPlayer * player = [AVPlayer playerWithPlayerItem:playerItem];
    self.playerVC.player = player;
    self.videoTitleLabel .text = item.title;

}

/**
 *  添加Video占位View
 */
-(void)setupVideoView{
    UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FNScreenW, 20)];
    blackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackView];
    // 创建VideoView
    
    UIView * videoView = [[UIView alloc]initWithFrame:CGRectMake(0,20, FNScreenW, videoViewH)];
    self.playerVC.view.frame = videoView.bounds;
    
    // 创建返回button
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"weather_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, backBtnWH, backBtnWH);
    
    // 添加标题label
    self.videoTitleLabel.frame = CGRectMake(backBtnWH, 0, FNScreenW - backBtnWH, backBtnWH);

    [videoView addSubview:self.playerVC.view];
    [videoView addSubview:backBtn];
    
    [videoView addSubview:self.videoTitleLabel];
    [self.view addSubview:videoView];
    [self.playerVC.player play];
    
}

/**
 *  添加tableview
 */
-(void)setupTableView{
    CGRect frame = CGRectMake(0, videoViewH + 20, FNScreenW, FNScreenH - videoViewH - 20);
    UITableView * tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    // 设置背景色
    tableView.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UILabel *label = [[UILabel alloc]init];
    label.text = self.item.title;

    
    
    // 注册cell
    [tableView registerNib:[UINib nibWithNibName:@"FNAVDetailTopicCell" bundle:nil] forCellReuseIdentifier:topicID];
    [tableView registerNib:[UINib nibWithNibName:@"FNAVRecCell" bundle:nil] forCellReuseIdentifier:rcmdID];
    [tableView registerNib:[UINib nibWithNibName:@"FNAVideoDecriptionCell" bundle:nil] forCellReuseIdentifier:descripID];
    [tableView registerNib:[UINib nibWithNibName:@"FNAVMoreCell" bundle:nil] forCellReuseIdentifier:moreID];
    
    // 设置数据源和代理
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];

    self.tableView = tableView;
}



#pragma mark - 通知处理
-(void)receiveNoti{
    [UIView animateWithDuration:0.5 animations:^{
       self.subTableViewVC.view.frame = CGRectMake(0, FNScreenH, FNScreenW, FNScreenH - videoViewH -20);
    }completion:^(BOOL finished) {
        if(finished){
            [self.subTableViewVC.view removeFromSuperview];
        }
    }];
}




-(void)dealloc{
    // 移除监听
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark - 按钮点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.playerVC.player pause];
}


#pragma mark - 抽取的方法
/**
 *  重新设置播放器内容
 */
-(void)replacePlayerItemWithVideoUrlStr:(FNAVListItem *)item {
    // 重新设置播放器内容
    AVPlayerItem * playItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:item.mp4_url]];
    [self.playerVC.player replaceCurrentItemWithPlayerItem:playItem];
    [self.playerVC.player play];

    // 重新设置视频标题
    self.videoTitleLabel.text = item.title;
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2 ) {
        if (self.itemArray.count) {
            return 4;
        }else{
            return 0;
        }
        
    }else{
        return 1;
    }
 
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.section == 0) { // 视频详情
            FNAVideoDecriptionCell * cell = [tableView dequeueReusableCellWithIdentifier:descripID];
            cell.item = self.item;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            __weak typeof(self) weakSelf = self;
            
            cell.CellBtnClickBlock = ^(FNAVListItem* item){
                [tableView reloadData];
                weakSelf.isSelected = !weakSelf.isSelected;
            };
            
            return cell;
            
        }else if(indexPath.section == 1){ // 话题详情
            
            FNAVDetailTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:topicID];
            
            cell.item = _item;
            
            return cell;
        }else if(indexPath.section == 2){ // 推荐视频
            FNAVRecCell * cell = [tableView dequeueReusableCellWithIdentifier:rcmdID];
            cell.item = self.itemArray[indexPath.row];
            return cell;
            
        }else if(indexPath.section == 3){ // 加载更多
            FNAVMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:moreID];
            return cell;
            
        }else{ // 评论
            UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"subtitle"];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.detailTextLabel.text = @"第四组的cell";
            return cell;
        }

}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
        if (indexPath == 0) {
            return 90;
        }else if (indexPath.section == 1) {
            return 80;
        }else if(indexPath.section == 2){
            return 90;
        }else {
            return 50;
        }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        if (indexPath.section == 0) {
            if (self.item.decriptionCellHeight > 90 && self.isSelected) {
                return self.item.decriptionCellHeight;
            }else {
                return 90;
            }
        }else if (indexPath.section == 1) {
            return 80;
        }else if(indexPath.section == 2){
            return 90;
        }else {
            return 50;
        }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
    if(indexPath.section ==1){
        // 取消选中状态
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    if (indexPath.section == 2) {
        // 取出模型
        FNAVListItem * selItem = self.itemArray[indexPath.row];
        // 异步主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            // 重新设置播放器内容和标题
            
            [self replacePlayerItemWithVideoUrlStr:selItem];
        });
        
        // 取出cell
        FNAVRecCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.videoTitleLabel.highlightedTextColor = [UIColor redColor];
        
    }
    
    if (indexPath.section == 3) {
        if (!self.subTableViewVC.view.superview) {
            [self.view addSubview:self.subTableViewVC.view];
        }
        // 移动位置
        [UIView animateWithDuration:0.5 animations:^{
            self.subTableViewVC.view.frame = CGRectMake(0, videoViewH + 20, FNScreenW, FNScreenH - videoViewH -20);
        }];
        // 取消选中状态
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
    }
    
    
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 2) {
        UIView * view = [[UIView alloc]init];
        view.frame = CGRectMake(0 , 0, FNScreenW, 50);
        view.backgroundColor = [UIColor whiteColor];
        
        // 设置推荐label
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 50)];
        label.text = @"推荐";
        
        // 设置分割线
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, FNScreenW, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1];
        
        [view addSubview:lineView];
        [view addSubview:label];
        return view;

    }else return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 50;
    }else {
        return 0;
    }
}


@end
