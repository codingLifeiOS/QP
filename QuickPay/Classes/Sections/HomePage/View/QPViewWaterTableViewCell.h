//
//  QPViewWaterTableViewCell.h
//  QuickPay
//
//  Created by Nie on 2016/10/28.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPViewWaterModel.h"

@interface QPViewWaterTableViewCell : UITableViewCell
//@property (nonatomic,strong)UILabel *dateLab;
//@property (nonatomic,strong)UILabel *numberLab;
//@property (nonatomic,strong)UILabel *settlementmoneyLab;
@property (nonatomic,strong)UILabel *typeLab;
@property (nonatomic,strong)UILabel *timeLab;
@property (nonatomic,strong)UILabel *moneyLab;
@property (nonatomic,strong)UIImageView *typeimage;

- (void)updatecellWithModel:(QPViewWaterModel *)model;

@end
