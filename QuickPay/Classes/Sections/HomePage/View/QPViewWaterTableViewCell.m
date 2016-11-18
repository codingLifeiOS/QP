//
//  QPViewWaterTableViewCell.m
//  QuickPay
//
//  Created by Nie on 2016/10/28.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPViewWaterTableViewCell.h"

@implementation QPViewWaterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //        _dateLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 30)];
        //        _dateLab.text = @"2016-10-27 周三";
        //        _dateLab.font = [UIFont systemFontOfSize:12];
        //        _dateLab.textColor = UIColorFromHex(0x606268);
        //        [self.contentView addSubview:_dateLab];
        //
        //        _numberLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130, _dateLab.y, 50, 30)];
        //        _numberLab.text = @"共1笔";
        //        _numberLab.font = [UIFont systemFontOfSize:16];
        //        _numberLab.textColor = UIColorFromHex(0xff9b20);
        //        _numberLab.textAlignment = NSTextAlignmentRight;
        //        [self.contentView addSubview:_numberLab];
        //
        //        _settlementmoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(_numberLab.right+10, _dateLab.y, 100, _dateLab.height)];
        //        _settlementmoneyLab.text = @"¥ 100";
        //        _settlementmoneyLab.textAlignment = NSTextAlignmentLeft;
        //        _settlementmoneyLab.font = [UIFont systemFontOfSize:16];
        //        _settlementmoneyLab.textColor = UIColorFromHex(0xff9b20);
        //        [self.contentView addSubview:_settlementmoneyLab];
        //
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = UIColorFromHex(0xdcdcdc);
        [self.contentView  addSubview:line];
        
        _typeimage = [[UIImageView alloc]init];
        _typeimage.image = [UIImage imageNamed:@"jiesuan_weixin"];
        [self.contentView addSubview:_typeimage];
        
        
        _typeLab = [[UILabel alloc]init];
        _typeLab.text = @"微信收款";
        _typeLab.textColor = [UIColor blackColor];
        _typeLab.textAlignment = NSTextAlignmentLeft;
        _typeLab.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_typeLab];
        
        _timeLab = [[UILabel alloc]init];
        _timeLab.text = @"16:52:41";
        _timeLab.textColor = UIColorFromHex(0x606268);
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_timeLab];
        
        _moneyLab = [[UILabel alloc]init];
        _moneyLab.text = @"¥ 100";
        _moneyLab.textColor = [UIColor blackColor];
        _moneyLab.textAlignment = NSTextAlignmentRight;
        _moneyLab.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_moneyLab];
        
        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = UIColorFromHex(0xdcdcdc);
        [self.contentView  addSubview:line1];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.width.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
        
        [self.typeimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.equalTo(@10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeimage);
            make.left.equalTo(self.typeimage.mas_right_mas).with.offset(10);
            make.width.equalTo(@180);
            make.height.lessThanOrEqualTo(@20);
        }];
        
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeLab.mas_bottom_mas);
            make.left.equalTo(self.typeLab);
            make.width.equalTo(self.typeLab);
            make.height.lessThanOrEqualTo(self.typeLab);
        }];
        
        [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeLab);
            make.right.equalTo(@(-10));
            make.width.equalTo(self.typeLab);
            make.height.lessThanOrEqualTo(self.typeLab);
        }];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLab.mas_bottom_mas).with.offset(10);
            make.left.equalTo(@0);
            make.width.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

- (void)updatecellWithModel:(QPViewWaterModel *)model{
    NSString *str;
    if (model.create_date.length >= 8) {
        str = [model.create_date substringFromIndex:model.create_date.length-8];
    }
    self.timeLab.text = str;
    self.moneyLab.text = [NSString stringWithFormat:@"¥ %@",model.total_amount];
    if ([model.pay_type isEqualToString:@"1"]) {
        _typeLab.text = @"支付宝收款";
        _typeimage.image = [UIImage imageNamed:@"jiesuan_zhifubao"];
    } else {
        _typeLab.text = @"微信收款";
        _typeimage.image = [UIImage imageNamed:@"jiesuan_weixin"];
    }
}
@end
