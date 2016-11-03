//
//  QPAccountRecordDetailsView.h
//  QuickPay
//
//  Created by Nie on 2016/10/28.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QPAccountRecordDetailsView : UIView
@property (nonatomic,strong)UIImageView *typeimage;
@property (nonatomic,strong)UILabel *dateLab;
@property (nonatomic,strong)UILabel *moneyab;
@property (nonatomic,strong)UILabel *crosssectionLab;
@property (nonatomic,strong)UILabel *totalamountLab;
@property (nonatomic,strong)UILabel *totaldeductionsLab;
@property (nonatomic,strong)UILabel *typeLab;
@property (nonatomic,strong)UILabel *typemoneyLab;
@property (nonatomic,strong)UILabel *transactionamountLab;
@property (nonatomic,strong)UILabel *counterfeeLab;
@property (nonatomic,strong)UILabel *timeLab;
@end
