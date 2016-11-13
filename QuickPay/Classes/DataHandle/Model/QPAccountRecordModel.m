//
//  QPAccountRecordModel.m
//  QuickPay
//
//  Created by Nie on 16/9/22.
//  Copyright © 2016年 Nie. All rights reserved.
//


#import "QPAccountRecordModel.h"

@implementation QPAccountRecordModel

- (void)dealloc {
    self.accountRecordId = nil;
    self.create_date = nil;
    self.total_amount = nil;
    self.create_date_str = nil;
    self.balance_status = nil;
    self.arena_code = nil;
    self.balance_sn = nil;
    self.arena_name = nil;
}

- (instancetype)initWithDictionary:(NSDictionary*)params {
   self = [self init];
   if (self) {
     self.accountRecordId = [NSString stringWithFormat:@"%@",[params valueForKey:MODEL_KEY_ID]];
     self.create_date = [params valueForKey:MODEL_KEY_CREATE_DATE];
     self.total_amount = [params valueForKey:MODEL_KEY_TOTAL_AMOUNT];
     self.create_date_str = [params valueForKey:MODEL_KEY_CREATE_DATE_STR];
     self.balance_status = [params valueForKey:MODEL_KEY_BALANCE_STATUS];
     self.arena_code = [params valueForKey:MODEL_KEY_ARENA_CODE];
     self.balance_sn = [params valueForKey:MODEL_KEY_BALANCE_SN];
     self.arena_name = [params valueForKey:MODEL_KEY_ARENA_NAME];
   }
   return self;
}

- (NSMutableDictionary *)toDictionary {
   NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
   [dic setValue:self.accountRecordId forKey:MODEL_KEY_ID];
   [dic setValue:self.create_date forKey:MODEL_KEY_CREATE_DATE];
   [dic setValue:self.total_amount forKey:MODEL_KEY_TOTAL_AMOUNT];
   [dic setValue:self.create_date_str forKey:MODEL_KEY_CREATE_DATE_STR];
   [dic setValue:self.balance_status forKey:MODEL_KEY_BALANCE_STATUS];
   [dic setValue:self.arena_code forKey:MODEL_KEY_ARENA_CODE];
   [dic setValue:self.balance_sn forKey:MODEL_KEY_BALANCE_SN];
   [dic setValue:self.arena_name forKey:MODEL_KEY_ARENA_NAME];
   return dic;
}

@end
