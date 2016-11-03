//
//  QPTransactionDetailsView.h
//  QuickPay
//
//  Created by Nie on 2016/10/28.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QPTransactionDetailsView : UIView
@property (nonatomic,strong)UIImageView *typeimage;
@property (nonatomic,strong)UILabel *typeLab;
@property (nonatomic,strong)UILabel *netreceiptsLab;
@property (nonatomic,strong)UILabel *receivableLab;
@property (nonatomic,strong)UILabel *tradingstatusLab;
@property (nonatomic,strong)UILabel *tradingtimeLab;
@property (nonatomic,strong)UILabel *tradingnumberLab;
@end
