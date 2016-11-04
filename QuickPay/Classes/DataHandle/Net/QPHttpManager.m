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
    

    [QPRequestSerVice POST:QP_OrderCP param:dic success:^(NSDictionary *responseData) {
        
        handler ? handler(responseData) : nil;
    } failure:^(NSError *error) {
        failhandler ? failhandler(error) : nil;
    }];

}

+ (void)getOrderDetail:(NSString *)parentid
            Completion:(QPRequestSuccessHandler)handler
               failure:(QPRequestFailureHandler)failhandler{

        NSDictionary *dic = @{@"merchno":@"WA16081822481",
                            @"traceno":@"EWA16081822481v16091321591",
                            @"signature":@"D378433564F8DA07A05304BB9A945CE2",
                            };
    [QPRequestSerVice POST:QP_OrderQQ param:dic  success:^(NSDictionary *responseData) {
        
        handler ? handler(responseData) : nil;
    } failure:^(NSError *error) {
        failhandler ? failhandler(error) : nil;
    }];
    


}



@end
