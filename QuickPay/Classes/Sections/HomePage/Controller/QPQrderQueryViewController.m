//
//  QPQrderQueryViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/17.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPQrderQueryViewController.h"
#import "QPHttpManager.h"
@interface QPQrderQueryViewController ()
@property (nonatomic,strong) UILabel *payTypeLab;
@end

@implementation QPQrderQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    [self orderqueryWithOrderId:self.payModel.orderId];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createBackBarItem];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[QPHUDManager sharedInstance]showProgressWithText:@"正在支付中"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)configureView
{
    self.view.backgroundColor = UIColorFromHex(0xefefef);
    
    UIImageView *navbarBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navbarBackImage.image = [UIImage imageNamed:@"jiner_bg"];
    [self.view addSubview:navbarBackImage];
    
    UILabel *navlab = [[UILabel alloc]init];
    navlab.textAlignment = NSTextAlignmentCenter;
    navlab.text = @"交易详情";
    navlab.font = [UIFont systemFontOfSize:16];
    [navbarBackImage addSubview:navlab];
    [navlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.centerX.equalTo(self.view.mas_centerX_mas);
        make.height.equalTo(@25);
        make.top.equalTo(@27);
    }];

    UIImageView *rebeBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, navbarBackImage.bottom+20, SCREEN_WIDTH-24, 50)];
    rebeBackImage.image = [UIImage imageNamed:@"jiner_bg"];
    [self.view addSubview:rebeBackImage];
    
    UILabel *AmoreLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 30)];
    AmoreLab.text = @"应收金额";
    AmoreLab.font = [UIFont systemFontOfSize:16];
    AmoreLab.textColor = [UIColor blackColor];
    [rebeBackImage addSubview:AmoreLab];
    
    
    UILabel *AmoremoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-136, AmoreLab.y, 100, AmoreLab.height)];
    AmoremoneyLab.text = self.payModel.amount;
    AmoremoneyLab.textColor = UIColorFromHex(0x53c327);
    AmoremoneyLab.textAlignment = NSTextAlignmentRight;
    AmoremoneyLab.font = [UIFont systemFontOfSize:16];
    [rebeBackImage addSubview:AmoremoneyLab];
    
    UIImageView *pamountBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(rebeBackImage.x, rebeBackImage.bottom+1, rebeBackImage.width, rebeBackImage.height)];
    pamountBackImage.image = [UIImage imageNamed:@"jiner_bg"];
    [self.view addSubview:pamountBackImage];
    
    UILabel *painamountLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 30)];
    painamountLab.text = @"实收金额";
    painamountLab.font = [UIFont systemFontOfSize:16];
    painamountLab.textColor = [UIColor blackColor];
    [pamountBackImage addSubview:painamountLab];
    
    
    UILabel *painamountmoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-134, AmoreLab.y, 100, AmoreLab.height)];
    painamountmoneyLab.text = self.payModel.amount;
    painamountmoneyLab.textColor = UIColorFromHex(0x53c327);
    painamountmoneyLab.textAlignment = NSTextAlignmentRight;
    painamountmoneyLab.font = [UIFont systemFontOfSize:16];
    [pamountBackImage addSubview:painamountmoneyLab];
    
    self.payTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(12, pamountBackImage.bottom+10, SCREEN_WIDTH-24, 50)];
    self.payTypeLab.text = @"";
    self.payTypeLab.textColor = [UIColor whiteColor];
    self.payTypeLab.layer.cornerRadius = 8;
    self.payTypeLab.layer.masksToBounds = YES;
    self.payTypeLab.textAlignment = NSTextAlignmentCenter;
    self.payTypeLab.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.payTypeLab];
    
    UIButton *footBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame=CGRectMake(12, SCREEN_HEIGHT-60, SCREEN_WIDTH-24, 50);
    [footBtn setTitle:@"返回收款页" forState:UIControlStateNormal];
    footBtn.backgroundColor = [UIColor orangeColor];
    [footBtn  addTarget:self action:@selector(commonPushBack) forControlEvents:UIControlEventTouchUpInside];
    footBtn.layer.borderWidth=2.0f;
    footBtn.layer.cornerRadius = 8.0f;
    footBtn.layer.borderColor=[[UIColor orangeColor]CGColor];
    [self.view addSubview:footBtn];
}
- (void)commonPushBack{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resetDigitalKeyboard" object:nil];
}


- (void)orderqueryWithOrderId:(NSString*)orderId
{
    [QPHttpManager orderquery:orderId Completion:^(id responseData) {
        if ([[responseData objectForKey:QP_ResponseCode] isEqualToString:QP_Response_SuccsessCode]) {
            [[QPHUDManager sharedInstance]hiddenHUD];
            self.payTypeLab.text = @"支付成功";
            self.payTypeLab.backgroundColor = [UIColor greenColor];
        } else {
            self.payTypeLab.text = @"支付结果回调中";
            self.payTypeLab.backgroundColor = [UIColor redColor];
            [self orderqueryWithOrderId:self.payModel.orderId];
        }
    }failure:^(NSError *error) {
        [[QPHUDManager sharedInstance]hiddenHUD];
        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
        
        
    }];
}
@end
