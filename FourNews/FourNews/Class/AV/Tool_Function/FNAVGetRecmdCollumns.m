//
//  FNAVGetRecmdCollumns.m
//  FourNews
//
//  Created by haoran on 16/5/8.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVGetRecmdCollumns.h"
#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>
#import "FNAVListItem.h"
@implementation FNAVGetRecmdCollumns


+(void)getRecmdColumnsWith:(NSString *)vid :(void (^)(NSArray *))complete{
   
    NSString * urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/detail/%@.html",vid];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        NSMutableArray * itemArry = [FNAVListItem  mj_objectArrayWithKeyValuesArray:responseObject[@"recommend"]];
        
         complete(itemArry);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取失败");
    }];
    
}
@end
