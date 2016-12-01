//
//  QPTransactionDetailsViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/28.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPTransactionDetailsViewController.h"

@interface QPTransactionDetailsViewController ()
@property (nonatomic,strong) UIImageView *typeimage;
@property (nonatomic,strong) UILabel *typeLab;
@property (nonatomic,strong) UILabel *netreceiptsLab;
@property (nonatomic,strong) UILabel *receivableLab;
@property (nonatomic,strong) UILabel *tradingstatusLab;
@property (nonatomic,strong) UILabel *tradingtimeLab;
@property (nonatomic,strong) UILabel *tradingnumberLab;

@end

@implementation QPTransactionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"交易详情"];
    [self createBackBarItem];
    [self configureSubViews];
}
#pragma mark - configureSubViews
- (void)configureSubViews{
    
    self.view.backgroundColor = UIColorFromHex(0xf8f8f8);
    
    UIView *firstview = [[UIView alloc] init];
    firstview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstview];
    
    
    _typeimage = [[UIImageView alloc]init];
    [firstview addSubview:_typeimage];
    if ([_tranDetailsModel.pay_type isEqualToString:@"1"]) {
        _typeimage.image = [UIImage imageNamed:@"jiesuan_zhifubao"];
    } else {
        _typeimage.image = [UIImage imageNamed:@"jiesuan_weixin"];
    }

    _typeLab = [[UILabel alloc]init];
    _typeLab.textColor = [UIColor blackColor];
    _typeLab.textAlignment = NSTextAlignmentLeft;
    _typeLab.font = [UIFont systemFontOfSize:16];
    [firstview addSubview:_typeLab];
    if ([_tranDetailsModel.pay_type isEqualToString:@"1"]) {
      _typeLab.text = @"支付宝收款";
    } else {
      _typeLab.text = @"微信收款";
    }

    _netreceiptsLab = [[UILabel alloc]init];
    _netreceiptsLab.text = [NSString stringWithFormat:@"实收 ¥ %.2f",[_tranDetailsModel.total_amount integerValue]/100.00];
    _netreceiptsLab.font = [UIFont systemFontOfSize:16];
    _netreceiptsLab.textColor = UIColorFromHex(0xff9b20);
    _netreceiptsLab.textAlignment = NSTextAlignmentRight;
    [firstview addSubview:_netreceiptsLab];
    
    UIView *twoview = [[UIView alloc] init];
    twoview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:twoview];
    
    _receivableLab = [[UILabel alloc]init];
    _receivableLab.text = [NSString stringWithFormat:@"应收金额 ：¥ %.2f",[_tranDetailsModel.total_amount integerValue]/100.00];
    _receivableLab.textColor = [UIColor blackColor];
    _receivableLab.textAlignment = NSTextAlignmentLeft;
    _receivableLab.font = [UIFont systemFontOfSize:16];
    [twoview addSubview:_receivableLab];
    
    _tradingstatusLab = [[UILabel alloc]init];
    _tradingstatusLab.text = @"交易状态: 消费";
    _tradingstatusLab.textColor = [UIColor blackColor];
    _tradingstatusLab.textAlignment = NSTextAlignmentLeft;
    _tradingstatusLab.font = [UIFont systemFontOfSize:16];
    switch ([_tranDetailsModel.payment_status integerValue]) {
        case 1:
            self.tradingstatusLab.text = @"交易状态：未付款";
            break;
        case 2:
            self.tradingstatusLab.text = @"交易状态：已付款";
            break;
        default:
            break;
    }
    [twoview addSubview:_tradingstatusLab];
    
    _tradingtimeLab = [[UILabel alloc]init];
    _tradingtimeLab.text = [NSString stringWithFormat:@"交易时间：%@",_tranDetailsModel.create_date];
    _tradingtimeLab.textColor = [UIColor blackColor];
    _tradingtimeLab.textAlignment = NSTextAlignmentLeft;
    _tradingtimeLab.font = [UIFont systemFontOfSize:16];
    
    [twoview addSubview:_tradingtimeLab];
    
    _tradingnumberLab = [[UILabel alloc]init];
    _tradingnumberLab.text = [NSString stringWithFormat:@"交易单号：%@",_tranDetailsModel.order_sn];
    _tradingnumberLab.textColor = [UIColor blackColor];
    _tradingnumberLab.textAlignment = NSTextAlignmentLeft;
    _tradingnumberLab.font = [UIFont systemFontOfSize:16];
    [twoview addSubview:_tradingnumberLab];
    
    
    [firstview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@0);
        make.width.equalTo(self.view);
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
        make.width.equalTo(self.view);
        make.height.equalTo(@180);
    }];
    
    [self.receivableLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@20);
        make.width.equalTo(self.view);
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
