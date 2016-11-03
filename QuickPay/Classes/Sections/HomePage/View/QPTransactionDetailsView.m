//
//  QPTransactionDetailsView.m
//  QuickPay
//
//  Created by Nie on 2016/10/28.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPTransactionDetailsView.h"

@implementation QPTransactionDetailsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureSubViews];
    }
    return self;
}

#pragma mark - configureSubViews
- (void)configureSubViews
{
    self.backgroundColor = UIColorFromHex(0xf8f8f8);
    
    UIView *firstview = [[UIView alloc] init];
    firstview.backgroundColor = [UIColor whiteColor];
    [self addSubview:firstview];
    
    
    _typeimage = [[UIImageView alloc]init];
    _typeimage.image = [UIImage imageNamed:@"weixin.png"];
    [firstview addSubview:_typeimage];
    
    _typeLab = [[UILabel alloc]init];
    _typeLab.text = @"微信收款";
    _typeLab.textColor = [UIColor blackColor];
    _typeLab.textAlignment = NSTextAlignmentLeft;
    _typeLab.font = [UIFont systemFontOfSize:16];
    [firstview addSubview:_typeLab];
    
    
    _netreceiptsLab = [[UILabel alloc]init];
    _netreceiptsLab.text = @"实收 ¥100";
    _netreceiptsLab.font = [UIFont systemFontOfSize:16];
    _netreceiptsLab.textColor = UIColorFromHex(0xff9b20);
    _netreceiptsLab.textAlignment = NSTextAlignmentRight;
    [firstview addSubview:_netreceiptsLab];
    
    UIView *twoview = [[UIView alloc] init];
    twoview.backgroundColor = [UIColor whiteColor];
    [self addSubview:twoview];
    
    _receivableLab = [[UILabel alloc]init];
    _receivableLab.text = @"应收金额: ¥100";
    _receivableLab.textColor = [UIColor blackColor];
    _receivableLab.textAlignment = NSTextAlignmentLeft;
    _receivableLab.font = [UIFont systemFontOfSize:16];
    [twoview addSubview:_receivableLab];
    
    _tradingstatusLab = [[UILabel alloc]init];
    _tradingstatusLab.text = @"交易状态: 消费";
    _tradingstatusLab.textColor = [UIColor blackColor];
    _tradingstatusLab.textAlignment = NSTextAlignmentLeft;
    _tradingstatusLab.font = [UIFont systemFontOfSize:16];
    [twoview addSubview:_tradingstatusLab];
    
    _tradingtimeLab = [[UILabel alloc]init];
    _tradingtimeLab.text = @"交易时间: 2016-10-26-16:52:41";
    _tradingtimeLab.textColor = [UIColor blackColor];
    _tradingtimeLab.textAlignment = NSTextAlignmentLeft;
    _tradingtimeLab.font = [UIFont systemFontOfSize:16];
    [twoview addSubview:_tradingtimeLab];
    
    _tradingnumberLab = [[UILabel alloc]init];
    _tradingnumberLab.text = @"交易单号: 133454533443344";
    _tradingnumberLab.textColor = [UIColor blackColor];
    _tradingnumberLab.textAlignment = NSTextAlignmentLeft;
    _tradingnumberLab.font = [UIFont systemFontOfSize:16];
    [twoview addSubview:_tradingnumberLab];
    
    
    [firstview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@0);
        make.width.equalTo(self);
        make.height.equalTo(@60);
    }];
    
    [self.typeimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeimage.mas_top_mas).with.offset(10);
        make.left.equalTo(self.typeimage.mas_right_mas).with.offset(10);
        make.width.equalTo(@100);
        make.height.lessThanOrEqualTo(@20);
    }];
    
    [self.netreceiptsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLab);
        make.right.equalTo(@(-10));
        make.width.equalTo(@120);
        make.height.lessThanOrEqualTo(self.typeLab);
    }];
    
    [twoview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstview.mas_bottom_mas).with.offset(10);
        make.left.equalTo(@0);
        make.width.equalTo(self);
        make.height.equalTo(@180);
    }];
    
    [self.receivableLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@20);
        make.width.equalTo(self);
        make.height.equalTo(@40);
    }];
    
    [self.tradingstatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.receivableLab.mas_bottom_mas);
        make.left.equalTo(self.receivableLab);
        make.width.equalTo(self.receivableLab);
        make.height.equalTo(self.receivableLab);
    }];
    
    [self.tradingtimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tradingstatusLab.mas_bottom_mas);
        make.left.equalTo(self.receivableLab);
        make.width.equalTo(self.receivableLab);
        make.height.equalTo(self.receivableLab);
    }];
    
    [self.tradingnumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tradingtimeLab.mas_bottom_mas);
        make.left.equalTo(self.receivableLab);
        make.width.equalTo(self.receivableLab);
        make.height.equalTo(self.receivableLab);;
    }];
}

@end
