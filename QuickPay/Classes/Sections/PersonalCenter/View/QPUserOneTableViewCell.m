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
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
