//
//  QPAccountRecordDetailsView.m
//  QuickPay
//
//  Created by Nie on 2016/10/28.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPAccountRecordDetailsView.h"

@implementation QPAccountRecordDetailsView

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
    
    _dateLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-20, 40)];
    _dateLab.text = @"2016-10-28 星期五";
    _dateLab.textAlignment = NSTextAlignmentLeft;
    _dateLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:_dateLab];
    
    UIView *firstview = [[UIView alloc] initWithFrame:CGRectMake(0, _dateLab.bottom, SCREEN_WIDTH, 110)];
    firstview.backgroundColor = [UIColor whiteColor];
    [self addSubview:firstview];
    
    _moneyab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 10, 100, 30)];
    _moneyab.text = @"¥100";
    _moneyab.textColor = [UIColor blackColor];
    _moneyab.textAlignment = NSTextAlignmentCenter;
    _moneyab.font = [UIFont systemFontOfSize:16];
    [firstview addSubview:_moneyab];
    
    _crosssectionLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, _moneyab.bottom, 100, 30)];
    _crosssectionLab.text = @"等待划款";
    _crosssectionLab.textColor = [UIColor blackColor];
    _crosssectionLab.textAlignment = NSTextAlignmentCenter;
    _crosssectionLab.font = [UIFont systemFontOfSize:16];
    [firstview addSubview:_crosssectionLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _crosssectionLab.bottom, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = UIColorFromHex(0xdcdcdc);
    [firstview addSubview:line];
    
    _totalamountLab = [[UILabel alloc]initWithFrame:CGRectMake(20, line.bottom+10, 140, 30)];
    _totalamountLab.text = @"总金额:¥100";
    _totalamountLab.textColor = [UIColor blackColor];
    _totalamountLab.textAlignment = NSTextAlignmentLeft;
    _totalamountLab.font = [UIFont systemFontOfSize:16];
    [firstview addSubview:_totalamountLab];
    
    _totaldeductionsLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-160, _totalamountLab.y, 140, 30)];
    _totaldeductionsLab.text = @"总扣款:¥100";
    _totaldeductionsLab.textColor = [UIColor blackColor];
    _totaldeductionsLab.textAlignment = NSTextAlignmentRight;
    _totaldeductionsLab.font = [UIFont systemFontOfSize:16];
    [firstview addSubview:_totaldeductionsLab];
    
    UILabel *explainlab = [[UILabel alloc]initWithFrame:CGRectMake(40, firstview.bottom, SCREEN_WIDTH-80, 60)];
    explainlab.text = @"* 你的款项尚未划出，顺便付每日12：00~17：00划款请耐心等待";
    explainlab.numberOfLines = 0;
    explainlab.textColor = [UIColor blackColor];
    explainlab.textAlignment = NSTextAlignmentLeft;
    explainlab.font = [UIFont systemFontOfSize:16];
    [self addSubview:explainlab];
    
    UIView *twoview = [[UIView alloc] initWithFrame:CGRectMake(20, explainlab.bottom, SCREEN_WIDTH-40, 60)];
    twoview.backgroundColor = [UIColor whiteColor];
    [self addSubview:twoview];
    
    _typeimage = [[UIImageView alloc]initWithFrame:CGRectMake(20,10, 40, 40)];
    _typeimage.image = [UIImage imageNamed:@"weixin.png"];
    [twoview addSubview:_typeimage];
    
    _typeLab = [[UILabel alloc]initWithFrame:CGRectMake(_typeimage.right+10, _typeimage.y+10, 100, 20)];
    _typeLab.text = @"微信交易";
    _typeLab.textColor = [UIColor blackColor];
    _typeLab.textAlignment = NSTextAlignmentLeft;
    _typeLab.font = [UIFont systemFontOfSize:16];
    [twoview addSubview:_typeLab];
    
    _typemoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-170, _typeLab.y, 120, 20)];
    _typemoneyLab.text = @"¥100";
    _typemoneyLab.font = [UIFont systemFontOfSize:16];
    _typemoneyLab.textColor = UIColorFromHex(0xff9b20);
    _typemoneyLab.textAlignment = NSTextAlignmentRight;
    [twoview addSubview:_typemoneyLab];
    
    UILabel *trandetaillab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, twoview.bottom+10, 100, 30)];
    trandetaillab.text = @"交易明细";
    trandetaillab.textColor = [UIColor blackColor];
    trandetaillab.textAlignment = NSTextAlignmentCenter;
    trandetaillab.font = [UIFont systemFontOfSize:20];
    [self addSubview:trandetaillab];
    
    UILabel *trannumoneylab = [[UILabel alloc]initWithFrame:CGRectMake(20, trandetaillab.bottom+10, 100, 30)];
    trannumoneylab.text = @"交易金额";
    trannumoneylab.textColor = [UIColor blackColor];
    trannumoneylab.textAlignment = NSTextAlignmentLeft;
    trannumoneylab.font = [UIFont systemFontOfSize:16];
    [self addSubview:trannumoneylab];
    
    UILabel *counmoneylab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, trannumoneylab.y, 100, 30)];
    counmoneylab.text = @"手续费";
    counmoneylab.textColor = [UIColor blackColor];
    counmoneylab.textAlignment = NSTextAlignmentRight;
    counmoneylab.font = [UIFont systemFontOfSize:16];
    [self addSubview:counmoneylab];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, counmoneylab.bottom, SCREEN_WIDTH, 0.5)];
    line1.backgroundColor = UIColorFromHex(0xdcdcdc);
    [self addSubview:line1];
    
    _typeimage = [[UIImageView alloc]initWithFrame:CGRectMake(trannumoneylab.x,line1.bottom+10, 25, 25)];
    _typeimage.image = [UIImage imageNamed:@"weixin.png"];
    [self addSubview:_typeimage];
    
    _transactionamountLab = [[UILabel alloc]initWithFrame:CGRectMake(_typeimage.right+10, _typeimage.y, 100, 25)];
    _transactionamountLab.text = @"¥100";
    _transactionamountLab.textColor = [UIColor blackColor];
    _transactionamountLab.textAlignment = NSTextAlignmentLeft;
    _transactionamountLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:_transactionamountLab];
    
    _counterfeeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-160, _transactionamountLab.y-5, 140, 20)];
    _counterfeeLab.text = @"¥0:00";
    _counterfeeLab.font = [UIFont systemFontOfSize:16];
    _counterfeeLab.textColor = UIColorFromHex(0xff9b20);
    _counterfeeLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:_counterfeeLab];
    
    _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(_counterfeeLab.x+-40, _counterfeeLab.bottom, 180, 20)];
    _timeLab.text = @"2016-10-28 17:35:44";
    _timeLab.font = [UIFont systemFontOfSize:16];
    _timeLab.textColor = UIColorFromHex(0xff9b20);
    _timeLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:_timeLab];
}

@end
