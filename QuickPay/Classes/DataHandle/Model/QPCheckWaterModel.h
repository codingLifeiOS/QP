//
//  QPCheckWaterModel.h
//  QuickPay
//
//  Created by Nie on 2016/11/23.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MODEL_KEY_ID  @"id"
#define MODEL_KEY_ARENA_CODE  @"arena_code"
#define MODEL_KEY_CREATE_DATE  @"create_date"
#define MODEL_KEY_MODIFY_DATE  @"modify_date"
#define MODEL_KEY_TOTAL_AMOUNT  @"total_amount"
#define MODEL_KEY_ORDER_SN  @"order_sn"
#define MODEL_KEY_PRODUCT_NAME  @"product_name"
#define MODEL_KEY_SOURCE  @"source"
#define MODEL_KEY_CERTNO  @"certno"
#define MODEL_KEY_PAYMENT_STATUS  @"payment_status"
#define MODEL_KEY_ACCOUNT_NAME  @"account_name"
#define MODEL_KEY_ACCOUNTNO  @"accountno"
#define MODEL_KEY_PAY_TYPE  @"pay_type"
@interface QPCheckWaterModel : NSObject

@property(nonatomic, copy)NSString *checkWaterid;
@property(nonatomic, copy)NSString *arena_code;
@property(nonatomic, copy)NSString *create_date;
@property(nonatomic, copy)NSString *modify_date;
@property(nonatomic, copy)NSString *total_amount;
@property(nonatomic, copy)NSString *order_sn;
@property(nonatomic, copy)NSString *product_name;
@property(nonatomic, copy)NSString *source;
@property(nonatomic, copy)NSString *certno;
@property(nonatomic, copy)NSString *payment_status;
@property(nonatomic, copy)NSString *account_name;
@property(nonatomic, copy)NSString *accountno;
@property(nonatomic, copy)NSString *pay_type;

- (id)initWithDictionary:(NSDictionary*)params;
- (NSMutableDictionary *)toDictionary;

@end
