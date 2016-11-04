//
//  QPRequestSerVice.h
//  QuickPay
//
//  Created by Nie on 2016/11/4.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  请求成功Handler
 */
typedef void (^QPRequestSuccessHandler)(id responseData);

/**
 *  请求失败Handler
 */
typedef void (^QPRequestFailureHandler) (NSError *error);


@interface QPRequestSerVice : NSObject

/**
 *  设置请求头
 *
 *  @param headerKV  请求头Key-Value
 */
+ (void)setHeader:(NSDictionary <NSString *, NSString *> *)headerKV;

#pragma mark - GET
/**
 *  GET请求 -> 需要自己做模型转换操作
 *
 *  @param url        请求地址
 *  @param param      请求参数 ->字典 或 模型
 *   success    请求成功回调
 *   failure    请求失败回调
 */
+ (void)GET:(NSString *)url
      param:(id)param
    success:(QPRequestSuccessHandler)successHandler
    failure:(QPRequestFailureHandler)failureHandler;


/**
 *  POST请求  -> 需要自己做模型转换操作
 *
 *  @param url        请求地址
 *  @param param      请求参数 ->字典 或 模型
 *   success    请求成功回调
 *   failure    请求失败回调
 */
+ (void)POST:(NSString *)url
       param:(id)param
     success:(QPRequestSuccessHandler)successHandler
     failure:(QPRequestFailureHandler)failureHandler;



@end
