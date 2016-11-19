//
//  QPAgreementAndTermsViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/12.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPAgreementAndTermsViewController.h"
#import "QPAgreementTermsTableViewCell.h"
#import "QPHttpManager.h"
#import "QPRegistrationAgreementViewController.h"
#import "QPServiceagreementViewController.h"
#import "QPWeChatPaySolutionsViewController.h"
#import "QPAliPaySolutionsViewController.h"
#import "QPJingdongPaySolutionsViewController.h"
#import "QPQSPaySolutionsViewController.h"
static NSString *const cellIdentifier = @"QPAgreementTermsTableViewCell";
@interface QPAgreementAndTermsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *homeTableView;
@property(nonatomic,strong)NSArray *agrtermslabArry;


@end

@implementation QPAgreementAndTermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"协议与条款"];
    [self createBackBarItem];
    self.view.backgroundColor = UIColorFromHex(0xf8f8f8);
    [self configureTableView];
    [self getAgreement];
}

#pragma mark - configureSubViews
-(void)configureTableView
{
    self.homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.homeTableView.dataSource = self;
    self.homeTableView.backgroundColor = UIColorFromHex(0xf8f8f8);
    self.homeTableView.delegate = self;
    [self.homeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.homeTableView.showsVerticalScrollIndicator = NO;
    [ self.homeTableView registerClass:[QPAgreementTermsTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.homeTableView];
    self.agrtermslabArry = @[@"惠客盟商户注册协议",@"惠客盟商户服务协议",@"微信支付解决方案条款",@"支付宝支付解决方案条款",@"京东钱包支付解决方案条款",@"QPQS支付解决方案条款"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QPAgreementTermsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.agreementermslab.text = self.agrtermslabArry[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            QPRegistrationAgreementViewController *QPreagVC = [[QPRegistrationAgreementViewController alloc]init];
            [self.navigationController pushViewController:QPreagVC animated:YES];
        }
            break;
        case 1:
        {
            QPServiceagreementViewController *QPseagVC = [[QPServiceagreementViewController alloc]init];
            [self.navigationController pushViewController:QPseagVC animated:YES];
        }
            break;
        case 2:
        {
            QPWeChatPaySolutionsViewController *QPchsoVC = [[QPWeChatPaySolutionsViewController alloc]init];
            [self.navigationController pushViewController:QPchsoVC animated:YES];
        }
            break;
        case 3:
        {
            QPAliPaySolutionsViewController *QPalisoVC = [[QPAliPaySolutionsViewController alloc]init];
            [self.navigationController pushViewController:QPalisoVC animated:YES];
        }
            break;
        case 4:
        {
            QPJingdongPaySolutionsViewController *QPjdsoVC = [[QPJingdongPaySolutionsViewController alloc]init];
            [self.navigationController pushViewController:QPjdsoVC animated:YES];
        }
            break;
        case 5:
        {
            QPQSPaySolutionsViewController *QPqssoVC = [[QPQSPaySolutionsViewController alloc]init];
            [self.navigationController pushViewController:QPqssoVC animated:YES];
        }
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0;
}

- (void)getAgreement{
     WEAKSELF();
    [QPHttpManager getAgreementCompletion:^(id responseData) {
        if ([[responseData objectForKey:@"resp_code"] isEqualToString:@"0000"]) {
            STRONGSELF();
            for (NSDictionary *dic in [responseData objectForKey:@"list"]) {
            }
        } else {
            [[QPHUDManager sharedInstance]showTextOnly:[responseData objectForKey:@"resp_msg"]];
        }

    }failure:^(NSError *error) {
        [[QPHUDManager sharedInstance]hiddenHUD];
        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];

    }];
}
@end
