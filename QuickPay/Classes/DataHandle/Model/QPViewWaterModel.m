#import "QPViewWaterModel.h"

@implementation QPViewWaterModel

- (void)dealloc {
    self.viewWaterid = nil;
    self.arena_code = nil;
    self.create_date = nil;
    self.modify_date = nil;
    self.total_amount = nil;
    self.order_sn = nil;
    self.product_name = nil;
    self.source = nil;
    self.certno = nil;
    self.payment_status = nil;
    self.account_name = nil;
    self.accountno = nil;
    self.pay_type = nil;
}

- (id)initWithDictionary:(NSDictionary*)params {
   self = [self init];
   if (self) {
     self.viewWaterid = [params valueForKey:MODEL_KEY_ID];
     self.arena_code = [params valueForKey:MODEL_KEY_ARENA_CODE];
     self.create_date = [params valueForKey:MODEL_KEY_CREATE_DATE];
     self.modify_date = [params valueForKey:MODEL_KEY_MODIFY_DATE];
     self.total_amount = [params valueForKey:MODEL_KEY_TOTAL_AMOUNT];
     self.order_sn = [params valueForKey:MODEL_KEY_ORDER_SN];
     self.product_name = [params valueForKey:MODEL_KEY_PRODUCT_NAME];
     self.source = [params valueForKey:MODEL_KEY_SOURCE];
     self.certno = [params valueForKey:MODEL_KEY_CERTNO];
     self.payment_status = [params valueForKey:MODEL_KEY_PAYMENT_STATUS];
     self.account_name = [params valueForKey:MODEL_KEY_ACCOUNT_NAME];
     self.accountno = [params valueForKey:MODEL_KEY_ACCOUNTNO];
     self.pay_type = [params valueForKey:MODEL_KEY_PAY_TYPE];
   }
   return self;
}

- (NSMutableDictionary *)toDictionary {
   NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
   [dic setValue:self.viewWaterid forKey:MODEL_KEY_ID];
   [dic setValue:self.arena_code forKey:MODEL_KEY_ARENA_CODE];
   [dic setValue:self.create_date forKey:MODEL_KEY_CREATE_DATE];
   [dic setValue:self.modify_date forKey:MODEL_KEY_MODIFY_DATE];
   [dic setValue:self.total_amount forKey:MODEL_KEY_TOTAL_AMOUNT];
   [dic setValue:self.order_sn forKey:MODEL_KEY_ORDER_SN];
   [dic setValue:self.product_name forKey:MODEL_KEY_PRODUCT_NAME];
   [dic setValue:self.source forKey:MODEL_KEY_SOURCE];
   [dic setValue:self.certno forKey:MODEL_KEY_CERTNO];
   [dic setValue:self.payment_status forKey:MODEL_KEY_PAYMENT_STATUS];
   [dic setValue:self.account_name forKey:MODEL_KEY_ACCOUNT_NAME];
   [dic setValue:self.accountno forKey:MODEL_KEY_ACCOUNTNO];
   [dic setValue:self.pay_type forKey:MODEL_KEY_PAY_TYPE];

   return dic;
}

@end
