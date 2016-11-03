//
//  QPEmptyListTipView.h
//  SimpleCRM
//
//  Created by Nie on 14/10/27.
//  Copyright (c) 2014年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QPEmptyListTipView : UIView

-(instancetype)initNewStyleWithFrame:(CGRect)frame;

@end

@protocol RequestTimeoutTipViewDelegate <NSObject>

- (void)requestTimeoutTipView:(UIView *)view startRetry:(UIButton *)button;

@end

@interface RequestTimeoutTipView : UIView

@property (nonatomic, weak) id<RequestTimeoutTipViewDelegate> delegate;

-(instancetype)initNewStyleWithFrame:(CGRect)frame;
- (void)updateTextLabelWithType:(NSString * )type;

@end


