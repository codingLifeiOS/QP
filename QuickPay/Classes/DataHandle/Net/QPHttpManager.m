//
//  QPHttpManager.m
//  QuickPay
//
//  Created by Nie on 2016/11/4.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPHttpManager.h"
#import "QPUserModel.h"
#import "QPFileLocationManager.h"
@implementation QPHttpManager

+ (void)getQRcodeString:(NSString *)amount
                 PayTye:(NSString *)type
             Completion:(QPRequestSuccessHandler)handler
                failure:(QPRequestFailureHandler)failhandler{
    
    QPUserModel *userModel = [QPHttpManager getUserModel];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:amount forKey:@"amount"];
    [params setValue:type forKey:@"payType"];
    [params setValue:[QPUtils getMer_code] forKey:@"merchno"];
    [params setValue:userModel.bank_account_certno forKey:@"certno"];
    [params setValue:userModel.bank_account_name forKey:@"account_name"];
    [params setValue:userModel.card_number forKey:@"accountno"];
    //  @"signature":@"C704F7D128812267F4675D5D016CA962",
    // 本处对所有非空参数进行Md5 加密
    if (userModel.signatureKey) {
        NSString *signbefore = [NSString stringFromDic:params andBaseString:userModel.signatureKey];
        NSLog(@"签名加密前%@",signbefore);
//        NSString *UTF8str = [signbefore stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

//        NSLog(@"签名加密前UTF8编码%@",UTF8str);
//        NSString *ISO88591str =  [NSString stringWithFormat:@"%s",[NSString UnicodeToISO88591:UTF8str]];
//        
//        NSLog(@"签名加密前ISO88591编码%@",ISO88591str);

        NSString *sign = [NSString MD5:signbefore];
        NSLog(@"签名加密后%@",sign);
        [params setObject:sign forKey:@"signature"];
    }
    
    [QPHttpRequest POSTWithData:QP_CreateOrder params:nil body:[[NSString convertToJSONData:params] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        handler ? handler(error) : nil;
    }];
}

+ (void)getOrderDetail:(NSString *)orderId
            Completion:(QPRequestSuccessHandler)handler
               failure:(QPRequestFailureHandler)failhandler{
    
    
    QPUserModel *userModel = [QPHttpManager getUserModel];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:orderId forKey:@"traceno"];
    [params setValue:[QPUtils getMer_code] forKey:@"merchno"];
    // 本处对所有非空参数进行Md5 加密
    if (userModel.signatureKey) {
        NSString *signbefore = [NSString stringFromDic:params andBaseString:userModel.signatureKey];
        NSString *sign = [NSString MD5:signbefore];
        [params setObject:sign forKey:@"signature"];
    }
    
    [QPHttpRequest POSTWithData:QP_OrderDetail params:nil body:[[NSString convertToJSONData:params] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        handler ? handler(error) : nil;
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

+ (void)getMerinfoCompletion:(QPRequestSuccessHandler)handler
                     failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          };
    [QPHttpRequest POSTWithData:QP_GetMerInfo params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        handler ? handler(error) : nil;
        
    }];
}

+ (QPUserModel*)getUserModel{
    
    NSString *path = [QPFileLocationManager getUserDirectory];
    NSString *filePath = [path stringByAppendingPathComponent:@"merInfo.data"];
    NSMutableArray *merInfolist = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return merInfolist[0];
    
}

@end
