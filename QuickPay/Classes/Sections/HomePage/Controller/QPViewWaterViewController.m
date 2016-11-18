//
//  QPViewWaterViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/28.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPViewWaterViewController.h"
#import "QPViewWaterTableViewCell.h"
#import "QPTransactionDetailsViewController.h"
#import "QPHttpManager.h"
#import "QPViewWaterModel.h"
#import "QPDaterView.h"
static NSString *const cellIdentifier = @"QPViewWaterTableViewCell";

@interface QPViewWaterViewController ()<UITableViewDelegate,UITableViewDataSource,QPDaterViewDelegate>
{
    QPDaterView*dater;
}
@property(nonatomic,strong) UITableView *homeTableView;
@property(nonatomic,strong) UILabel *dateLab;
@property(nonatomic,strong) UILabel *numberLab;
@property(nonatomic,strong) UILabel *settlementmoneyLab;
@property(nonatomic,strong) NSMutableArray *viewaterArry;
@end

@implementation QPViewWaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"查看流水"];
    [self createBackBarItem];
    [self configureTableView];
    [self getOrderRecordsNetworkRequest];
    self.viewaterArry = [[NSMutableArray alloc]init];
    [self createRightBarItemByImageName:@"liushui_shaixuan" target:self action:@selector(datechoicebtnclick)];
}

-(void)datechoicebtnclick{
    dater=[[QPDaterView alloc]initWithFrame:CGRectZero];
    dater.delegate=self;
    [dater showInView:self.view animated:YES];
}
- (void)daterViewDidClicked:(QPDaterView *)daterView{
    NSLog(@"dateString=%@ timeString=%@",dater.dateString,dater.timeString);
}
- (void)daterViewDidCancel:(QPDaterView *)daterView{
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dater.hidden = YES;
}

#pragma mark - configureSubViews
-(void)configureTableView
{
    self.homeTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.homeTableView.dataSource = self;
    self.homeTableView.backgroundColor = UIColorFromHex(0xf8f8f8);
    self.homeTableView.delegate = self;
    [self.homeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.homeTableView.showsVerticalScrollIndicator = NO;
    [ self.homeTableView registerClass:[QPViewWaterTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.homeTableView];
    [self.homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section==3) {
//        return 3;
//    } else {
//        return  1;
//    }
//
    return self.viewaterArry.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QPViewWaterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell updatecellWithModel:self.viewaterArry[indexPath.row]];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QPTransactionDetailsViewController *transacdetail = [[QPTransactionDetailsViewController alloc]init];
    [self.navigationController pushViewController:transacdetail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    view1.backgroundColor = UIColorFromHex(0xf8f8f8);
    [view addSubview:view1];
    
    _dateLab = [[UILabel alloc]initWithFrame:CGRectMake(10, view1.bottom, 120, 30)];
    _dateLab.text = @"2016-10-27 周三";
    _dateLab.font = [UIFont systemFontOfSize:12];
    _dateLab.textColor = UIColorFromHex(0x606268);
    [view addSubview:_dateLab];
    
    _numberLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130, _dateLab.y, 50, 30)];
    _numberLab.text = @"共1笔";
    _numberLab.font = [UIFont systemFontOfSize:16];
    _numberLab.textColor = UIColorFromHex(0xff9b20);
    _numberLab.textAlignment = NSTextAlignmentRight;
    [view addSubview:_numberLab];
    
    _settlementmoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(_numberLab.right+10, _dateLab.y, 100, _dateLab.height)];
    _settlementmoneyLab.text = @"¥ 100";
    _settlementmoneyLab.textAlignment = NSTextAlignmentLeft;
    _settlementmoneyLab.font = [UIFont systemFontOfSize:16];
    _settlementmoneyLab.textColor = UIColorFromHex(0xff9b20);
    [view addSubview:_settlementmoneyLab];
    
    return view;
}
- (void)getOrderRecordsNetworkRequest{
    WEAKSELF();
    [[QPHUDManager sharedInstance]showProgressWithText:@"加载中"];
    [QPHttpManager getOrderRecordsCompletion:^(id responseData) {
        [[QPHUDManager sharedInstance]hiddenHUD];
        if ([[responseData objectForKey:@"resp_code"] isEqualToString:@"0000"]) {
            STRONGSELF();
            for (NSDictionary *dic in [responseData objectForKey:@"list"]) {
                QPViewWaterModel *model = [[QPViewWaterModel alloc]initWithDictionary:dic];
                [strongSelf.viewaterArry addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.homeTableView reloadData];
            });
        } else {
            [[QPHUDManager sharedInstance]showTextOnly:[responseData objectForKey:@"resp_msg"]];
        }
    } failure:^(NSError *error) {
        
        [[QPHUDManager sharedInstance]hiddenHUD];
        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
        
    }];

}

@end
