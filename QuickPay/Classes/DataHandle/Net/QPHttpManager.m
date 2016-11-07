//
//  QPHttpManager.m
//  QuickPay
//
//  Created by Nie on 2016/11/4.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPHttpManager.h"

@implementation QPHttpManager

+ (void)getQRcodeString:(NSString *)parentid
             Completion:(QPRequestSuccessHandler)handler
                failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"amount":@"10",
                          @"merchno":@"WA16082911211",
                          @"payType":@"2",
                          @"certno":@"513029198703024837",
                          @"account_name":@"叶精华",
                          @"accountno":@"6225882005731226",
                          @"signature":@"C704F7D128812267F4675D5D016CA962",
                          };
    
    
    [QPHttpRequest uploadPictureData:QP_OrderCP params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSString *success) {
        
    } failure:^(NSString *failure) {
        
    }];
}

+ (void)getOrderDetail:(NSString *)parentid
            Completion:(QPRequestSuccessHandler)handler
               failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"merchno":@"WA16081822481",
                          @"traceno":@"EWA16081822481v16091321591",
                          @"signature":@"D378433564F8DA07A05304BB9A945CE2",
                          };
    
    [QPHttpRequest uploadPictureData:QP_OrderQQ params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSString *success) {
        
    } failure:^(NSString *failure) {
        
    }];
}

+ (void)getLogin:(NSString *)parentid
      Completion:(QPRequestSuccessHandler)handler
         failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"username":@"18583981869",
                          @"password":@"WA16082322231",
                          };
    
    [QPHttpRequest uploadPictureData:QP_Login params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSString *success) {
        
    } failure:^(NSString *failure) {
        
    }];
}

+ (void)getMerinfo:(NSString *)parentid
        Completion:(QPRequestSuccessHandler)handler
           failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"mer_code":@"WA16082322231",
                          @"token":@"693fde898b216024a7bd5f164c5178b9",
                          };
    
    [QPHttpRequest uploadPictureData:QP_GetMerInfo params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSString *success) {
        
    } failure:^(NSString *failure) {
        
    }];
}



@end
