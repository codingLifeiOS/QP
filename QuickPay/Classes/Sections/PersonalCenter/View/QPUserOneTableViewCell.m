//
//  QPUserOneTableViewCell.m
//  QuickPay
//
//  Created by 高晓东 on 16/10/27.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPUserOneTableViewCell.h"

@implementation QPUserOneTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guanyuwom_bj"]];
    imageView.image=[UIImage imageNamed:@"guanyuwom_bj"];
    [self setBackgroundView:imageView];
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
