//
//  QPDigitalKeyboardView.h
//  QuickPay
//
//  Created by Nie on 2016/11/1.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    WeiXinPayType,    /** 微信支付 */
    AlipayType,    /** 支付宝支付 */
} PayType;// 支付方式

@protocol  QPDigitalKeyboardViewDelegate <NSObject>
- (void)closeBtnClickDelegate;
- (void)payBtnClickDelegate:(PayType)type amoumt:(NSString*)amount;
@end
@interface QPDigitalKeyboardView : UIView
@property (nonatomic , weak) id <QPDigitalKeyboardViewDelegate>delegate;

@end
