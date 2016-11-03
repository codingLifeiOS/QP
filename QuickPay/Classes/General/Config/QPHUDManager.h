//
//  QPHUDManager.h
//  QuickPay
//
//  Created by Nie on 16/9/8.
//  Copyright © 2016年 Nie All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QPHUDManager : NSObject

+ (QPHUDManager *)sharedInstance;

- (void)showTipAlertViewWithText:(NSString *)message;

- (void)showTextOnly:(NSString *)text;

- (void)showTextOnly:(NSString *)text
              onView:(UIView *)view;

- (void)showTextOnly:(NSString *)text
              onView:(UIView *)view
       withDelayTime:(NSTimeInterval)delay;

- (void)showTextOnlyWithNoEnabled:(NSString *)text
                           onView:(UIView *)view;

- (void)showTextTips:(NSString *)text
              onView:(UIView *)view
          withOffset:(CGFloat)offSet
       withDelayTime:(CGFloat)time;

- (void)showTipsWithMutText:(NSString *)text
                     onView:(UIView *)view
                 withOffset:(CGFloat)offSet;

- (void)showWithCustomView:(NSString *)text
                    onView:(UIView *)view;

- (void)showProgressWithText:(NSString *)text;

- (void)showProgressWithText:(NSString *)text
                      OnView:(UIView *)view;

- (void)showProgressOnView:(UIView *)superView
                      text:(NSString *)text
                     close:(BOOL)isCanClose;


- (void)hiddenHUD;

@end
