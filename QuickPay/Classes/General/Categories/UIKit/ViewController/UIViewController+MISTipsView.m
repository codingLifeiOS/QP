//
//  UIViewController+MISTipsView.m
//  QuickPay
//
//  Created by Nie on 15/7/28.
//  Copyright (c) 2015年 Nie. All rights reserved.
//

#import "UIViewController+MISTipsView.h"

static NSInteger const kTipsViewTag = 37700;
static NSString * const kTipsViewNoDataString = @"没有数据";

@implementation UIViewController (MISTipsView)

- (void)showTimeoutTipView:(CGRect)frame
{
    [self hiddenTipsView];
    RequestTimeoutTipView *timeoutView = [[RequestTimeoutTipView alloc] initNewStyleWithFrame:frame];
    timeoutView.tag = kTipsViewTag;
    timeoutView.delegate = self;
    [self.view addSubview:timeoutView];
    timeoutView.hidden = NO;
    [timeoutView updateTextLabelWithType:@"1"];
}

- (void)showTipsView:(CGRect)frame type:(NSString *)tipType
{
    [self hiddenTipsView];
    if ([tipType isEqualToString:kTipsViewNoDataString]) {
        [self showNoDataTipView:frame];
        return;
    }
    RequestTimeoutTipView *timeoutView = [[RequestTimeoutTipView alloc] initNewStyleWithFrame:frame];
    timeoutView.tag = kTipsViewTag;
    timeoutView.delegate = self;
    [self.view addSubview:timeoutView];
    timeoutView.hidden = NO;
    [timeoutView updateTextLabelWithType:tipType];
}

- (void)showNoDataTipView:(CGRect)frame
{
    [self hiddenTipsView];
    QPEmptyListTipView *tips = [[QPEmptyListTipView alloc] initNewStyleWithFrame:frame];
    tips.tag = kTipsViewTag;
    [self.view addSubview:tips];
}

- (void)showRequestErrorTipView:(CGRect)frame
{
    [self hiddenTipsView];
    RequestTimeoutTipView *timeoutView = [[RequestTimeoutTipView alloc] initNewStyleWithFrame:frame];
    timeoutView.tag = kTipsViewTag;
    timeoutView.delegate = self;
    [self.view addSubview:timeoutView];
    timeoutView.hidden = NO;
    [timeoutView updateTextLabelWithType:@"2"];
}


- (void)hiddenTipsView
{
    UIView *view = [self.view viewWithTag:kTipsViewTag];
    if (view) {
        view.hidden = YES;
        [view removeFromSuperview];
    }
}

#pragma mark - 传入View的处理
- (void)hiddenTipsContentView:(UIView*)contentView andTag:(NSInteger)tag
{
    UIView *view = [contentView viewWithTag:tag];
    if (view) {
        view.hidden = YES;
        [view removeFromSuperview];
    }
}


- (void)showTipsView:(CGRect)frame type:(NSString *)tipType andContentView:(UIView*)contentView andTag:(NSInteger)tag
{
    [self hiddenTipsContentView:contentView andTag:tag];
    if ([tipType isEqualToString:kTipsViewNoDataString]) {
        [self showNoDataTipViewFrame:frame andContentView:contentView andTag:tag];
        return;
    }
    RequestTimeoutTipView *timeoutView = [[RequestTimeoutTipView alloc] initNewStyleWithFrame:frame];
    timeoutView.tag = tag;
    timeoutView.delegate = self;
    [contentView addSubview:timeoutView];
    timeoutView.hidden = NO;
    [timeoutView updateTextLabelWithType:tipType];
}

- (void)showNoDataTipViewFrame:(CGRect)frame andContentView:(UIView*)contentView andTag:(NSInteger)tag
{
    [self hiddenTipsContentView:contentView andTag:tag];
    QPEmptyListTipView *tips = [[QPEmptyListTipView alloc] initNewStyleWithFrame:frame];
    tips.tag = tag;
    [contentView addSubview:tips];
}

- (void)showRequestErrorTipViewFrame:(CGRect)frame andContentView:(UIView*)contentView andTag:(NSInteger)tag
{
    [self hiddenTipsContentView:contentView andTag:tag];
    RequestTimeoutTipView *timeoutView = [[RequestTimeoutTipView alloc] initNewStyleWithFrame:frame];
    timeoutView.tag = tag;
    timeoutView.delegate = self;
    [contentView addSubview:timeoutView];
    timeoutView.hidden = NO;
    [timeoutView updateTextLabelWithType:@"2"];
}


#pragma mark - delegate

-(void)requestTimeoutTipView:(UIView *)view startRetry:(UIButton *)button
{
    if ([self respondsToSelector:@selector(startRetry)]) {
        [self startRetry];
    }
}

- (void)startRetry {

}

@end
