//
//  QPCheckWaterTableViewCell.h
//  QuickPay
//
//  Created by Nie on 2016/11/23.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPCheckWaterModel.h"
@interface QPCheckWaterTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *typeLab;
@property (nonatomic,strong)UILabel *timeLab;
@property (nonatomic,strong)UILabel *moneyLab;
@property (nonatomic,strong)UIImageView *typeimage;

- (void)updatecellWithModel:(QPCheckWaterModel *)model;


@end
