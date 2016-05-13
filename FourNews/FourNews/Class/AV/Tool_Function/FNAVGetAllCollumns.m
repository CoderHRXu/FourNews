//
//  FNAVGetAllCollumns.m
//  FourNews
//
//  Created by haoran on 16/4/21.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNAVGetAllCollumns.h"
#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>

@implementation FNAVGetAllCollumns


// 获取每个子页面的标题和节点
+(void)getAllColumns:(void (^)(NSArray *))complete{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://c.m.163.com/nc/video/topiclist.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSMutableArray * responseObject) {
        
        complete(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

@end
