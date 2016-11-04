//
//  QPRequestSerVice.m
//  QuickPay
//
//  Created by Nie on 2016/11/4.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPRequestSerVice.h"
#import "QPHttpRequest.h"
@implementation QPRequestSerVice

+ (void)setHeader:(NSDictionary <NSString *, NSString *> *)headerKV {
    
    [QPHttpRequest setHeader:^(AFHTTPRequestSerializer *requestSerializer) {
        for (NSString *key in headerKV.allKeys) {
            [requestSerializer setValue:[headerKV valueForKey:key] forHTTPHeaderField:key];
        }
    }];
}

// 此处设置请求头
+ (void)setReqHeader {
    
}

+ (void)GET:(NSString *)url
      param:(id)param
    success:(QPRequestSuccessHandler)successHandler
    failure:(QPRequestFailureHandler)failureHandler {
    
    id paramsJSON = [param mj_JSONObject];
    
    [self setReqHeader];
    [QPHttpRequest GET:url params:paramsJSON success:^(id responseData) {
        NSLog(@"GET:%@ -->请求成功，响应结果-->%@", url, responseData);
        
        successHandler ? successHandler(responseData) : nil;
        
    } failure:^(NSError *error) {
        NSLog(@"GET:%@ -->请求失败，错误:%@", url, error);
        failureHandler ? failureHandler(error) : nil;
    }];
}
+ (void)POST:(NSString *)url
       param:(id)param
     success:(QPRequestSuccessHandler)successHandler
     failure:(QPRequestFailureHandler)failureHandler {
    
    id paramsJSON = [param mj_JSONObject];
    
    [self setReqHeader];
    [QPHttpRequest POST:url params:paramsJSON success:^(id responseData) {
        NSLog(@"POST:%@ -->请求成功，响应结果-->%@", url, responseData);
        
        successHandler ? successHandler(responseData) : nil;
        
    } failure:^(NSError *error) {
        NSLog(@"POST:%@ -->请求失败，错误:%@", url, error);
        failureHandler ? failureHandler(error) : nil;
    }];
}
@end
