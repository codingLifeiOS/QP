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
    
    [QPHttpManager getAgreementCompletion:^(id responseData) {
        
    }failure:^(NSError *error) {
        
    }];
}
@end
