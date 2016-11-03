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

static NSString *const cellIdentifier = @"QPAccountRecordTableViewCell";

@interface QPAccountRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *homeTableView;

@end

@implementation QPAccountRecordViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTitleToNavBar:@"到账记录"];
    [self createBackBarItem];
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
    [ self.homeTableView registerClass:[QPAccountRecordTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    [self.view addSubview:self.homeTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QPAccountRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QPAccountRecordDetailsViewController *accounredetail = [[QPAccountRecordDetailsViewController alloc]init];
    [self.navigationController pushViewController:accounredetail animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 30))];
    view.backgroundColor = UIColorFromHex(0xf8f8f8);
    UILabel *ExpArrivalLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 30)];
    ExpArrivalLab.text = @"预计到账";
    ExpArrivalLab.font=[UIFont systemFontOfSize:14];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}


@end
