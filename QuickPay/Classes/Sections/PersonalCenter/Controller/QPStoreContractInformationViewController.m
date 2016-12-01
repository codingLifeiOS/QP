//
//  QPStoreContractInformationViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/11.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPStoreContractInformationViewController.h"
#import "QPStoreContractInformationTableViewCell.h"
#import "QPAgreementTermsTableViewCell.h"
#import "QPAgreementAndTermsViewController.h"
#import "QPHttpManager.h"

static NSString *const cellIdentifier = @"QPStoreContractInformationTableViewCell";
static NSString *const cellIdentifier1 = @"QPAgreementTermsTableViewCell";

@interface QPStoreContractInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *homeTableView;
@property(nonatomic,strong) NSArray *typeArry;
@property(nonatomic,strong) NSMutableDictionary *rateDict;
@end

@implementation QPStoreContractInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"店铺签约信息"];
    [self createBackBarItem];
    self.view.backgroundColor = UIColorFromHex(0xf8f8f8);
    [self configureTableView];
    
    self.typeArry = @[@{@"image":@"jiesuan_weixin",
                        @"tittle":@"微信收款",},
                      @{@"image":@"jiesuan_zhifubao",
                        @"tittle":@"支付宝收款",},
                      @{@"image":@"jiesuan_jingdong",
                        @"tittle":@"京东收款",},
                      @{@"image":@"jiesuan_qq",
                        @"tittle":@"QQ钱包",}];
    
    [self getRate];
    
};
#pragma mark - configureSubViews
-(void)configureTableView
{
    self.homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.homeTableView.dataSource = self;
    self.homeTableView.backgroundColor=[UIColor clearColor];
    self.homeTableView.delegate = self;
    [self.homeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.homeTableView.showsVerticalScrollIndicator = NO;
    [self.homeTableView registerClass:[QPStoreContractInformationTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.homeTableView registerClass:[QPAgreementTermsTableViewCell class] forCellReuseIdentifier:cellIdentifier1];
    [self.view addSubview:self.homeTableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    } else {
        return  1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            QPStoreContractInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.typeLab.text = [self.typeArry[indexPath.row] objectForKey:@"tittle"];
            if (indexPath.row == 0) {
                cell.rateLab.text = [NSString stringWithFormat:@"%.2f%%",[self.rateDict[@"ratet1_wx"] floatValue]*100];
            } else if (indexPath.row == 1) {
                cell.rateLab.text = [NSString stringWithFormat:@"%.2f%%",[self.rateDict[@"ratet1_zfb"] floatValue]*100];
            } else {
                cell.rateLab.text = @"---";
            }
            cell.typeimage.image = [UIImage imageNamed:[self.typeArry[indexPath.row] objectForKey:@"image"]];
            return cell;
        }
            break;
            
        case 1:
        {
            QPAgreementTermsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
    
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section== 1) {
        QPAgreementAndTermsViewController *QPagreetermVC = [[QPAgreementAndTermsViewController alloc]init];
        [self.navigationController pushViewController:QPagreetermVC animated:YES];
        NSLog(@"协议与条款");
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 30))];
        view.backgroundColor = UIColorFromHex(0xf8f8f8);
        UILabel *rateLab = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 120, 30)];
        rateLab.text = @"费率";
        rateLab.font=[UIFont systemFontOfSize:14];
        rateLab.textColor = [UIColor blackColor];
        [view addSubview:rateLab];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30.0;
    } else {
        return 10.0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)getRate{
    WEAKSELF();
    [[QPHUDManager sharedInstance]showProgressWithText:@"加载中"];
    [QPHttpManager getRateCompletion:^(id responseData) {
        if ([[responseData objectForKey:QP_ResponseCode] isEqualToString:QP_Response_SuccsessCode]) {
            STRONGSELF();
            [[QPHUDManager sharedInstance]hiddenHUD];
            strongSelf.rateDict = responseData;
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
