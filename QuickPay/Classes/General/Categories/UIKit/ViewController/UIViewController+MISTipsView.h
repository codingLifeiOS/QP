//
//  UIViewController+MISTipsView.h
//  QuickPay
//
//  Created by Nie on 15/7/28.
//  Copyright (c) 2015年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPEmptyListTipView.h"

@interface UIViewController (MISTipsView)<RequestTimeoutTipViewDelegate>

- (void)showNoDataTipView:(CGRect)frame;
- (void)showTimeoutTipView:(CGRect)frame;
- (void)showRequestErrorTipView:(CGRect)frame;

- (void)showTipsView:(CGRect)frame type:(NSString *)tipType;

- (void)hiddenTipsView;

- (void)startRetry;

- (void)showTipsView:(CGRect)frame type:(NSString *)tipType andContentView:(UIView*)contentView andTag:(NSInteger)tag;

- (void)hiddenTipsContentView:(UIView*)contentView andTag:(NSInteger)tag;

- (void)showNoDataTipViewFrame:(CGRect)frame andContentView:(UIView*)contentView andTag:(NSInteger)tag;

- (void)showRequestErrorTipViewFrame:(CGRect)frame andContentView:(UIView*)contentView andTag:(NSInteger)tag;

@end
