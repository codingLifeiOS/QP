//
//  QPAccountRecordTableViewCell.m
//  QuickPay
//
//  Created by Nie on 2016/10/27.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPAccountRecordTableViewCell.h"

@implementation QPAccountRecordTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _dateLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 120, 20)];
        _dateLab.text = @"2016-10-27";
        _dateLab.font = [UIFont systemFontOfSize:12];
        _dateLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:_dateLab];
        
        _weekLab = [[UILabel alloc]initWithFrame:CGRectMake(10, _dateLab.bottom, 120, 30)];
        _weekLab.text = @"星期二";
        _weekLab.font = [UIFont systemFontOfSize:16];
        _weekLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:_weekLab];
        
        _moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130, _dateLab.y, 100, _dateLab.height)];
        _moneyLab.text = @"¥ 100";
        _moneyLab.textAlignment = NSTextAlignmentRight;
        _moneyLab.font = [UIFont systemFontOfSize:16];
        _moneyLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:_moneyLab];
        
        _stateLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130, _weekLab.y, 100, _weekLab.height)];
        _stateLab.text = @"已到账";
        _stateLab.textColor = UIColorFromHex(0x53c327);
        _stateLab.textAlignment = NSTextAlignmentRight;
        _stateLab.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_stateLab];
        
        
        UIImageView *rightview = [[UIImageView alloc]initWithFrame:CGRectMake(_moneyLab.right+10,(60-15)/2, 15, 15)];
        rightview.image = [UIImage imageNamed:@"pir_9.png"];
        [self.contentView addSubview:rightview];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = UIColorFromHex(0xdcdcdc);
        [self.contentView  addSubview:line];
        
    }
    return self;
}

- (void)updatecellWithModel:(QPAccountRecordModel*)model{
    self.dateLab.text = model.create_date;
    self.moneyLab.text = [NSString stringWithFormat:@"¥ %@",model.total_amount];
    
    switch ([model.balance_status integerValue]) {
        case 1:
            self.stateLab.text = @"未结算";
            break;
        case 2:
            self.stateLab.text = @"处理中";
            break;
        case 3:
            self.stateLab.text = @"已结算";
            break;
        case 4:
            self.stateLab.text = @"失败";
            break;
        default:
            break;
    }
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDate *date = [formatter dateFromString:model.create_date];
    self.weekLab.text = [date getWeekday];

}

@end
