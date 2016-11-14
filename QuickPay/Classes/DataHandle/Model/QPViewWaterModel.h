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

@interface QPViewWaterModel : NSObject

@property(nonatomic, retain)NSString *id;
@property(nonatomic, retain)NSString *arena_code;
@property(nonatomic, retain)NSString *create_date;
@property(nonatomic, retain)NSString *modify_date;
@property(nonatomic, retain)NSString *total_amount;
@property(nonatomic, retain)NSString *order_sn;
@property(nonatomic, retain)NSString *product_name;
@property(nonatomic, retain)NSString *source;
@property(nonatomic, retain)NSString *certno;
@property(nonatomic, retain)NSString *payment_status;
@property(nonatomic, retain)NSString *account_name;
@property(nonatomic, retain)NSString *accountno;

- (id)initWithDictionary:(NSDictionary*)params;
- (NSMutableDictionary *)toDictionary;

@end
