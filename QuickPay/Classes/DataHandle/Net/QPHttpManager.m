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
        failhandler ? failhandler(error) : nil;
        
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
        
        failhandler ? failhandler(error) : nil;
        
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
        
        failhandler ? failhandler(error) : nil;
        
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
//        failhandler ? failhandler(error) : nil;
//        
//    }];
//}


+ (void)getQRcodeString:(NSString *)amount
                 PayTye:(NSString *)type
             Completion:(QPRequestSuccessHandler)handler
                failure:(QPRequestFailureHandler)failhandler{
    
//    QPUserModel *userModel = [QPHttpManager getUserModel];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%0.f",[amount floatValue]*100] forKey:@"amount"];
    [params setValue:type forKey:@"pay_type"];
    [params setValue:[QPUtils getMer_code] forKey:@"mer_code"];
    [params setValue:@"QRCODE" forKey:@"payment_method"];
    [params setValue:[QPUtils getToken] forKey:@"token"];
//     本处对所有非空参数进行Md5 加密
    if ([QPUtils getSignature_key]) {
        NSString *signbefore = [NSString stringFromDic:params andBaseString:[QPUtils getSignature_key]];
        NSString *sign = [NSString MD5:signbefore];
       [params setValue:sign forKey:@"signature"];
    }
    
    [QPHttpRequest POSTWithData:QP_Create_Order params:nil body:[[NSString convertToJSONData:params] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        failhandler ? failhandler(error) : nil;
    }];
}

+ (void)creditCardPaymentByScanString:(NSString *)amount
                                 PayTye:(NSString *)type
                                 Authno:(NSString*)authno
                             Completion:(QPRequestSuccessHandler)handler
                                failure:(QPRequestFailureHandler)failhandler{
    
//    QPUserModel *userModel = [QPHttpManager getUserModel];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%0.f",[amount floatValue]*100] forKey:@"amount"];
    [params setValue:type forKey:@"pay_type"];
    [params setValue:authno forKey:@"authno"];
    [params setValue:[QPUtils getMer_code] forKey:@"mer_code"];
    [params setValue:@"SK" forKey:@"payment_method"];
    [params setValue:[QPUtils getToken] forKey:@"token"];
    //     本处对所有非空参数进行Md5 加密
    if ([QPUtils getSignature_key]) {
        NSString *signbefore = [NSString stringFromDic:params andBaseString:[QPUtils getSignature_key]];
        NSString *sign = [NSString MD5:signbefore];
       [params setValue:sign forKey:@"signature"];
    }
    
    [QPHttpRequest POSTWithData:QP_Create_Order_ReverseScan params:nil body:[[NSString convertToJSONData:params] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        failhandler ? failhandler(error) : nil;
    }];
}

+ (void)orderquery:(NSString *)orderSn
            Completion:(QPRequestSuccessHandler)handler
               failure:(QPRequestFailureHandler)failhandler{
    
    
//    QPUserModel *userModel = [QPHttpManager getUserModel];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:orderSn forKey:@"order_sn"];
    [params setValue:[QPUtils getMer_code] forKey:@"mer_code"];
    [params setValue:[QPUtils getToken] forKey:@"token"];
    //     本处对所有非空参数进行Md5 加密
    if ([QPUtils getSignature_key]) {
        NSString *signbefore = [NSString stringFromDic:params andBaseString:[QPUtils getSignature_key]];
        NSString *sign = [NSString MD5:signbefore];
        [params setValue:sign forKey:@"signature"];
        
    }
    
    [QPHttpRequest POSTWithData:QP_Qrder_Query params:nil body:[[NSString convertToJSONData:params] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        failhandler ? failhandler(error) : nil;
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
        
        failhandler ? failhandler(error) : nil;
        
    }];
}

+ (void)getSettlementRecordsCompletion:(QPRequestSuccessHandler)handler
                     failure:(QPRequestFailureHandler)failhandler{
    
    NSDate *  senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //一周的秒数
    NSTimeInterval time = 3 * 24 * 60 * 60;
    //下周就把"-"去掉
    NSDate *lastWeek = [date dateByAddingTimeInterval:-time];
    NSString *startDate =  [dateFormatter stringFromDate:lastWeek];
    
    NSLog(@"locationString startDate:%@ %@",locationString,startDate);
    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          @"start_date":startDate,
                          @"end_date":locationString,
                          };
    [QPHttpRequest POSTWithData:QP_GetSettlement_Records params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        failhandler ? failhandler(error) : nil;
        
    }];
}


+ (void)getOrderRecordsBegin:(NSString*)beginTime
                         End:(NSString*)endTime
                  Completion:(QPRequestSuccessHandler)handler
                     failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          @"start_date":beginTime,
                          @"end_date":endTime,
                          };
    [QPHttpRequest POSTWithData:QP_GetOrder_Records params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        failhandler ? failhandler(error) : nil;
        
    }];
}

+ (void)getAdImagesCompletion:(QPRequestSuccessHandler)handler
                     failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          };
    [QPHttpRequest POSTWithData:QP_GetAdImages params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        failhandler ? failhandler(error) : nil;
        
    }];
}

+ (void)getNewsCompletion:(QPRequestSuccessHandler)handler
                     failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          };
    [QPHttpRequest POSTWithData:QP_GetNews params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        failhandler ? failhandler(error) : nil;
        
    }];
}

+ (void)getRateCompletion:(QPRequestSuccessHandler)handler
                  failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          };
    [QPHttpRequest POSTWithData:QP_GetRate params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        failhandler ? failhandler(error) : nil;
        
    }];
}

+ (void)getAgreementCompletion:(QPRequestSuccessHandler)handler
                       failure:(QPRequestFailureHandler)failhandler{
    
    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"token":[QPUtils getToken],
                          };
    [QPHttpRequest POSTWithData:QP_GetAgreement params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding] success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        failhandler ? failhandler(error) : nil;
        
    }];
}

+ (void)uploadImage:(UIImage*)image
         Completion:(QPRequestSuccessHandler)handler
            failure:(QPRequestFailureHandler)failhandler{
    
    [QPHttpRequest UploadImageWithUrl:QP_Upload_Logo params:nil imageParams:image success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
         failhandler ? failhandler(error) : nil;
        
    }];
}

+ (void)changeLogoWithUrl:(NSString *)imageUrl
               Completion:(QPRequestSuccessHandler)handler
                  failure:(QPRequestFailureHandler)failhandler{


    NSDictionary *dic = @{@"mer_code":[QPUtils getMer_code],
                          @"new_logo":imageUrl,
                          @"token":[QPUtils getToken]
                          };
    [QPHttpRequest POSTWithData:QP_Update_Mer_Logo params:nil body:[[NSString convertToJSONData:dic] dataUsingEncoding:NSUTF8StringEncoding]success:^(NSDictionary *success) {
        
        handler ? handler(success) : nil;
        
    } failure:^(NSError *error) {
        
        failhandler ? failhandler(error) : nil;
        
    }];

}

+ (QPUserModel*)getUserModel{
    
    NSString *path = [QPFileLocationManager getUserDirectory];
    NSString *filePath = [path stringByAppendingPathComponent:@"merInfo.data"];
    NSMutableArray *merInfolist = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return merInfolist[0];
}


@end
