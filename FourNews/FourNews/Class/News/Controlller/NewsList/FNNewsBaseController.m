//
//  FNNewsBaseController.m
//  FourNews
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#define YJScreenW [UIScreen mainScreen].bounds.size.width
#define YJScreenH [UIScreen mainScreen].bounds.size.height
#define YJConH YJScreenH - 64 - self.titleScrollView.frame.size.height - 49
#import "FNNewsBaseController.h"


@interface FNNewsBaseController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *titleBtnArray;

@property (nonatomic, assign) BOOL isSet;


@end

@implementation FNNewsBaseController

- (NSMutableArray *)titleBtnArray
{
    if (!_titleBtnArray){
        self.titleBtnArray = [[NSMutableArray alloc] init];
    }
    return _titleBtnArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isSet == NO) {
        _isSet = YES;
        [self setTitleScrollView];
        [self setTitleScrollViewBtn];
        [self setContentScrollView];
    }
}

- (void)setTitleScrollView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, YJScreenW, 35)];
    titleScrollView.backgroundColor = [UIColor whiteColor];
    
    CGFloat W = self.childViewControllers.count * YJScreenW / 4;
    titleScrollView.contentSize = CGSizeMake(W, 0);
    titleScrollView.showsHorizontalScrollIndicator = NO;
    titleScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:titleScrollView];
    self.titleScrollView = titleScrollView;
}

- (void)setTitleScrollViewBtn
{
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *VC = self.childViewControllers[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.titleBtnArray addObject:btn];
        CGFloat X = YJScreenW/4 * i;
        btn.frame = CGRectMake(X, 0, YJScreenW/4, 35);
        btn.tag = i;
        if (btn.tag == 0) {
            self.selectedBtn = btn;
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
        } else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [btn setTitle:VC.title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:btn];
    }
}

- (void)titleViewBtnClick:(UIButton *)btn
{
    self.selectedBtn.transform = CGAffineTransformIdentity;
    self.selectedBtn.selected = NO;
    [self.selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.selected = YES;
    self.selectedBtn = btn;
    [self.selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.contentScrollView.contentOffset = CGPointMake(YJScreenW * btn.tag, 0);
    
    self.selectedBtn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    CGFloat offSetX = 0;
    if (btn.center.x < YJScreenW/2) {
        offSetX = 0;
    }else if ((self.titleScrollView.contentSize.width - btn.center.x) < YJScreenW/2) {
        offSetX = self.titleScrollView.contentSize.width - YJScreenW;
    } else {
        offSetX = btn.center.x - YJScreenW/2;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    
    CGFloat contH = YJScreenH - 64 + self.titleScrollView.frame.size.height;
    UIViewController *VC = self.childViewControllers[btn.tag];
    CGFloat X = YJScreenW * btn.tag;
    VC.view.frame = CGRectMake(X, 0, YJScreenW, contH);
    [self.contentScrollView addSubview:VC.view];
}

- (void)setContentScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat contW = YJScreenW;
//    CGFloat contH = YJScreenH - 64 - self.titleScrollView.frame.size.height - 49;
    CGFloat contY = 64 + self.titleScrollView.frame.size.height;
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.delegate = self;
    contentScrollView.frame = CGRectMake(0, contY, contW, YJConH);
    contentScrollView.backgroundColor = [UIColor grayColor];
    
    CGFloat CW = self.childViewControllers.count * YJScreenW;
    contentScrollView.contentSize = CGSizeMake(CW, 0);
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.pagingEnabled = YES;
    [self.view addSubview:contentScrollView];
    
    self.contentScrollView = contentScrollView;
    
//    for (int i = 0; i < self.childViewControllers.count; i++) {
//        UIViewController *VC = self.childViewControllers[i];
//        CGFloat X = YJScreenW * i;
//        VC.view.frame = CGRectMake(X, 0, YJScreenW, contH);
//        [contentScrollView addSubview:VC.view];
//    }
    UIViewController *VC = self.childViewControllers[0];
    CGFloat X = 0;
    VC.view.frame = CGRectMake(X, 0, YJScreenW, YJConH);
    [self.contentScrollView addSubview:VC.view];
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x<0 | scrollView.contentOffset.x>=(self.titleBtnArray.count-1)*YJScreenW) return;
    
    NSInteger index = scrollView.contentOffset.x / YJScreenW;
    
    UIButton *leftbtnBtn = self.titleBtnArray[index];
    UIButton *rightBtn = self.titleBtnArray[index+1];
    
    CGFloat rightScale = (scrollView.contentOffset.x - index*YJScreenW)/YJScreenW;
    CGFloat leftScale = 1 - rightScale;
    
    rightBtn.transform = CGAffineTransformMakeScale(rightScale*0.3+1, rightScale*0.3+1);
    leftbtnBtn.transform = CGAffineTransformMakeScale(leftScale*0.3+1, leftScale*0.3+1);
    
    [rightBtn setTitleColor:[UIColor colorWithRed:rightScale green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    [leftbtnBtn setTitleColor:[UIColor colorWithRed:leftScale green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / YJScreenW;
    
    UIButton *btn = self.titleBtnArray[index];
    
    [self titleViewBtnClick:btn];
    
    
    UIViewController *VC = self.childViewControllers[btn.tag];
    CGFloat X = YJScreenW * btn.tag;
    VC.view.frame = CGRectMake(X, 0, YJScreenW, YJConH);
    [self.contentScrollView addSubview:VC.view];
}
@end

