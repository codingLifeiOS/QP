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
static NSString *const cellIdentifier = @"QPAgreementTermsTableViewCell";
@interface QPAgreementAndTermsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *homeTableView;
@property(nonatomic,strong) NSArray *agrtermslabArry;


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
    [self.homeTableView registerClass:[QPAgreementTermsTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.homeTableView];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.agrtermslabArry.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QPAgreementTermsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.agreementermslab.text = [self.agrtermslabArry[indexPath.row] objectForKey:@"name"];
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QPRegistrationAgreementViewController * serviceAgreementVC = [[QPRegistrationAgreementViewController alloc]init];
    serviceAgreementVC.serviceAgreementDict = self.agrtermslabArry[indexPath.row];
    [self.navigationController pushViewController:serviceAgreementVC animated:YES];
  
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
            strongSelf.agrtermslabArry = [[NSArray alloc]init];
            strongSelf.agrtermslabArry = [responseData objectForKey:@"list"];
            [strongSelf.homeTableView reloadData];
          } else {
            [[QPHUDManager sharedInstance]showTextOnly:[responseData objectForKey:@"resp_msg"]];
        }

    }failure:^(NSError *error) {
        [[QPHUDManager sharedInstance]hiddenHUD];
        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];

    }];
}
@end
