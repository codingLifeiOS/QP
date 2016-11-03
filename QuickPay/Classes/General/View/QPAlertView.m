//
//  MISAlertView.m
//  QuickPay
//
//  Created by Nie on 15/8/6.
//  Copyright (c) 2015年 Nie. All rights reserved.
//

#import "QPAlertView.h"

@interface QPAlertView ()

@property (nonatomic, strong) UIView *alertViewBackgroundView;
@property (nonatomic, strong) UIImageView *customAlertView;

@property (nonatomic, strong) NSString *otherButtonTitle;
@property (nonatomic, strong) NSString *cancelButtonTitle;

@end

static NSInteger const MISAlertViewHeight = 125;
static NSInteger const MISAlertViewWidth = 267;
static NSInteger const MISAlertViewButtonHeight = 40;
static CGFloat const MISAlertViewLineHeight = 0.5;
static CGFloat const MISAlertViewLineWidth = 0.5;
static NSString * const MISAlertViewDefaultText = @"默认文字";
static NSString * const MISAlertViewBackgroundImageName = @"wuba_mis_crm_tanchukuang";

static NSString * const MISAlertViewDefaultTitle = @"温馨提示";
static NSString * const MISAlertViewDefaultButtonTitle = @"确定";

@implementation QPAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /**<>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    self = [super init];
    if (self) {
        self.frame = [UIApplication sharedApplication].keyWindow.frame;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        self.tag = 8001;
        self.title = title;
        self.message = message;
        self.delegate = delegate;
        self.cancelButtonTitle = cancelButtonTitle;
        self.otherButtonTitle = otherButtonTitle;
        
        self.alertViewBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.alertViewBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self addSubview:self.alertViewBackgroundView];
        
        [self configSubviews];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

- (void)configSubviews
{
    CGFloat yoffset = (self.frame.size.height - MISAlertViewHeight)/2;
    CGFloat xoffset = (self.frame.size.width - MISAlertViewWidth)/2;
    
    //title color & line color
    UIColor *lineColor = [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0];
    UIColor *buttonTitleColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
    UIColor *otherButtonTitleColor = [UIColor colorWithRed:250/255.0 green:133/255.0 blue:55/255.0 alpha:1.0];
    UIColor *textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.customAlertView = [[UIImageView alloc] initWithFrame:CGRectMake(xoffset, yoffset, MISAlertViewWidth, MISAlertViewHeight)];
    self.customAlertView.image = [[UIImage imageNamed:MISAlertViewBackgroundImageName] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    self.customAlertView.userInteractionEnabled = YES;
    
    UIScrollView *textScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MISAlertViewWidth, MISAlertViewHeight-MISAlertViewButtonHeight)];
    textScrollView.scrollEnabled = NO;
    textScrollView.contentSize = CGSizeMake(MISAlertViewWidth, MISAlertViewHeight-MISAlertViewButtonHeight);
    [self.customAlertView addSubview:textScrollView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, MISAlertViewWidth, 20)];
    titleLabel.text = self.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.textColor = textColor;
    [textScrollView addSubview:titleLabel];
    
    UIFont *font = [UIFont systemFontOfSize:14.0f];
    
    NSInteger textViewWidth = MISAlertViewWidth - 40;
    
//    CGSize defaultSize = [MISAlertViewDefaultText sizeWithFont:font constrainedToSize:CGSizeMake(textViewWidth, MISAlertViewHeight)];
    CGSize defaultSize = [MISAlertViewDefaultText boundingRectWithSize:CGSizeMake(textViewWidth, MISAlertViewHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
//    CGSize size = [self.message sizeWithFont:font constrainedToSize:CGSizeMake(textViewWidth, MAXFLOAT)];
    CGSize size = [self.message boundingRectWithSize:CGSizeMake(textViewWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    CGFloat offset = 0;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, textViewWidth, size.height)];
    contentLabel.text = self.message;
    contentLabel.font = font;
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = textColor;
    [textScrollView addSubview:contentLabel];
    
    offset = size.height - defaultSize.height;
    if (offset < 0) {
        offset = 0;
    }
    
    UIFont *buttonTitleFont = [UIFont systemFontOfSize:18.0f];
    //status bar height
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    CGFloat totalHeight = MISAlertViewHeight + offset;
    if (totalHeight > self.frame.size.height - statusBarHeight * 2) {
        totalHeight = self.frame.size.height - statusBarHeight * 2;
    }
    CGFloat buttonYoffset = totalHeight - MISAlertViewButtonHeight;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonYoffset-MISAlertViewLineHeight, MISAlertViewWidth, MISAlertViewLineHeight)];
    label.backgroundColor = lineColor;
    [self.customAlertView addSubview:label];
    
    if (!self.cancelButtonTitle || !self.otherButtonTitle) {
        
        NSString *titleString = (!self.cancelButtonTitle)?self.otherButtonTitle:self.cancelButtonTitle;
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0, buttonYoffset, MISAlertViewWidth, MISAlertViewButtonHeight);
        [cancelButton setTitle:titleString forState:UIControlStateNormal];
        [cancelButton setTitleColor:otherButtonTitleColor forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.titleLabel.font = buttonTitleFont;
        [self.customAlertView addSubview:cancelButton];
    }else{
        
        CGFloat x = MISAlertViewWidth / 2;
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0, buttonYoffset, x, MISAlertViewButtonHeight);
        [cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.titleLabel.font = buttonTitleFont;
        [self.customAlertView addSubview:cancelButton];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(x-MISAlertViewLineWidth, buttonYoffset-MISAlertViewLineWidth, MISAlertViewLineWidth, MISAlertViewButtonHeight)];
        label.backgroundColor = lineColor;
        [self.customAlertView addSubview:label];
        
        UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        otherButton.frame = CGRectMake(x, buttonYoffset, x, MISAlertViewButtonHeight);
        [otherButton setTitle:self.otherButtonTitle forState:UIControlStateNormal];
        [otherButton setTitleColor:otherButtonTitleColor forState:UIControlStateNormal];
        [otherButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        otherButton.titleLabel.font = buttonTitleFont;
        [otherButton addTarget:self action:@selector(otherButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.customAlertView addSubview:otherButton];
    }
    
    if (offset > 0) {
        
        CGFloat newHeight = MISAlertViewHeight + offset;
        CGFloat yoffset = (self.frame.size.height - newHeight)/2;
        textScrollView.contentSize = CGSizeMake(MISAlertViewWidth, newHeight - MISAlertViewButtonHeight);
        
        if (yoffset <= statusBarHeight) {
            yoffset = statusBarHeight;
            newHeight = self.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height * 2;
            
            textScrollView.scrollEnabled = YES;
        }
        
        textScrollView.frame = CGRectMake(0, 0, MISAlertViewWidth, newHeight - MISAlertViewButtonHeight);
        
        self.customAlertView.frame = CGRectMake(xoffset, yoffset, MISAlertViewWidth, newHeight);
    }
    
    [self.alertViewBackgroundView addSubview:self.customAlertView];
}

- (void)show
{
    self.hidden = NO;
}

- (void)dismiss
{
    self.hidden = YES;
    [self removeFromSuperview];
}

- (void)cancelButtonClicked:(UIButton *)button
{
    [self dismissWithClickedButtonIndex:0];
}

- (void)otherButtonClicked:(UIButton *)button
{
    [self dismissWithClickedButtonIndex:1];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex
{
    if ([_delegate respondsToSelector:@selector(misAlertView:clickedButtonAtIndex:)]) {
        [_delegate misAlertView:self clickedButtonAtIndex:buttonIndex];
    }
    [self dismiss];
}

+ (instancetype)alertViewWithMessage:(NSString *)message
{
    return [[[self class] alloc] initWithTitle:MISAlertViewDefaultTitle message:message delegate:nil cancelButtonTitle:nil otherButtonTitle:MISAlertViewDefaultButtonTitle];;
}

+ (instancetype)alertViewWithMessage:(NSString *)message customButtonTitle:(NSString *)title
{
    return [[[self class] alloc] initWithTitle:MISAlertViewDefaultTitle message:message delegate:nil cancelButtonTitle:nil otherButtonTitle:title];
}

@end
