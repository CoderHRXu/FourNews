//
//  FNMeNavController.m
//  FourNews
//
//  Created by caroline on 16/5/6.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNMeNavController.h"
#import "FNMeController.h"
#import "FNSettingViewController.h"
@interface FNMeNavController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic ,strong) id popDelegate;
@end

@implementation FNMeNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage * image = [UIImage imageNamed:@"top_navigation_background"];
    //获取指定类下面的导航条
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[FNMeNavController class]]];
    [bar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

    
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    //设置导航控制器的代理
    self.delegate = self;
    
    //添加拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
    

}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //当前控制器是否为根控制器
       return self.childViewControllers.count != 1;
}

//导航控制器的View显示完毕时调用
//viewController要显示的控制器.
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //判断当前显示的控制器是否为根控制器.
    if(self.childViewControllers.count == 1) {
        //如果是根控制器,设回手势代理
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }
}

//重新设置返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count != 0) {
        NSLog(@"非根控制器");
        //设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginImage:[UIImage imageNamed:@"top_navigation_back"]] style:0 target:self action:@selector(back)];
        [viewController.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageNamed:@"top_navigation_back_highlighted"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        
        
        
        //重写了系统返回,那么系统的侧滑返回功能就会失效
        self.interactivePopGestureRecognizer.delegate = nil;
        
        //当push时隐藏系统底部Tabbar
        viewController.hidesBottomBarWhenPushed = YES;
//        if ([viewController isKindOfClass:[FNSettingViewController class]]) {
//            viewController.navigationController.title = @"设 置";
//        }
    }

    [super pushViewController:viewController animated:animated];

}

- (void)back {
    //返回上一级
    [self popViewControllerAnimated:YES];
}

@end
