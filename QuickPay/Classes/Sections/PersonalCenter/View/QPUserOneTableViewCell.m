//
//  QPUserOneTableViewCell.m
//  QuickPay
//
//  Created by Nie on 16/10/27.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPUserOneTableViewCell.h"

@implementation QPUserOneTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guanyuwom_bj"]];
        imageView.image=[UIImage imageNamed:@"guanyuwom_bj"];
        [self setBackgroundView:imageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
