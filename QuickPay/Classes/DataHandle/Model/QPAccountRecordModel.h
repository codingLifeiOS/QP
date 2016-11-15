//
//  QPAccountRecordModel.h
//  QuickPay
//
//  Created by Nie on 16/9/22.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MODEL_KEY_ID  @"id"
#define MODEL_KEY_CREATE_DATE  @"create_date"
#define MODEL_KEY_TOTAL_AMOUNT  @"total_amount"
#define MODEL_KEY_CREATE_DATE_STR  @"create_date_str"
#define MODEL_KEY_BALANCE_STATUS  @"balance_status"
#define MODEL_KEY_ARENA_CODE  @"arena_code"
#define MODEL_KEY_BALANCE_SN  @"balance_sn"
#define MODEL_KEY_ARENA_NAME  @"arena_name"

@interface QPAccountRecordModel : NSObject

@property(nonatomic, copy)NSString *accountRecordId;
@property(nonatomic, copy)NSString *create_date;
@property(nonatomic, copy)NSString *total_amount;
@property(nonatomic, copy)NSString *create_date_str;
@property(nonatomic, copy)NSString *balance_status;
@property(nonatomic, copy)NSString *arena_code;
@property(nonatomic, copy)NSString *balance_sn;
@property(nonatomic, copy)NSString *arena_name;


- (instancetype)initWithDictionary:(NSDictionary*)params;
- (NSMutableDictionary *)toDictionary;

@end
