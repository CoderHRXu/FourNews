//
//  FNAVDetailViewController.h
//  FourNews
//
//  Created by haoran on 16/5/7.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNAVListItem;

@interface FNAVDetailViewController : UIViewController
/** 模型 **/
@property (nonatomic, strong) FNAVListItem *item;

@end
