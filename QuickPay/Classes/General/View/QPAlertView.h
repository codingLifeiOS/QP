//
//  QuickPayAlertView.h
//  QuickPay
//
//  Created by Nie on 15/8/6.
//  Copyright (c) 2015年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QPAlertView : UIView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /**<>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;

+ (instancetype)alertViewWithMessage:(NSString *)message;
+ (instancetype)alertViewWithMessage:(NSString *)message customButtonTitle:(NSString *)title;

@property(nonatomic,assign) id /**<>*/ delegate;    // weak reference
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *message;   // secondary explanation text


- (void)show;

@end


@protocol MISAlertViewDelegate <NSObject>

- (void)misAlertView:(QPAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
