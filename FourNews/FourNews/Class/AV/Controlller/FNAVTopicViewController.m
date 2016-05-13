//
//  FNAVVideoViewController.m
//  FourNews
//
//  Created by haoran on 16/4/17.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVTopicViewController.h"

@interface FNAVTopicViewController ()

@end

@implementation FNAVTopicViewController

-(void)setItem:(FNAVListItem *)item{
    _item = item;

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor yellowColor];


  
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}


@end
