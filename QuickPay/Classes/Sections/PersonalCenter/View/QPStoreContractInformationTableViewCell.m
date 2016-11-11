//
//  QPStoreContractInformationTableViewCell.m
//  QuickPay
//
//  Created by Nie on 2016/11/11.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPStoreContractInformationTableViewCell.h"

@implementation QPStoreContractInformationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
                UIView *line = [[UIView alloc]init];
        line.backgroundColor = UIColorFromHex(0xdcdcdc);
        [self.contentView  addSubview:line];
        
        _typeimage = [[UIImageView alloc]init];
        _typeimage.image = [UIImage imageNamed:@"weixin.png"];
        [self.contentView addSubview:_typeimage];
        
        
        _typeLab = [[UILabel alloc]init];
        _typeLab.text = @"微信收款";
        _typeLab.textColor = [UIColor blackColor];
        _typeLab.textAlignment = NSTextAlignmentLeft;
        _typeLab.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_typeLab];
        
        
        _rateLab = [[UILabel alloc]init];
        _rateLab.text = @"¥ 100";
        _rateLab.textColor = [UIColor blackColor];
        _rateLab.textAlignment = NSTextAlignmentRight;
        _rateLab.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_rateLab];
        
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
            make.left.equalTo(@25);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@22.5);
            make.left.equalTo(self.typeimage.mas_right_mas).with.offset(10);
            make.width.equalTo(@100);
            make.height.lessThanOrEqualTo(@20);
        }];
        
        
        [self.rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeLab);
            make.right.equalTo(@(-10));
            make.width.equalTo(self.typeLab);
            make.height.lessThanOrEqualTo(self.typeLab);
        }];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeimage.mas_bottom_mas).with.offset(10);
            make.left.equalTo(@0);
            make.width.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}
@end
