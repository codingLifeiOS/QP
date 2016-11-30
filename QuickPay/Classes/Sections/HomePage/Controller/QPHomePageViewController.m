//
//  QPHomePageViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/21.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPHomePageViewController.h"
#import "QPScanCodePayViewController.h"
#import "BMAdScrollView.h"
#import "QPAccountRecordViewController.h"
#import "QPCheckWaterViewController.h"
#import "QPDigitalKeyboardView.h"
#import "CLShareManager.h"
#import "QPHttpManager.h"
#import "QPFixedQRViewController.h"
#import "QPPayModel.h"
#import "QRCodeGenerator.h"
#import "NavigationController.h"
#import "QPMoreAboutViewController.h"

@interface QPHomePageViewController ()<BMAdScrollViewClickDelegate,QPDigitalKeyboardViewDelegate>
{
    UIView *menuBgView;
    BMAdScrollView *adView;
    QPDigitalKeyboardView *keyboardView;
    CLShareManager *shareManager;
    
}
@property (nonatomic, strong) NSMutableArray *imageADArray;

@end

@implementation QPHomePageViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    shareManager = [[CLShareManager alloc] init];
    
    self.view.backgroundColor = UIColorFromHex(0xeeeeee);
    [self configureSubViews];
    [self getAdImages];
    
    _imageADArray = [[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetDigitalKeyboard:) name:@"resetDigitalKeyboard" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if (keyboardView) {
        [self hideTabBar];
    } else {
        [self showTabBar];
    }
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
#pragma mark - configureSubViews
- (void)configureSubViews
{
    [self configureNavigaBar];
    [self configureMenuView];
    [self configureBottomView];
}

- (void)configureNavigaBar{
    
    UIView *Naview = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 64)];
    Naview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:Naview];

    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"logo_title.png"];
    [Naview addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(116/2));
        make.centerX.equalTo(self.view.mas_centerX_mas);
        make.height.equalTo(@25);
        make.top.equalTo(@27);
    }];
    
}
-(void)configureScrollViewWithArray:(NSMutableArray*)array
{
        
    NSMutableArray * imageNameArr = [[NSMutableArray alloc]init];
    NSMutableArray * titleNameArr = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in array) {
        [imageNameArr addObject: [dic objectForKey:@"value"]];
        [titleNameArr addObject: [dic objectForKey:@"key"]];
    }
    adView.tag = 10010;
    adView.delegate = self;
    adView = [[BMAdScrollView alloc] initWithNameArr:imageNameArr titleArr:titleNameArr height:132 offsetY:0];
    adView.frame = CGRectMake(0, 72, SCREEN_WIDTH , 132);
    
    [self.view addSubview:adView];

}

- (void)configureMenuView{
    
    menuBgView = [[UIView alloc] initWithFrame:CGRectMake(0,72+132+10, SCREEN_WIDTH, 432/2)];
    menuBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:menuBgView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = UIColorFromHex(0xdcdcdc);
    [menuBgView addSubview:line];
    
    NSArray *menuImageArray = @[@[@"nav_1",@"nav_2",@"nav_3",@"nav_4"],@[@"nav_6",@"nav_5"]];
    NSArray *menuNameArray = @[@[@"扫客收款",@"店铺收款",@"到账记录",@"查看流水"],@[@"分享",@"更多"]];
    CGFloat width = 60;
    CGFloat height = 90;
    CGFloat margin = (SCREEN_WIDTH-60*4)/6;
    CGFloat leftMargin = (SCREEN_WIDTH-60*4)/6*1.5;
    CGFloat topMargin = 16;
    
    for (int i = 0; i<2; i++) {
        NSArray *array = menuImageArray[i];
        NSArray *titleArray = menuNameArray[i];
        NSInteger t_count = array.count;
        
        for (int j = 0; j< t_count; j++) {
            UIView *menuView = [[UIView alloc]init];
            menuView .frame = CGRectMake(leftMargin+j*width+j*margin, i*height+topMargin*(i+1), width, height);
            [menuBgView addSubview:menuView];
            
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
            imageview.image = [UIImage imageNamed:array[j]];
            [menuView addSubview:imageview];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,imageview.bottom,width,30)];
            titleLabel.text = titleArray[j];
            titleLabel.font = [UIFont systemFontOfSize:13];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [menuView addSubview:titleLabel];
            
            menuView.tag = 200 + 10 * i + j;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNextView:)];
            [menuView addGestureRecognizer:tap];
        }
    }
}

