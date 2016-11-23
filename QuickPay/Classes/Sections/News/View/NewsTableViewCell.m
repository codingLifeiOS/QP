//
//  NewsTableViewCell.m
//  QuickPay
//
//  Created by Nie on 16/10/27.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guanyuwom_bj"]];
        imageView.image=[UIImage imageNamed:@"guanyuwom_bj"];
        [self setBackgroundView:imageView];
        _leftView = [[UIImageView alloc]initWithFrame:(CGRectMake(15, 15, 40, 40))];
        _leftView.layer.cornerRadius = 20;
        [self.contentView addSubview:self.leftView];
        
        _NewsNameLabel = [[UILabel alloc]initWithFrame:(CGRectMake(60, 10, SCREEN_WIDTH -80, 30))];
        _NewsNameLabel.text = @"楚霸王都跪下来求饶了，京戏能不亡吗,娘，冷，水都冻冰了！";
        _NewsNameLabel.textAlignment = UITextLayoutDirectionLeft;
        
        _NewsNameLabel.font = [UIFont systemFontOfSize:16];
        _NewsNameLabel.numberOfLines = 2;
        _NewsNameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_NewsNameLabel];
        
        _InfoLabel = [[UILabel alloc]initWithFrame:(CGRectMake(60, self.NewsNameLabel.bottom , SCREEN_WIDTH -80, 30))];
        _InfoLabel.text = @"#蝶衣，你可真是不疯魔不成活呀!";
        _InfoLabel.textAlignment = UITextLayoutDirectionLeft;
        _InfoLabel.font = [UIFont systemFontOfSize:14];
        _InfoLabel.backgroundColor = [UIColor clearColor];
        _InfoLabel.textColor =  RGBACOLOR(255,155,32,1);
        [self.contentView addSubview: self.InfoLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
