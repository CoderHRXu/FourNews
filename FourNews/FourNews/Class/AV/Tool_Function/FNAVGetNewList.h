//
//  FNAVGetNewList.h
//  FourNews
//
//  Created by haoran on 16/4/21.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNAVGetNewList : NSObject
+ (void)getAVNewsListWithTid:(NSString *)tid :(NSInteger)pageCount :(void(^)(NSArray *))complete;
@end
