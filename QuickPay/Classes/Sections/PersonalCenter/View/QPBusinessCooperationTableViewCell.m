//
//  QPBusinessCooperationTableViewCell.m
//  QuickPay
//
//  Created by Nie on 2016/11/4.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPBusinessCooperationTableViewCell.h"

@implementation QPBusinessCooperationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _bussimage = [[UIImageView alloc]init];
        [self.contentView addSubview:_bussimage];
        
        
        _bussLab = [[UILabel alloc]init];
        _bussLab.textColor = [UIColor blackColor];
        _bussLab.textAlignment = NSTextAlignmentLeft;
        _bussLab.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_bussLab];
        
        _infoLab = [[UILabel alloc]init];
        _infoLab.textColor = UIColorFromHex(0x606268);
        _infoLab.textAlignment = NSTextAlignmentLeft;
        _infoLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_infoLab];
        
        
        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = UIColorFromHex(0xdcdcdc);
        [self.contentView  addSubview:line1];
        
        [self.bussimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.equalTo(@25);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.bussLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bussimage);
            make.left.equalTo(self.bussimage.mas_right_mas).with.offset(10);
            make.width.equalTo(self.contentView);
            make.height.lessThanOrEqualTo(@30);
        }];
        
        [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bussLab.mas_bottom_mas);
            make.left.equalTo(self.bussLab);
            make.width.equalTo(self.bussLab);
            make.height.lessThanOrEqualTo(self.bussLab);
        }];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infoLab.mas_bottom_mas).with.offset(10.5);
            make.left.equalTo(@0);
            make.width.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

@end
