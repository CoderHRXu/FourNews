//
//  FNTopToolView.m
//  FourNews
//
//  Created by xuxisong on 16/4/20.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNTopToolView.h"
@interface FNTopToolView ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;


@end

@implementation FNTopToolView


-(void)awakeFromNib
{
    [self.backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    

}
-(void)backBtnClick
{
    if (self.backBlock) {
        self.backBlock();
    }

}

@end
