//
//  QPAccountRecordViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/27.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPAccountRecordViewController.h"
#import "QPAccountRecordTableViewCell.h"
#import "QPAccountRecordDetailsViewController.h"
#import "QPHttpManager.h"
#import "QPAccountRecordModel.h"
#import "UIViewController+MISTipsView.h"

static NSString *const cellIdentifier = @"QPAccountRecordTableViewCell";

@interface QPAccountRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{

   UITableView *homeTableView;
}

@property(nonatomic,strong) NSMutableArray *accountRecordArry;

@end

@implementation QPAccountRecordViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTitleToNavBar:@"到账记录"];
    [self createBackBarItem];
    
    self.accountRecordArry = [[NSMutableArray alloc]init];
    [self configureTableView];
    
    [self getSettlementRecordsNetworkRequest];
    
}

#pragma mark - configureSubViews
-(void)configureTableView
{
    homeTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    homeTableView.dataSource = self;
    homeTableView.delegate = self;
    [homeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    homeTableView.showsVerticalScrollIndicator = NO;
    [homeTableView registerClass:[QPAccountRecordTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:homeTableView];
    [homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.accountRecordArry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QPAccountRecordTableViewCell *cell = [homeTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell updatecellWithModel:self.accountRecordArry[indexPath.row]];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 30))];
    view.backgroundColor = UIColorFromHex(0xf8f8f8);
    UILabel *ExpArrivalLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 30)];
    ExpArrivalLab.text = @"预计到账";
    ExpArrivalLab.font = [UIFont systemFontOfSize:14];
    ExpArrivalLab.textColor = [UIColor blackColor];
    [view addSubview:ExpArrivalLab];
    
    UILabel *ArrAmountLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, 0, 100, 30)];
    ArrAmountLab.text = @"到账金额";
    ArrAmountLab.textAlignment = 2;
    ArrAmountLab.font = [UIFont systemFontOfSize:14];
    ArrAmountLab.textColor=[UIColor blackColor];
    [view addSubview:ArrAmountLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, ArrAmountLab.bottom-0.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = UIColorFromHex(0xdcdcdc);
    [view  addSubview:line];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    QPAccountRecordDetailsViewController *accounredetail = [[QPAccountRecordDetailsViewController alloc]init];
//    [self.navigationController pushViewController:accounredetail animated:YES];
}


- (void)getSettlementRecordsNetworkRequest{
    
    [self hiddenTipsView];
    WEAKSELF();
    [[QPHUDManager sharedInstance]showProgressWithText:@"加载中"];
    [QPHttpManager getSettlementRecordsCompletion:^(id responseData) {
        [[QPHUDManager sharedInstance]hiddenHUD];
        if ([[responseData objectForKey:QP_ResponseCode] isEqualToString:QP_Response_SuccsessCode]) {
            STRONGSELF();
            for (NSDictionary *dic in [responseData objectForKey:@"list"]) {
                QPAccountRecordModel *model = [[QPAccountRecordModel alloc]initWithDictionary:dic];
                [strongSelf.accountRecordArry addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [homeTableView reloadData];
            if (self.accountRecordArry.count == 0) {
                    [[QPHUDManager sharedInstance]showTextOnly:@"没有数据"];
                 [self showTipsView:self.view.bounds type:kTipsViewNoDataString];
                }

            });
        } else {
//            [[QPHUDManager sharedInstance]showTextOnly:[responseData objectForKey:@"resp_msg"]];
            [self showTipsView:self.view.bounds type:[responseData objectForKey:@"resp_msg"]];

        }
     } failure:^(NSError *error) {
        
        [[QPHUDManager sharedInstance]hiddenHUD];
//        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
         [self showTipsView:self.view.bounds type:error.localizedDescription];
    }];
}

@end
