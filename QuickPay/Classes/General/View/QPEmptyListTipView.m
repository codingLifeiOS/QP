//
//  QPEmptyListTipView.m
//  SimpleCRM
//
//  Created by Nie on 14/10/27.
//  Copyright (c) 2014年 Nie. All rights reserved.
//

#import "QPEmptyListTipView.h"
#import "Masonry.h"
#import "UIImage+YYAdd.h"
@interface RequestTimeoutTipView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation RequestTimeoutTipView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        int y = 80;
        //图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(frame)-101)/2, y, 101, 101)];
        imageView.image = [UIImage imageNamed:@"58_bi_timeout_icon.png"];
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:imageView];
        y += 101;
        
        y += 50;
        //文字
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, frame.size.width, 20)];
        self.textLabel.text = @"数据加载超时，请点击按钮重新加载。";
        self.textLabel.textColor = UIColorFromHex(0x999999);
        self.textLabel.font = [UIFont systemFontOfSize:16.0f];
        self.textLabel.textAlignment = NSTextAlignmentCenter;

        self.textLabel.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        self.textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textLabel];
        
        y += 20;
        y += 30;
        
        UIButton *retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        retryButton.tag = 10080;
        retryButton.frame = CGRectMake((CGRectGetWidth(frame)-122)/2, y, 122, 43);
        [retryButton setTitle:@"重新加载" forState:UIControlStateNormal];
        retryButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [retryButton setBackgroundImage:[UIImage imageWithColor:UIColorFromHex(0xfc8529)] forState:UIControlStateNormal];
        retryButton.layer.cornerRadius = 5.0f;
        retryButton.clipsToBounds = YES;
        [retryButton addTarget:self action:@selector(retryRequest:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:retryButton];
        
        self.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
    }
    
    return self;
}

-(instancetype)initNewStyleWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        int y = 80;
        //图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(frame)-101)/2, y, 101, 101)];
        imageView.image = [UIImage imageNamed:@"58_bi_timeout_icon.png"];
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:imageView];
        y += 101;
        
        y += 50;
        //文字
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, frame.size.width, 20)];
        self.textLabel.text = @"数据加载超时，请点击按钮重新加载。";
        self.textLabel.textColor = UIColorFromHex(0x999999);
        self.textLabel.font = [UIFont systemFontOfSize:16.0f];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        
        self.textLabel.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        self.textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textLabel];
        
        y += 20;
        y += 30;
        
        UIButton *retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        retryButton.tag = 10080;
        retryButton.frame = CGRectMake((CGRectGetWidth(frame)-122)/2, y, 122, 43);
        [retryButton setTitle:@"重新加载" forState:UIControlStateNormal];
        retryButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [retryButton setBackgroundImage:[UIImage imageWithColor:UIColorFromHex(0xfc8529)] forState:UIControlStateNormal];
        retryButton.layer.cornerRadius = 5.0f;
        retryButton.clipsToBounds = YES;

        [retryButton addTarget:self action:@selector(retryRequest:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:retryButton];
        
        self.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
    }
    
    return self;
}

- (void)updateTextLabelWithType:(NSString *)type
{
    if (!type || [type isEqual:[NSNull null]]) {
        type = @"请求失败，请重新加载。";
    }
    
    if ([type isEqualToString:@"1"]) {
        self.textLabel.text = @"数据加载超时，请点击按钮重新加载。";//
    }else if ([type isEqualToString:@"2"]){
        self.textLabel.text = @"网络加载异常，请点击按钮重新加载。";//
    }else{
        self.textLabel.text = type;
    }
    
    if ([type isEqualToString:@"您没有权限访问此服务"]) {
        //如果没有权限使用则隐藏重新加载按钮
        [self viewWithTag:10080].hidden = YES;
    }
}

- (void)retryRequest:(UIButton *)button
{
    self.hidden = YES;
    
    if ([_delegate respondsToSelector:@selector(requestTimeoutTipView:startRetry:)]) {
        [_delegate requestTimeoutTipView:self startRetry:button];
    }
}

@end

@interface QPEmptyListTipView ()

@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation QPEmptyListTipView

-(instancetype)initWithFrame:(CGRect)frame
{
    frame.size.width = 258/2;
    frame.size.height = 8+(185+31)/2;
    self = [super initWithFrame:frame];
    if (self) {
        //131 185
        //257 31
        
        //图片
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((257-131)/4, 0, 131/2, 185/2)];
        self.imageView.image = [UIImage imageNamed:@"58_empty_list_image_icon"];
        self.imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doAnimation)];
        [self.imageView addGestureRecognizer:tap];
        
        [self addSubview:self.imageView];
        
        //文字
        UIImageView *textImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 185/2+8, frame.size.width, 31/2)];
        textImageView.image = [UIImage imageNamed:@"58_empty_list_text_icon"];
        [self addSubview:textImageView];
    }
    
    return self;
}

-(instancetype)initNewStyleWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = nil;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        view.backgroundColor = [UIColor whiteColor];
        
        if (SCREEN_WIDTH == 320) {
            image = [UIImage imageNamed:@"wuba_mis_nodata_bg_320.png"];
        }else{
            image = [UIImage imageNamed:@"wuba_mis_nodata_bg.png"];
        }
        
        UIImageView *noDataImageView = [[UIImageView alloc] init];
//        noDataImageView.clipsToBounds = YES;
        noDataImageView.image = image;
//        noDataImageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:noDataImageView];
        
        [self addSubview:view];
        
        [noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left_mas);
            make.right.equalTo(view.mas_right_mas);
            make.top.equalTo(view.mas_top_mas);
//            这句代码是新加的 等高
            make.height.equalTo(view.mas_height_mas);
        }];
    }
    
    return self;
}

- (void)doAnimation
{
//    [CRM58AnimationUtil rotateToOriginWithVelocity:4.0f view:self.imageView];
}


@end
