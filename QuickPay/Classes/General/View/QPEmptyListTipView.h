//
//  QPEmptyListTipView.h
//  SimpleCRM
//
//  Created by Nie on 14/10/27.
//  Copyright (c) 2014年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    TimeOutTipViewType,     // 没有网络或者连接超时 有重新加载按钮
    NoDataTipViewType,       // 没有数据 无需显示重新加载按钮
    NoPermissionTipViewType,   // 没有权限 无需显示重新加载按钮
} TipViewType;// 人机交互界面类型

static NSString * const kTipsViewNoDataString = @"没有数据";
static NSString * const kTipsViewNoPermissionString = @"没有权限";


@interface QPEmptyListTipView : UIView

- (instancetype)initNewStyleWithFrame:(CGRect)frame Type:(TipViewType)type;
@end

@protocol RequestTimeoutTipViewDelegate <NSObject>

- (void)requestTimeoutTipView:(UIView *)view startRetry:(UIButton *)button;

@end

@interface RequestTimeoutTipView : UIView

@property (nonatomic, weak) id<RequestTimeoutTipViewDelegate> delegate;

-(instancetype)initNewStyleWithFrame:(CGRect)frame;
- (void)updateTextLabelWithType:(NSString * )type;

@end


