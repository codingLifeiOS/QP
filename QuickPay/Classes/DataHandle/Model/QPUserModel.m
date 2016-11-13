//
//  QPUserModel.m
//  QuickPay
//
//  Created by Nie on 16/9/22.
//  Copyright © 2016年 Nie. All rights reserved.
//


#import "QPUserModel.h"

@implementation QPUserModel

- (void)dealloc {
    self.userId = nil;
    self.file_06 = nil;
    self.bank_name = nil;
    self.signatureKey = nil;
    self.arena_address = nil;
    self.arena_password = nil;
    self.file_05 = nil;
    self.bank_account_certno = nil;
    self.single_fee = nil;
    self.bank_account_name = nil;
    self.create_date = nil;
    self.file_04 = nil;
    self.contacts = nil;
    self.arena_name = nil;
    self.bank_account = nil;
    self.rate_t1 = nil;
    self.file_03 = nil;
    self.account_status = nil;
    self.mobile = nil;
    self.trading_time = nil;
    self.arena_code = nil;
    self.file_08 = nil;
    self.card_number = nil;
    self.mid = nil;
    self.modify_date = nil;
    self.arena_phone = nil;
    self.file_02 = nil;
    self.file_07 = nil;
    self.bankno = nil;
    self.weixin_open_id = nil;
    self.rate = nil;
    self.settle_type = nil;
    self.bank_type = nil;
    self.file_01 = nil;
}

- (id)initWithDictionary:(NSDictionary*)params {
   self = [self init];
   if (self) {
     self.userId= [params valueForKey:MODEL_KEY_ID];
     self.file_06 = [params valueForKey:MODEL_KEY_FILE_06];
     self.bank_name = [params valueForKey:MODEL_KEY_BANK_NAME];
     self.signatureKey = [params valueForKey:MODEL_KEY_SIGNATUREKEY];
     self.arena_address = [params valueForKey:MODEL_KEY_ARENA_ADDRESS];
     self.arena_password = [params valueForKey:MODEL_KEY_ARENA_PASSWORD];
     self.file_05 = [params valueForKey:MODEL_KEY_FILE_05];
     self.bank_account_certno = [params valueForKey:MODEL_KEY_BANK_ACCOUNT_CERTNO];
     self.single_fee = [params valueForKey:MODEL_KEY_SINGLE_FEE];
     self.bank_account_name = [params valueForKey:MODEL_KEY_BANK_ACCOUNT_NAME];
     self.create_date = [params valueForKey:MODEL_KEY_CREATE_DATE];
     self.file_04 = [params valueForKey:MODEL_KEY_FILE_04];
     self.contacts = [params valueForKey:MODEL_KEY_CONTACTS];
     self.arena_name = [params valueForKey:MODEL_KEY_ARENA_NAME];
     self.bank_account = [params valueForKey:MODEL_KEY_BANK_ACCOUNT];
     self.rate_t1 = [params valueForKey:MODEL_KEY_RATE_T1];
     self.file_03 = [params valueForKey:MODEL_KEY_FILE_03];
     self.account_status = [params valueForKey:MODEL_KEY_ACCOUNT_STATUS];
     self.mobile = [params valueForKey:MODEL_KEY_MOBILE];
     self.trading_time = [params valueForKey:MODEL_KEY_TRADING_TIME];
     self.arena_code = [params valueForKey:MODEL_KEY_ARENA_CODE];
     self.file_08 = [params valueForKey:MODEL_KEY_FILE_08];
     self.card_number = [params valueForKey:MODEL_KEY_CARD_NUMBER];
     self.mid = [params valueForKey:MODEL_KEY_MID];
     self.modify_date = [params valueForKey:MODEL_KEY_MODIFY_DATE];
     self.arena_phone = [params valueForKey:MODEL_KEY_ARENA_PHONE];
     self.file_02 = [params valueForKey:MODEL_KEY_FILE_02];
     self.file_07 = [params valueForKey:MODEL_KEY_FILE_07];
     self.bankno = [params valueForKey:MODEL_KEY_BANKNO];
     self.weixin_open_id = [params valueForKey:MODEL_KEY_WEIXIN_OPEN_ID];
     self.rate = [params valueForKey:MODEL_KEY_RATE];
     self.settle_type = [params valueForKey:MODEL_KEY_SETTLE_TYPE];
     self.bank_type = [params valueForKey:MODEL_KEY_BANK_TYPE];
     self.file_01 = [params valueForKey:MODEL_KEY_FILE_01];
   }
   return self;
}

