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

+ (void)getQRcodeString:(NSString *)parentid
             Completion:(QPRequestSuccessHandler)handler
                failure:(QPRequestFailureHandler)failhandler{
    
    QPUserModel *userModel = [QPHttpManager getUserModel];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"10" forKey:@"amount"];
    [params setValue:@"2" forKey:@"payType"];
    [params setValue:[QPUtils getMer_code] forKey:@"merchno"];
    [params setValue:userModel.bank_account_certno forKey:@"certno"];
    [params setValue:userModel.bank_account_name forKey:@"account_name"];
    [params setValue:userModel.card_number forKey:@"accountno"];
     //  @"signature":@"C704F7D128812267F4675D5D016CA962",
     // 本处对所有非空参数进行Md5 加密
    if (userModel.signatureKey) {
        NSString *sign = [NSString MD5:[NSString stringFromDic:params andBaseString:userModel.signatureKey]];
        [params setObject:sign forKey:@"signature"];
    }
    
    [QPHttpRequest POSTWithData:QP_OrderCP params:nil body:[[NSString convertToJSONData:params] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
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
