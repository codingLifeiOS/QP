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
        self.backgroundColor = [UIColor whiteColor];
        
        self.phoneLab =[[UILabel alloc]init];
        self.phoneLab.font = [UIFont systemFontOfSize:12];
        self.phoneLab.frame = CGRectMake(100, 60, 150, 20);
        [self.contentView addSubview:self.phoneLab];
    }
    
    return self;
}

//重写cell image内容
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.bounds = CGRectMake(0,0,60,60);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = 30;
    self.imageView.layer.masksToBounds = YES;
    
    self.textLabel.frame = CGRectMake(100, 25, 200, 20);
}

@end
