//
//  QPAgreementTermsTableViewCell.m
//  QuickPay
//
//  Created by Nie on 2016/11/11.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPAgreementTermsTableViewCell.h"

@implementation QPAgreementTermsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel * agreementermslab = [[UILabel alloc]init];
        agreementermslab.textColor = [UIColor blackColor];
        agreementermslab.textAlignment = NSTextAlignmentLeft;
        agreementermslab.text = @"协议与条款";
        agreementermslab.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:agreementermslab];
        
        UIImageView *rightimage = [[UIImageView alloc]init];
        rightimage.image = [UIImage imageNamed:@"geren_Right-Arrow"];
        [self.contentView addSubview:rightimage];
        
        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = UIColorFromHex(0xdcdcdc);
        [self.contentView  addSubview:line1];
        
        [agreementermslab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.left.equalTo(@25);
            make.width.equalTo(@100);
            make.height.lessThanOrEqualTo(@40);
        }];
        
        [rightimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.right.equalTo(@(-10));
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(agreementermslab.mas_bottom_mas).with.offset(20);
            make.left.equalTo(@0);
            make.width.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];

            }
    return self;
}
@end
