//
//  FNAVRecViewController.h
//  FourNews
//
//  Created by haoran on 16/5/11.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNAVRecViewController : UIViewController
/** 推荐模型数组  */
@property (nonatomic, strong) NSArray *itemArray;
/** 点击了cell更改视频  */
@property (nonatomic, strong) void(^CellSelectBlock)(NSInteger row);
@end
