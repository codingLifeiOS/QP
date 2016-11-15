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
    [params setValue:type forKey:@"pay_type"];
    [params setValue:[QPUtils getMer_code] forKey:@"mer_code"];
    [params setValue:@"QRCODE" forKey:@"payment_method"];
    [params setValue:[QPUtils getToken] forKey:@"token"];
//     本处对所有非空参数进行Md5 加密
    if (userModel.signatureKey) {
        NSString *signbefore = [NSString stringFromDic:params andBaseString:userModel.signatureKey];
        NSString *sign = [NSString MD5:signbefore];
       [params setValue:sign forKey:@"signature"];
    }
    
    [QPHttpRequest POSTWithData:QP_Create_Order params:nil body:[[NSString convertToJSONData:params] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        handler ? handler(error) : nil;
    }];
}

+ (void)getQRcodeReverseScanString:(NSString *)amount
                 PayTye:(NSString *)type
             Completion:(QPRequestSuccessHandler)handler
                failure:(QPRequestFailureHandler)failhandler{
    
    QPUserModel *userModel = [QPHttpManager getUserModel];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:amount forKey:@"amount"];
    [params setValue:type forKey:@"pay_type"];
    [params setValue:@"289450956686441058" forKey:@"authno"];
    [params setValue:[QPUtils getMer_code] forKey:@"mer_code"];
    [params setValue:@"SK" forKey:@"payment_method"];
    [params setValue:[QPUtils getToken] forKey:@"token"];
    //     本处对所有非空参数进行Md5 加密
    if (userModel.signatureKey) {
        NSString *signbefore = [NSString stringFromDic:params andBaseString:userModel.signatureKey];
        NSString *sign = [NSString MD5:signbefore];
       [params setValue:sign forKey:@"signature"];
    }
    
    [QPHttpRequest POSTWithData:QP_Create_Order_ReverseScan params:nil body:[[NSString convertToJSONData:params] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
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
    [params setValue:[QPUtils getMer_code] forKey:@"mer_code"];
    [params setValue:[QPUtils getToken] forKey:@"token"];
    //     本处对所有非空参数进行Md5 加密
    if (userModel.signatureKey) {
        NSString *signbefore = [NSString stringFromDic:params andBaseString:userModel.signatureKey];
        NSString *sign = [NSString MD5:signbefore];
        [params setValue:sign forKey:@"signature"];
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
    
    NSDate *  senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    NSLog(@"locationString:%@",locationString);
    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          @"start_date":locationString,
                          @"end_date":locationString,
                          };
    [QPHttpRequest POSTWithData:QP_GetSettlement_Records params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        handler ? handler(error) : nil;
        
    }];
}


+ (void)getOrderRecordsCompletion:(QPRequestSuccessHandler)handler
                     failure:(QPRequestFailureHandler)failhandler{
    
    NSDate *  senddate =[NSDate date];
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          @"start_date":locationString,
                          @"end_date":locationString,
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
