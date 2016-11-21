//
//  QPQrderQueryViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/17.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPQrderQueryViewController.h"

@interface QPQrderQueryViewController ()

@end

@implementation QPQrderQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addTitleToNavBar:@"顺便付"];
    [self configureView];
    self.navigationController.navigationBarHidden = YES;

}

-(void)configureView
{
    self.view.backgroundColor = UIColorFromHex(0xefefef);
    
    UIImageView *navbarbeijingimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navbarbeijingimage.image = [UIImage imageNamed:@"jiner_bg"];
    [self.view addSubview:navbarbeijingimage];
    
    UILabel *navlab = [[UILabel alloc]init];
    navlab.textAlignment = NSTextAlignmentCenter;
    navlab.text = @"顺便付";
    navlab.font = [UIFont systemFontOfSize:16];
    [navbarbeijingimage addSubview:navlab];
    [navlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.centerX.equalTo(self.view.mas_centerX_mas);
        make.height.equalTo(@25);
        make.top.equalTo(@27);
    }];

    UIImageView *rebeijingimage = [[UIImageView alloc]initWithFrame:CGRectMake(12, navbarbeijingimage.bottom+20, SCREEN_WIDTH-24, 50)];
    rebeijingimage.image = [UIImage imageNamed:@"jiner_bg"];
    [self.view addSubview:rebeijingimage];
    
    UILabel *AmoreLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 30)];
    AmoreLab.text = @"应收金额";
    AmoreLab.font = [UIFont systemFontOfSize:16];
    AmoreLab.textColor = [UIColor blackColor];
    [rebeijingimage addSubview:AmoreLab];
    
    
    UILabel *AmoremoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-136, AmoreLab.y, 100, AmoreLab.height)];
    AmoremoneyLab.text = @"¥ 1000";
    AmoremoneyLab.textColor = UIColorFromHex(0x53c327);
    AmoremoneyLab.textAlignment = NSTextAlignmentRight;
    AmoremoneyLab.font = [UIFont systemFontOfSize:16];
    [rebeijingimage addSubview:AmoremoneyLab];
    
    UIImageView *pamountbeijingimage = [[UIImageView alloc]initWithFrame:CGRectMake(rebeijingimage.x, rebeijingimage.bottom+1, rebeijingimage.width, rebeijingimage.height)];
    pamountbeijingimage.image = [UIImage imageNamed:@"jiner_bg"];
    [self.view addSubview:pamountbeijingimage];
    
    UILabel *painamountLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 30)];
    painamountLab.text = @"实收金额";
    painamountLab.font = [UIFont systemFontOfSize:16];
    painamountLab.textColor = [UIColor blackColor];
    [pamountbeijingimage addSubview:painamountLab];
    
    
    UILabel *painamountmoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-134, AmoreLab.y, 100, AmoreLab.height)];
    painamountmoneyLab.text = @"¥ 1000";
    painamountmoneyLab.textColor = UIColorFromHex(0x53c327);
    painamountmoneyLab.textAlignment = NSTextAlignmentRight;
    painamountmoneyLab.font = [UIFont systemFontOfSize:16];
    [pamountbeijingimage addSubview:painamountmoneyLab];
    
    UIImageView *patypeimage = [[UIImageView alloc]initWithFrame:CGRectMake(12, pamountbeijingimage.bottom+10, SCREEN_WIDTH-24, 50)];
    patypeimage.image = [UIImage imageNamed:@"chenggong_bg"];
    [self.view addSubview:patypeimage];
    
    UILabel *paytypeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, patypeimage.width, 50)];
    paytypeLab.text = @"收款成功";
    paytypeLab.textColor = [UIColor whiteColor];
    paytypeLab.textAlignment = NSTextAlignmentCenter;
    paytypeLab.font = [UIFont systemFontOfSize:20];
    [patypeimage addSubview:paytypeLab];
    
    UIButton *footBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame=CGRectMake(12, SCREEN_HEIGHT-55, SCREEN_WIDTH-24, 50);
    [footBtn setTitle:@"返回收款页" forState:UIControlStateNormal];
    footBtn.backgroundColor = [UIColor orangeColor];
    [footBtn  addTarget:self action:@selector(pushkeyboardView) forControlEvents:UIControlEventTouchUpInside];
    footBtn.layer.borderWidth=2.0f;
    footBtn.layer.cornerRadius = 8.0f;
    footBtn.layer.borderColor=[[UIColor orangeColor]CGColor];
    [self.view addSubview:footBtn];
}
- (void)pushkeyboardView
{
}

@end
