//
//  QPSetUpableViewCell.m
//  
//
//  Created by Nie on 2016/11/11.
//
//

#import "QPSetUpableViewCell.h"

@implementation QPSetUpableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _modifypasswordLab = [[UILabel alloc]init];
        _modifypasswordLab.textColor = [UIColor blackColor];
        _modifypasswordLab.textAlignment = NSTextAlignmentLeft;
        _modifypasswordLab.font = [UIFont systemFontOfSize:16];
        _modifypasswordLab.text = @"修改密码";
        [self.contentView addSubview:_modifypasswordLab];
        
        UIImageView *rightimage = [[UIImageView alloc]init];
        rightimage.image = [UIImage imageNamed:@"geren_Right-Arrow"];
        [self.contentView addSubview:rightimage];
        
        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = UIColorFromHex(0xdcdcdc);
        [self.contentView  addSubview:line1];
        
        [self.modifypasswordLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.left.equalTo(@30);
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
            make.top.equalTo(self.modifypasswordLab.mas_bottom_mas).with.offset(20);
            make.left.equalTo(@0);
            make.width.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

@end
