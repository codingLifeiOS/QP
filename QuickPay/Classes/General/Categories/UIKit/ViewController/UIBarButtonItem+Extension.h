//
//  UIBarButtonItem+Extension.h
//  QuickPay
//
//  Created by 周卫斌 on 15/10/14.
//  Copyright © 2015年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title;
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title;
@end
