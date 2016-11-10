//
//  QPUserModel.h
//  QuickPay
//
//  Created by Nie on 16/9/22.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MODEL_KEY_ID  @"id"
#define MODEL_KEY_FILE_06  @"file_06"
#define MODEL_KEY_BANK_NAME  @"bank_name"
#define MODEL_KEY_SIGNATUREKEY  @"signatureKey"
#define MODEL_KEY_ARENA_ADDRESS  @"arena_address"
#define MODEL_KEY_ARENA_PASSWORD  @"arena_password"
#define MODEL_KEY_FILE_05  @"file_05"
#define MODEL_KEY_BANK_ACCOUNT_CERTNO  @"bank_account_certno"
#define MODEL_KEY_SINGLE_FEE  @"single_fee"
#define MODEL_KEY_BANK_ACCOUNT_NAME  @"bank_account_name"
#define MODEL_KEY_CREATE_DATE  @"create_date"
#define MODEL_KEY_FILE_04  @"file_04"
#define MODEL_KEY_CONTACTS  @"contacts"
#define MODEL_KEY_ARENA_NAME  @"arena_name"
#define MODEL_KEY_BANK_ACCOUNT  @"bank_account"
#define MODEL_KEY_RATE_T1  @"rate_t1"
#define MODEL_KEY_FILE_03  @"file_03"
#define MODEL_KEY_ACCOUNT_STATUS  @"account_status"
#define MODEL_KEY_MOBILE  @"mobile"
#define MODEL_KEY_TRADING_TIME  @"trading_time"
#define MODEL_KEY_ARENA_CODE  @"arena_code"
#define MODEL_KEY_FILE_08  @"file_08"
#define MODEL_KEY_CARD_NUMBER  @"card_number"
#define MODEL_KEY_MID  @"mid"
#define MODEL_KEY_MODIFY_DATE  @"modify_date"
#define MODEL_KEY_ARENA_PHONE  @"arena_phone"
#define MODEL_KEY_FILE_02  @"file_02"
#define MODEL_KEY_FILE_07  @"file_07"
#define MODEL_KEY_BANKNO  @"bankno"
#define MODEL_KEY_WEIXIN_OPEN_ID  @"weixin_open_id"
#define MODEL_KEY_RATE  @"rate"
#define MODEL_KEY_SETTLE_TYPE  @"settle_type"
#define MODEL_KEY_BANK_TYPE  @"bank_type"
#define MODEL_KEY_FILE_01  @"file_01"

@interface QPUserModel : NSObject

@property(nonatomic, copy)NSString *userId;
@property(nonatomic, copy)NSString *file_06;
@property(nonatomic, copy)NSString *bank_name;
@property(nonatomic, copy)NSString *signatureKey;
@property(nonatomic, copy)NSString *arena_address;
@property(nonatomic, copy)NSString *arena_password;
@property(nonatomic, copy)NSString *file_05;
@property(nonatomic, copy)NSString *bank_account_certno;
@property(nonatomic, copy)NSString *single_fee;
@property(nonatomic, copy)NSString *bank_account_name;
@property(nonatomic, copy)NSString *create_date;
@property(nonatomic, copy)NSString *file_04;
@property(nonatomic, copy)NSString *contacts;
@property(nonatomic, copy)NSString *arena_name;
@property(nonatomic, copy)NSString *bank_account;
@property(nonatomic, copy)NSString *rate_t1;
@property(nonatomic, copy)NSString *file_03;
@property(nonatomic, copy)NSString *account_status;
@property(nonatomic, copy)NSString *mobile;
@property(nonatomic, copy)NSString *trading_time;
@property(nonatomic, copy)NSString *arena_code;
@property(nonatomic, copy)NSString *file_08;
@property(nonatomic, copy)NSString *card_number;
@property(nonatomic, copy)NSString *mid;
@property(nonatomic, copy)NSString *modify_date;
@property(nonatomic, copy)NSString *arena_phone;
@property(nonatomic, copy)NSString *file_02;
@property(nonatomic, copy)NSString *file_07;
@property(nonatomic, copy)NSString *bankno;
@property(nonatomic, copy)NSString *weixin_open_id;
@property(nonatomic, copy)NSString *rate;
@property(nonatomic, copy)NSString *settle_type;
@property(nonatomic, copy)NSString *bank_type;
@property(nonatomic, copy)NSString *file_01;

- (instancetype)initWithDictionary:(NSDictionary*)params;
- (NSMutableDictionary *)toDictionary;

@end
