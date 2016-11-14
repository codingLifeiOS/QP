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

+ (void)changePassWordWitholdpassword:(NSString *)oldpassword
                          newpassword:(NSString *)newpassword
                           Completion:(QPRequestSuccessHandler)handler
                              failure:(QPRequestFailureHandler)failhandler{

    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          @"password_old":oldpassword,
                          @"password_new":newpassword,
                          };
    [QPHttpRequest POSTWithData:QP_Modify_Password params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        handler ? handler(error) : nil;
        
    }];


}
//+ (void)getMerchantCode:(QPRequestSuccessHandler)handler
//                failure:(QPRequestFailureHandler)failhandler;
//{
//    NSString * url = [NSString stringWithFormat:@"%@/%@",QP_GetFixedQR,[QPUtils getMer_code]];
//    [QPHttpRequest POSTWithData:url params:nil body:nil success:^(NSDictionary *success) {
//        handler ? handler(success) : nil;
//        
//    } failure:^(NSError *error) {
//        
//        handler ? handler(error) : nil;
//        
//    }];
//}


+ (void)getQRcodeString:(NSString *)amount
                 PayTye:(NSString *)type
             Completion:(QPRequestSuccessHandler)handler
                failure:(QPRequestFailureHandler)failhandler{
    
    QPUserModel *userModel = [QPHttpManager getUserModel];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:amount forKey:@"amount"];
    [params setValue:type forKey:@"payType"];
    [params setValue:[QPUtils getMer_code] forKey:@"merchno"];
//    [params setValue:userModel.bank_account_certno forKey:@"certno"];
    [params setValue:@"QRCODE" forKey:@"payment_method"];
    [params setValue:[QPUtils getToken] forKey:@"token"];

    //  @"signature":@"C704F7D128812267F4675D5D016CA962",
    // 本处对所有非空参数进行Md5 加密
    if (userModel.signatureKey) {
        
        NSString *signbefore = [NSString stringFromDic:params andBaseString:userModel.signatureKey];
        NSLog(@"签名加密前%@",signbefore);
        
//        NSString *UTF8str = [signbefore stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"签名加密前UTF8编码%@",UTF8str);
//
//        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//        NSString *gbkstr = [[NSString alloc] initWithData:[NSString dataForHexString:UTF8str] encoding:gbkEncoding];
//        NSLog(@"签名加密前gbk编码%@",gbkstr);
        
//        NSString *ISO88591str =  [NSString stringWithFormat:@"%s",[NSString UnicodeToISO88591:UTF8str]];
///        NSLog(@"签名加密前ISO88591编码%@",ISO88591str);

        NSString *sign = [NSString MD5:signbefore];
        NSLog(@"签名加密后%@",sign);
        [params setObject:sign forKey:@"signature"];
    }
    
    [QPHttpRequest POSTWithData:QP_Create_Order params:nil body:[[NSString convertToJSONData:params] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        handler ? handler(error) : nil;
    }];
}

+ (void)orderquery:(NSString *)orderSn
            Completion:(QPRequestSuccessHandler)handler
               failure:(QPRequestFailureHandler)failhandler{
    
    
    QPUserModel *userModel = [QPHttpManager getUserModel];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:orderSn forKey:@"order_sn"];
    [params setValue:[QPUtils getMer_code] forKey:@"merchno"];
    [params setValue:[QPUtils getToken] forKey:@"token"];

    // 本处对所有非空参数进行Md5 加密
    if (userModel.signatureKey) {
        NSString *signbefore = [NSString stringFromDic:params andBaseString:userModel.signatureKey];
        NSString *sign = [NSString MD5:signbefore];
        [params setObject:sign forKey:@"signature"];
    }
    
    [QPHttpRequest POSTWithData:QP_Qrder_Query params:nil body:[[NSString convertToJSONData:params] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        handler ? handler(error) : nil;
    }];
}

+ (void)getBindBankCcardCompletion:(QPRequestSuccessHandler)handler
                     failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          };
    [QPHttpRequest POSTWithData:QP_GetBind_bank_Card params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        handler ? handler(success) : nil;

    } failure:^(NSError *error) {
        
        handler ? handler(error) : nil;
        
    }];
}

+ (void)getSettlementRecordsCompletion:(QPRequestSuccessHandler)handler
                     failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          @"start_date":@"2016-11-13",
                          @"end_date":@"2016-11-13",
                          };
    [QPHttpRequest POSTWithData:QP_GetSettlement_Records params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        handler ? handler(error) : nil;
        
    }];
}


+ (void)getOrderRecordsCompletion:(QPRequestSuccessHandler)handler
                     failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          @"start_date":@"2016-11-10",
                          @"end_date":@"2016-11-13",
                          };
    [QPHttpRequest POSTWithData:QP_GetOrder_Records params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
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
