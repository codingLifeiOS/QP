//
//  QPMyBankCardViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/5.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPMyBankCardViewController.h"

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
    self.view.backgroundColor = UIColorFromHex(0xefefef);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 12, SCREEN_WIDTH-60, 130)];
    imageView.image = [UIImage imageNamed:@"yinhangka_pic1"];
    [self.view addSubview:imageView];
    
    UILabel *bankLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 180, 30)];
    bankLab.text = @"中国民生银行";
    bankLab.font = [UIFont systemFontOfSize:18];
    bankLab.textColor = [UIColor whiteColor];
    [imageView addSubview:bankLab];
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, bankLab.bottom, 150, 30)];
    nameLab.text = @"李明";
    nameLab.font = [UIFont systemFontOfSize:15];
    nameLab.textColor = [UIColor whiteColor];
    [imageView addSubview:nameLab];
    
    UILabel *cardLab = [[UILabel alloc]initWithFrame:CGRectMake(50, nameLab.bottom+5, imageView.width-50,30)];
    cardLab.text = @"****  **** ****  0405";
    cardLab.textColor = [UIColor yellowColor];
    cardLab.textAlignment = NSTextAlignmentCenter;
    cardLab.font = [UIFont systemFontOfSize:16];
    [imageView addSubview:cardLab];
    
}
@end
