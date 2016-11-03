//
//  QPUserCenterViewCell.m
//  QuickPay
//
//  Created by Nie on 16/10/24.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPUserCenterViewCell.h"

@implementation QPUserCenterViewCell

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
//重写cell image内容
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.bounds = CGRectMake(0,0,60,60);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.cornerRadius = 30;
    self.imageView.layer.masksToBounds = YES;
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin = CGPointMake(100, -10);
    self.textLabel.frame = tmpFrame;
    self.textLabel.font = [UIFont systemFontOfSize:12];
    tmpFrame = self.detailTextLabel.frame;
    tmpFrame.origin.x = 46;
}

@end