- (void)configureBottomView
{
    CGFloat width = (SCREEN_WIDTH -22*2 -17)/2;
    CGFloat height = 156/2 *SCREEN_WIDTH /375;
    UIButton * imagBtn = [[UIButton alloc]initWithFrame:CGRectMake(22, menuBgView.bottom+8, width, height)];
    [imagBtn setImage:[UIImage imageNamed:@"tupian_pic1"] forState:UIControlStateNormal];
    [self.view addSubview:imagBtn];
    
    UIButton * imagBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(imagBtn.right+17, menuBgView.bottom+8, width, height)];
    [imagBtn2 setImage:[UIImage imageNamed:@"tupian_pic2"] forState:UIControlStateNormal];
    [self.view addSubview:imagBtn2];
    
}
#pragma mark -BMAdScrollViewClickDelegate
-(void)buttonClick:(NSInteger)vid
{
//    [[QPHUDManager sharedInstance]showTextOnly:[NSString stringWithFormat:@"点击了广告图%ld",(long)vid]];
}

#pragma mark -QPDigitalKeyboardViewDelegate
- (void)closeBtnClickDelegate{
    [keyboardView removeFromSuperview];
    keyboardView = nil;
    [self showTabBar];
}

- (void)payBtnClickDelegate:(PayType)type amoumt:(NSString*)amount{
    
    QPPayModel *payModel;
    if (type == AlipayType) {
        payModel = [[QPPayModel alloc]init];
        payModel.payType = @"1";
        payModel.amount = amount;
       
    } else {
        payModel = [[QPPayModel alloc]init];
        payModel.payType = @"2";
        payModel.amount = amount;

    }
    [self showQPScanCodePayViewWithPayModel:payModel];
}
#pragma mark - 跳转到扫一扫界面
- (void)showQPScanCodePayViewWithPayModel:(QPPayModel*)model
{
    QPScanCodePayViewController *QPScanCodePayVC =[[QPScanCodePayViewController alloc]init];
    QPScanCodePayVC.payModel = model;
    [self.navigationController pushViewController:QPScanCodePayVC animated:YES];
}
#pragma mark - private methods
- (void)showNextView:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    NSInteger tag = view.tag;
    switch (tag) {
        case 200:
            [self hideTabBar];
            // 键盘
            keyboardView = [[QPDigitalKeyboardView alloc]initWithFrame:self.view.bounds];
            keyboardView.delegate = self;
            [self.view addSubview:keyboardView];
            break;
        case 201:
        {
            QPFixedQRViewController *QPFixedQRVC = [[QPFixedQRViewController alloc]init];
            [self.navigationController pushViewController:QPFixedQRVC animated:YES];
        }
            break;
        case 202:
        {
            QPAccountRecordViewController *QPRccRecordPayVC = [[QPAccountRecordViewController alloc]init];
            [self.navigationController pushViewController:QPRccRecordPayVC animated:YES];
        }
            break;
        case 203:
        {
            QPCheckWaterViewController *QPCheckWaterVC = [[QPCheckWaterViewController alloc]init];
            [self.navigationController pushViewController:QPCheckWaterVC animated:YES];
        }
            break;
        case 210:
            [self shareButtonClick];
            break;
        case 211:{
            QPMoreAboutViewController *QPMoreAboutVC = [[QPMoreAboutViewController alloc]init];
            [self.navigationController pushViewController:QPMoreAboutVC animated:YES];
//            [[QPHUDManager sharedInstance]showTextOnly:@"程序员正在拼命开发中"];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)shareButtonClick{
    [shareManager setShareVC:self content:@"零成本开通微信 支付宝支付" image:[UIImage imageNamed:@"xiaoxi_logo"] url:@"http://www.rrgpay.com/"];
    [shareManager show];
    
}

#pragma mark - 通知事件处理-支付结果界面返回 键盘重设为0 不可点击
- (void)resetDigitalKeyboard:(NSNotification *)notification {
    
    [keyboardView setAmountLable];
    [keyboardView setAliPayBtnAndWeixinPayBtn];
 }

- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ){
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    } else {
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
        contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
        self.tabBarController.tabBar.hidden = YES;
    }
}

- (void)showTabBar
{
    if (self.tabBarController.tabBar.hidden == NO){
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]){
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    } else {
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
        contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
        self.tabBarController.tabBar.hidden = NO;
    }
}
- (void)getAdImages{
    WEAKSELF();
    [[QPHUDManager sharedInstance]showProgressWithText:@"加载中"];
    [QPHttpManager getAdImagesCompletion:^(id responseData) {
        [[QPHUDManager sharedInstance]hiddenHUD];
        if ([[responseData objectForKey:QP_ResponseCode] isEqualToString:QP_Response_SuccsessCode]) {
            STRONGSELF();
            dispatch_async(dispatch_get_main_queue(), ^{

            strongSelf.imageADArray = [responseData objectForKey:@"list"];
            [strongSelf configureScrollViewWithArray:_imageADArray];
            });
        } else {
            [[QPHUDManager sharedInstance]showTextOnly:[responseData objectForKey:@"resp_msg"]];
        }

    }failure:^(NSError *error) {
        [[QPHUDManager sharedInstance]hiddenHUD];
        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
    }];
}

@end
