//
//  FNSettingViewController.m
//  FourNews
//
//  Created by caroline on 16/5/6.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNSettingViewController.h"
#import "FNMeController.h"
#import "FNFileManager.h"
#import <SVProgressHUD.h>
#define cachePath  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]
@interface FNSettingViewController ()

@end

@implementation FNSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    // 设置tableView组间距
    // 如果是分组样式,默认每一组都会有头部和尾部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    // 设置顶部额外滚动区域-25
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
   }
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setMemorySize];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSIndexPath * index = [NSIndexPath indexPathForRow:5 inSection:3];
    if (indexPath == index) {
        
        [FNFileManager clearDiskWithFilePath:cachePath];
    }
    [self setMemorySize];
}

-(void)setMemorySize
{
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:3]];
    //设置显示的缓存大小
    for (UILabel * lable  in cell.contentView.subviews) {
        if (![lable.text isEqual: @"清理缓存"]) {
            NSInteger  size = [FNFileManager getSizeWithFilePath:cachePath];
            NSLog(@"%zd",size);
            NSLog(@"%@",lable.text);
            lable.text = [self getFileSizeStr:(int)size];
            [self.tableView reloadData];
        }
    }

}



- (NSString *)getFileSizeStr:(int)totalSize
{
    
    NSString *str = @"已经清空";
    if (totalSize > 1000 * 1000) { // MB
        CGFloat totalSizeF = totalSize / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"%.1fMB",totalSizeF];
    } else if (totalSize > 1000) { // KB
        CGFloat totalSizeF = totalSize / 1000.0;
        str = [NSString stringWithFormat:@"%.1fKB",totalSizeF];
    } else if (totalSize > 0) { // B
        str = [NSString stringWithFormat:@"%dB",totalSize];
    }
    
    return str;
}


@end
