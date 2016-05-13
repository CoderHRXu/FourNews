//
//  FNAVGetRecmdCollumns.h
//  FourNews
//
//  Created by haoran on 16/5/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNAVGetRecmdCollumns : NSObject


+(void)getRecmdColumnsWith:(NSString *)vid :(void (^)(NSArray *))complete;

@end
