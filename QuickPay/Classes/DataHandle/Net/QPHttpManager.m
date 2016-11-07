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
    
    
    [QPHttpRequest POSTWithData:QP_OrderCP params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
    } failure:^(NSError *error) {
        
    }];
}

+ (void)getOrderDetail:(NSString *)parentid
            Completion:(QPRequestSuccessHandler)handler
               failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"merchno":@"WA16081822481",
                          @"traceno":@"EWA16081822481v16091321591",
                          @"signature":@"D378433564F8DA07A05304BB9A945CE2",
                          };
    
    [QPHttpRequest POSTWithData:QP_OrderQQ params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        
    } failure:^(NSError *error) {
        
    }];
}

+ (void)loginWithUsename:(NSString *)phoneStr
                  Password:(NSString *)password
                Completion:(QPRequestSuccessHandler)handler
                   failure:(QPRequestFailureHandler)failhandler{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phoneStr forKey:@"username"];
    [params setValue:password forKey:@"password"];
    
    [QPHttpRequest POSTWithData:QP_Login params:nil body:[[NSString convertToJSONData:params] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;

    } failure:^(NSError *error) {
        handler ? handler(error) : nil;

    }];
}

+ (void)getMerinfo:(NSString *)parentid
        Completion:(QPRequestSuccessHandler)handler
           failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"mer_code":@"WA16102016219529",
                          @"token":@"f8a2eb521039921c5ed23d7ad479a668",
                          };
    
    [QPHttpRequest POSTWithData:QP_GetMerInfo params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
    } failure:^(NSError *error) {
        
    }];
}



@end
