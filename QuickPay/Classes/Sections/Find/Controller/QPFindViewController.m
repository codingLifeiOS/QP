//
//  QPFindViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/25.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPFindViewController.h"

@interface QPFindViewController ()
{
    UIView *menuBgView;
}
@end

@implementation QPFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureMenuView];
}
- (void)configureMenuView{
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:bottomView];
    
    CGFloat width = SCREEN_WIDTH/3;
    CGFloat height = 120;
    NSArray *menuImageArray = @[@[@"nav_1",@"nav_2",@"nav_3"],@[@"nav_4",@"nav_6",@"nav_5"],@[@"nav_4",@"nav_6",@"nav_5"]];
    NSArray *menuNameArray = @[@[@"交通罚款",@"汇率转换",@"信用卡还款"],@[@"支付宝充值",@"我的快递",@"生活缴费"],@[@"机票预订",@"手机充值",@"固话充值"]];
    for (int i = 0; i<3; i++) {
        NSArray *array = menuImageArray[i];
        NSArray *titleArray = menuNameArray[i];
        for (int j = 0; j< 3; j++) {
            
            UIView *menuView = [[UIView alloc]init];
            menuView .frame = CGRectMake(j*width, i*height, width, height);
            [bottomView addSubview:menuView];
            
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-30, 20, 60, 60)];
            imageview.image = [UIImage imageNamed:array[j]];
            [menuView addSubview:imageview];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,imageview.bottom+10,width,30)];
            titleLabel.text = titleArray[j];
            titleLabel.font = [UIFont systemFontOfSize:13];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [menuView addSubview:titleLabel];
            
//            menuView.tag = 200 + 10 * i + j;
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNextView:)];
//            [menuView addGestureRecognizer:tap];
        }
    }
    //两条竖分割线
    for (int i=0; i<2; i++) {
        UILabel *vLineLabel = [[UILabel alloc] initWithFrame:CGRectMake((i+1) * width, 0, 0.5, height*3)];
        vLineLabel.backgroundColor = UIColorFromHex(0xdddddd);
        [bottomView addSubview:vLineLabel];
    }
    
    //三条横分割线
    for (int j=0; j<3; j++) {
        UILabel *vLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (j+1)*height, SCREEN_WIDTH, 0.5)];
        vLineLabel.backgroundColor = UIColorFromHex(0xdddddd);
        [bottomView addSubview:vLineLabel];
    }
    

    
}
@end