- (NSMutableDictionary *)toDictionary {
   NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
   [dic setValue:self.userId forKey:MODEL_KEY_ID];
   [dic setValue:self.file_06 forKey:MODEL_KEY_FILE_06];
   [dic setValue:self.bank_name forKey:MODEL_KEY_BANK_NAME];
   [dic setValue:self.signatureKey forKey:MODEL_KEY_SIGNATUREKEY];
   [dic setValue:self.arena_address forKey:MODEL_KEY_ARENA_ADDRESS];
   [dic setValue:self.arena_password forKey:MODEL_KEY_ARENA_PASSWORD];
   [dic setValue:self.file_05 forKey:MODEL_KEY_FILE_05];
   [dic setValue:self.bank_account_certno forKey:MODEL_KEY_BANK_ACCOUNT_CERTNO];
   [dic setValue:self.single_fee forKey:MODEL_KEY_SINGLE_FEE];
   [dic setValue:self.bank_account_name forKey:MODEL_KEY_BANK_ACCOUNT_NAME];
   [dic setValue:self.create_date forKey:MODEL_KEY_CREATE_DATE];
   [dic setValue:self.file_04 forKey:MODEL_KEY_FILE_04];
   [dic setValue:self.contacts forKey:MODEL_KEY_CONTACTS];
   [dic setValue:self.arena_name forKey:MODEL_KEY_ARENA_NAME];
   [dic setValue:self.bank_account forKey:MODEL_KEY_BANK_ACCOUNT];
   [dic setValue:self.rate_t1 forKey:MODEL_KEY_RATE_T1];
   [dic setValue:self.file_03 forKey:MODEL_KEY_FILE_03];
   [dic setValue:self.account_status forKey:MODEL_KEY_ACCOUNT_STATUS];
   [dic setValue:self.mobile forKey:MODEL_KEY_MOBILE];
   [dic setValue:self.trading_time forKey:MODEL_KEY_TRADING_TIME];
   [dic setValue:self.arena_code forKey:MODEL_KEY_ARENA_CODE];
   [dic setValue:self.file_08 forKey:MODEL_KEY_FILE_08];
   [dic setValue:self.card_number forKey:MODEL_KEY_CARD_NUMBER];
   [dic setValue:self.mid forKey:MODEL_KEY_MID];
   [dic setValue:self.modify_date forKey:MODEL_KEY_MODIFY_DATE];
   [dic setValue:self.arena_phone forKey:MODEL_KEY_ARENA_PHONE];
   [dic setValue:self.file_02 forKey:MODEL_KEY_FILE_02];
   [dic setValue:self.file_07 forKey:MODEL_KEY_FILE_07];
   [dic setValue:self.bankno forKey:MODEL_KEY_BANKNO];
   [dic setValue:self.weixin_open_id forKey:MODEL_KEY_WEIXIN_OPEN_ID];
   [dic setValue:self.rate forKey:MODEL_KEY_RATE];
   [dic setValue:self.settle_type forKey:MODEL_KEY_SETTLE_TYPE];
   [dic setValue:self.bank_type forKey:MODEL_KEY_BANK_TYPE];
   [dic setValue:self.file_01 forKey:MODEL_KEY_FILE_01];
   return dic;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.userId forKey:@"userId"];
    [coder encodeObject:self.bank_account_name forKey:@"bank_account_name"];
    [coder encodeObject:self.card_number forKey:@"card_number"];
    [coder encodeObject:self.bank_account_certno forKey:@"bank_account_certno"];
    [coder encodeObject:self.signatureKey forKey:@"signatureKey"];
    [coder encodeObject:self.bank_name forKey:@"bank_name"];
    [coder encodeObject:self.arena_name forKey:@"arena_name"];
    [coder encodeObject:self.arena_phone forKey:@"arena_phone"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.userId = [coder decodeObjectForKey:@"userId"];
        self.bank_account_name = [coder decodeObjectForKey:@"bank_account_name"];
        self.card_number = [coder decodeObjectForKey:@"card_number"];
        self.bank_account_certno = [coder decodeObjectForKey:@"bank_account_certno"];
        self.signatureKey = [coder decodeObjectForKey:@"signatureKey"];
        self.bank_name = [coder decodeObjectForKey:@"bank_name"];
        self.arena_name = [coder decodeObjectForKey:@"arena_name"];
        self.arena_phone = [coder decodeObjectForKey:@"arena_phone"];
    }
    return self;
}

@end
