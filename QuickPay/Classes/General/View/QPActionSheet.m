//
//  QPActionSheet.m
//  QuickPay
//
//  Created by Nie on 15/8/10.
//  Copyright (c) 2015年 Nie. All rights reserved.
//

#import "QPActionSheet.h"

@interface QPActionSheet ()

@property (nonatomic, strong) UIView *actionSheetBackgroundView;
@property (nonatomic, strong) UIView *actionSheetView;

@property (nonatomic, assign) CGRect showViewFrame;
@property (nonatomic, assign) CGRect hiddenViewFrame;

@end

static NSInteger const kQPActionSheetLeftRightMargin = 10;
static NSInteger const kQPActionSheetBottomMargin = 10;
static NSInteger const kQPActionSheetMiddleMargin = 7;
static NSInteger const kQPActionSheetButtonHeight = 44;
static NSInteger const kQPActionSheetTitleHeight = 50;

static CGFloat const kQPActionSheetAnimationTimeDuration = 0.3;

static NSString * const kQPActionSheetButtonBackgroundImageName = @"wuba_mis_crm_quxiao";
static NSString * const kQPActionSheetCancelButtonTitle = @"取消";


@implementation QPActionSheet

- (instancetype)initWithTitle:(NSString *)title delegate:(id/**<>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles otherButtonKeys:(NSArray *)otherButtonKeys
{
    self = [super init];
    if (self) {
        
        self.frame = [UIApplication sharedApplication].keyWindow.frame;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        self.tag = 8002;
        _actionSheetTitle = title;
        _titlesArray = otherButtonTitles;
        _keysArray = otherButtonKeys;
        _cancelButtonTitle = cancelButtonTitle;
        
        self.delegate = delegate;
        
        [self configSubviews];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    
    return self;
}

- (void)configSubviews
{
    //background view
    self.actionSheetBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.actionSheetBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:self.actionSheetBackgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.actionSheetBackgroundView addGestureRecognizer:tap];
    
    UIFont *font = [UIFont systemFontOfSize:13.0f];
    CGFloat width = CGRectGetWidth(self.frame) - kQPActionSheetLeftRightMargin * 2;
    NSInteger titlesCount = self.titlesArray.count;
    NSInteger totalHeight = titlesCount * kQPActionSheetButtonHeight + kQPActionSheetTitleHeight;
    CGFloat contentSizeHeight = totalHeight;
    CGFloat viewHeight = totalHeight + kQPActionSheetButtonHeight + kQPActionSheetBottomMargin + kQPActionSheetMiddleMargin;
    
    BOOL isScroll = NO;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (viewHeight > (CGRectGetHeight(self.frame) - statusBarHeight )) {
        viewHeight = CGRectGetHeight(self.frame) - statusBarHeight;
        isScroll = YES;
        
        totalHeight = viewHeight - kQPActionSheetTitleHeight - kQPActionSheetBottomMargin;
    }
    
    self.actionSheetView = [[UIView alloc] initWithFrame:CGRectMake(kQPActionSheetLeftRightMargin, CGRectGetHeight(self.frame), width, viewHeight)];
    [self addSubview:self.actionSheetView];
    
    self.hiddenViewFrame = self.actionSheetView.frame;
    self.showViewFrame = CGRectMake(kQPActionSheetLeftRightMargin, CGRectGetHeight(self.frame)-viewHeight, width, viewHeight);
    
    
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, totalHeight)];
    contentScrollView.contentSize = CGSizeMake(width, contentSizeHeight);
    if (isScroll) {
        contentScrollView.scrollEnabled = YES;
    }else{
        contentScrollView.scrollEnabled = NO;
    }
    
    UIImageView *contentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, contentSizeHeight)];
    contentView.image = [[UIImage imageNamed:kQPActionSheetButtonBackgroundImageName] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    contentView.userInteractionEnabled = YES;
    
    [contentScrollView addSubview:contentView];
    [self.actionSheetView addSubview:contentScrollView];
    
    //action sheet title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, kQPActionSheetTitleHeight)];
    titleLabel.text = self.actionSheetTitle;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = font;
    [contentView addSubview:titleLabel];
    
    CGFloat y = titleLabel.frame.size.height;
    UIColor *lineColor = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:220/255.0 alpha:1.0];
    UIFont *buttonTitleFont = [UIFont systemFontOfSize:18.0f];
    
    //action buttons
    for (int i=0; i<titlesCount; i++) {
        NSString *title = self.titlesArray[i];
        UIButton *button = [self defaultButton:title];
        button.tag = 30 + i;
        button.frame = CGRectMake(0, y + i * kQPActionSheetButtonHeight, width, kQPActionSheetButtonHeight);
        [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = buttonTitleFont;
        [contentView addSubview:button];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, button.frame.origin.y, width, 0.5)];
        line.backgroundColor = lineColor;
        [contentView addSubview:line];
    }
    
    y = totalHeight + kQPActionSheetMiddleMargin;
    //cancel button
    UIButton *cancelButton = [self defaultButton:kQPActionSheetCancelButtonTitle];
    cancelButton.frame = CGRectMake(0, y,width, kQPActionSheetButtonHeight);
    [cancelButton setBackgroundImage:[UIImage imageNamed:kQPActionSheetButtonBackgroundImageName] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:kQPActionSheetButtonBackgroundImageName] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = buttonTitleFont;
    [self.actionSheetView addSubview:cancelButton];
    
}

- (UIButton *)defaultButton:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:250/255.0 green:133/255.0 blue:55/255.0 alpha:1.0f] forState:UIControlStateNormal];
    
    return button;
}

- (void)show
{
    self.hidden = NO;
    [UIView animateWithDuration:kQPActionSheetAnimationTimeDuration animations:^{
        self.actionSheetBackgroundView.alpha = 1;
        self.actionSheetView.frame = self.showViewFrame;
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:kQPActionSheetAnimationTimeDuration animations:^{
        self.actionSheetBackgroundView.alpha = 0;
        self.actionSheetView.frame = self.hiddenViewFrame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

- (void)cancelButtonClicked:(UIButton *)button
{
    [self dismiss];
}

- (void)actionButtonClicked:(UIButton *)button
{
    NSInteger tag = button.tag;
    NSInteger buttonIndex = tag - 30;
    
    [self dismissWithClickedButtonIndex:buttonIndex];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex
{
    [self dismiss];
    
    if ([_delegate respondsToSelector:@selector(QPActionSheet:clickedButtonAtIndex:clickedButtonTitle:clickedButtonKey:)]) {
        
        NSString *title = self.titlesArray[buttonIndex];
        NSString *key = nil;
        if (self.keysArray.count > 0) {
            key = self.keysArray[buttonIndex];
        }
        
        [_delegate QPActionSheet:self clickedButtonAtIndex:buttonIndex clickedButtonTitle:title clickedButtonKey:key];
    }
}

@end
