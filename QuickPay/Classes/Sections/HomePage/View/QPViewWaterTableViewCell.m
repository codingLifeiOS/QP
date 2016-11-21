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
        _moneyLab.font = [UIFont systemFontOfSize:18];
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
            make.top.equalTo(@20);
            make.right.equalTo(@(-10));
            make.width.equalTo(self.typeLab);
            make.height.lessThanOrEqualTo(self.typeLab);
        }];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLab.mas_bottom_mas).with.offset(10.5);
            make.left.equalTo(@0);
            make.width.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

- (void)updatecellWithModel:(QPViewWaterModel *)model{
    NSString *timestr;
    if (model.create_date.length >= 8) {
        timestr = [model.create_date substringFromIndex:model.create_date.length-8];
    }
    self.timeLab.text = timestr;
    self.moneyLab.text = [NSString stringWithFormat:@"¥ %.2f",[model.total_amount integerValue]/100.00];
    if ([model.pay_type isEqualToString:@"1"]) {
        _typeLab.text = @"支付宝收款";
        _typeimage.image = [UIImage imageNamed:@"jiesuan_zhifubao"];
    } else {
        _typeLab.text = @"微信收款";
        _typeimage.image = [UIImage imageNamed:@"jiesuan_weixin"];
    }
}
@end
