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
static NSString *const cellIdentifier = @"QPStoreContractInformationTableViewCell";
static NSString *const cellIdentifier1 = @"QPAgreementTermsTableViewCell";


@interface QPStoreContractInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *homeTableView;
@property(nonatomic,strong)NSArray *typelabArry;
@property(nonatomic,strong)NSArray *ratelabArry;
@property(nonatomic,strong)NSArray *typeimageArry;

@end

@implementation QPStoreContractInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"店铺签约信息"];
    [self createBackBarItem];
    self.view.backgroundColor = UIColorFromHex(0xf8f8f8);
    [self configureTableView];
}
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
    
    self.typelabArry = @[@"微信收款",@"支付宝收款",@"京东收款",@"QQ钱包"];
    self.ratelabArry = @[@"0.38%",@"0.6%",@"0.6%",@"0.4%"];
    self.typeimageArry = @[@"jiesuan_weixin",@"jiesuan_zhifubao",@"jiesuan_jingdong",@"jiesuan_qq"];
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
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.typeLab.text = self.typelabArry[indexPath.row];
            cell.rateLab.text = self.ratelabArry[indexPath.row];
            cell.typeimage.image = [UIImage imageNamed:self.typeimageArry[indexPath.row]];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 30))];
    view.backgroundColor = UIColorFromHex(0xf8f8f8);
    UILabel *rateLab = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 120, 30)];
    rateLab.text = @"费率";
    rateLab.font=[UIFont systemFontOfSize:14];
    rateLab.textColor = [UIColor blackColor];
    [view addSubview:rateLab];
        return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}



@end
