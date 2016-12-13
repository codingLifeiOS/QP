//
//  QPMyBankCardViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/5.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPMyBankCardViewController.h"
#import "QPHttpManager.h"
#import "QPUserModel.h"
#import "QPFileLocationManager.h"

@interface QPMyBankCardViewController ()

@end

@implementation QPMyBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"我的银行卡"];
    [self createBackBarItem];
    [self configureView];
}
-(void)configureView
{
    QPUserModel *userModel = [QPMyBankCardViewController getUserModel];
    
    self.view.backgroundColor = UIColorFromHex(0xefefef);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 12, SCREEN_WIDTH-60, 130)];
    imageView.image = [UIImage imageNamed:@"yinhangka_pic1"];
    [self.view addSubview:imageView];
    
    UILabel *bankLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, imageView.width-20, 30)];
    bankLab.text = userModel.bank_name;
    bankLab.font = [UIFont systemFontOfSize:18];
    bankLab.textColor = [UIColor whiteColor];
    [imageView addSubview:bankLab];
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, bankLab.bottom, 150, 30)];
    nameLab.text = userModel.bank_account_name;
    nameLab.font = [UIFont systemFontOfSize:15];
    nameLab.textColor = [UIColor whiteColor];
    [imageView addSubview:nameLab];
    
    UILabel *cardLab = [[UILabel alloc]initWithFrame:CGRectMake(50, nameLab.bottom, imageView.width-50,30)];
    NSString *str1;
    if (userModel.card_number.length >= 4) {
        str1 = [userModel.card_number substringFromIndex:userModel.card_number.length- 4];
    }
    NSString *str2 = @"****  ****  ****  ";
    cardLab.text = [NSString stringWithFormat:@"%@%@",str2,str1];
    cardLab.textColor = UIColorFromHex(0xff6600);
    cardLab.textAlignment = NSTextAlignmentCenter;
    cardLab.font = [UIFont systemFontOfSize:16];
    [imageView addSubview:cardLab];
}

+ (QPUserModel*)getUserModel{
    
    NSString *path = [QPFileLocationManager getUserDirectory];
    NSString *filePath = [path stringByAppendingPathComponent:@"merInfo.data"];
    NSMutableArray *merInfolist = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return merInfolist[0];
}

@end
