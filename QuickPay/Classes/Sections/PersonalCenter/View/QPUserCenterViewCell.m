//
//  QPUserCenterViewCell.m
//  QuickPay
//
//  Created by Nie on 16/10/24.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPUserCenterViewCell.h"
@implementation QPUserCenterViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.nameLab = [[UILabel alloc]init];
        self.nameLab.font = [UIFont systemFontOfSize:12];
        self.nameLab.frame = CGRectMake(100, 15, 200, 20);
        [self.contentView addSubview:self.nameLab];
        
        self.phoneLab = [[UILabel alloc]init];
        self.phoneLab.font = [UIFont systemFontOfSize:12];
        self.phoneLab.frame = CGRectMake(100, 55, 150, 20);
        [self.contentView addSubview:self.phoneLab];
        
        self.headimage = [[UIImageView alloc]init];
        self.headimage.frame = CGRectMake(20,15,60,60);
        self.headimage.contentMode = UIViewContentModeScaleAspectFill;
        self.headimage.layer.cornerRadius = 30;
        self.headimage.layer.masksToBounds = YES;
        self.headimage.image = [UIImage imageNamed:@"geren_touxiang"];
        [self.contentView addSubview:self.headimage];
    }
    
    return self;
}
@end
