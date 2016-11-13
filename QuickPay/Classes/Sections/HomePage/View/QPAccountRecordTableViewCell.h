//
//  QPAccountRecordTableViewCell.h
//  QuickPay
//
//  Created by Nie on 2016/10/27.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPAccountRecordModel.h"
@interface QPAccountRecordTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *dateLab;
@property (nonatomic,strong)UILabel *moneyLab;
@property (nonatomic,strong)UILabel *weekLab;
@property (nonatomic,strong)UILabel *stateLab;
@property (nonatomic,strong)QPAccountRecordModel*model;

- (void)updatecellWithModel:(QPAccountRecordModel*)model;
@end
