//
//  QPCheckWaterViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/23.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPCheckWaterViewController.h"
#import "QPCheckWaterTableViewCell.h"
#import "QPTransactionDetailsViewController.h"
#import "QPHttpManager.h"
#import "QPCheckWaterModel.h"
#import "QPDaterView.h"
static NSString *const cellIdentifier = @"QPCheckWaterTableViewCell";

@interface QPCheckWaterViewController ()<UITableViewDelegate,UITableViewDataSource,QPDaterViewDelegate>
{
    QPDaterView *datePicker;
    NSString * timestr;
}
@property(nonatomic,strong) UITableView *homeTableView;
@property(nonatomic,strong) NSMutableArray *checkWaterArry;


@end

@implementation QPCheckWaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"查看流水"];
    [self createBackBarItem];
    [self configureTableView];
    
    NSDate *  date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *nowTime = [dateformatter stringFromDate:date];
    timestr =  nowTime;
    
    [self getOrderRecordsNetworkRequestWithBeginTime:nowTime EndTime:nowTime];
    self.checkWaterArry = [[NSMutableArray alloc]init];
    [self createRightBarItemByImageName:@"liushui_shaixuan" target:self action:@selector(dateChoiceClick)];
}

-(void)dateChoiceClick{
    
    if (!datePicker) {
        datePicker = [[QPDaterView alloc]initWithFrame:CGRectZero];
        datePicker.delegate = self;
        [datePicker showInView:self.view animated:YES];
    }
}
- (void)daterViewDidClicked:(QPDaterView *)daterView{
    
    NSLog(@"dateString = %@ timeString = %@",datePicker.dateString,datePicker.timeString);
    
    timestr  = datePicker.dateString;
    [self getOrderRecordsNetworkRequestWithBeginTime:datePicker.dateString EndTime:datePicker.dateString];
    datePicker = nil;
}
- (void)daterViewDidCancel:(QPDaterView *)daterView{
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    datePicker.hidden = YES;
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
    [ self.homeTableView registerClass:[QPCheckWaterTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.homeTableView];
    [self.homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.checkWaterArry.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QPCheckWaterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell updatecellWithModel:self.checkWaterArry[indexPath.row]];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QPTransactionDetailsViewController *transacdetail = [[QPTransactionDetailsViewController alloc]init];
    transacdetail.tranDetailsModel = self.checkWaterArry[indexPath.row];
    [self.navigationController pushViewController:transacdetail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.checkWaterArry.count == 0) {
        return CGFLOAT_MIN;
    }
    return 50.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view;
    if (self.checkWaterArry.count > 0) {
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        view1.backgroundColor = UIColorFromHex(0xf8f8f8);
        [view addSubview:view1];
        
        UILabel *dateLab = [[UILabel alloc]initWithFrame:CGRectMake(10, view1.bottom, 120, 30)];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSDate *date = [formatter dateFromString:timestr];
        
        dateLab.text = [NSString stringWithFormat:@"%@  %@",timestr,[date getWeekday]];
        dateLab.font = [UIFont systemFontOfSize:12];
        dateLab.textColor = UIColorFromHex(0x606268);
        [view addSubview:dateLab];
        
        UILabel * moneyLab = [[UILabel alloc]initWithFrame:CGRectMake( SCREEN_WIDTH-130, dateLab.y, 120, dateLab.height)];
        
        NSInteger total_amount = 0 ;
        for (QPCheckWaterModel *model in self.checkWaterArry) {
            total_amount = total_amount+[model.total_amount integerValue];
        }
        moneyLab.text = [NSString stringWithFormat:@"共¥%.2f",total_amount /100.00 ];
        moneyLab.textAlignment = NSTextAlignmentRight;
        moneyLab.font = [UIFont systemFontOfSize:16];
        moneyLab.textColor = UIColorFromHex(0xff9b20);
        [view addSubview:moneyLab];
        
        UILabel *numberLab = [[UILabel alloc]initWithFrame:CGRectMake(moneyLab.left-55, dateLab.y, 80, 30)];
        numberLab.text = [NSString stringWithFormat:@"共%ld笔",self.checkWaterArry.count];
        numberLab.font = [UIFont systemFontOfSize:16];
        numberLab.textColor = UIColorFromHex(0xff9b20);
        numberLab.textAlignment = NSTextAlignmentRight;
        [view addSubview:numberLab];
        
    } else {
        view = [[UIView alloc]init];
    }
    
    return view;
}
- (void)getOrderRecordsNetworkRequestWithBeginTime:(NSString*)beginTime EndTime:(NSString*)endTime{
    
    [self.checkWaterArry removeAllObjects];
    
    WEAKSELF();
    [[QPHUDManager sharedInstance]showProgressWithText:@"加载中"];
    [QPHttpManager getOrderRecordsBegin:beginTime End:endTime Completion:^(id responseData) {
        [[QPHUDManager sharedInstance]hiddenHUD];
        if ([[responseData objectForKey:@"resp_code"] isEqualToString:@"0000"]) {
            STRONGSELF();
            for (NSDictionary *dic in [responseData objectForKey:@"list"]) {
                QPCheckWaterModel *model = [[QPCheckWaterModel alloc]initWithDictionary:dic];
                [strongSelf.checkWaterArry addObject:model];
            }
            [self.homeTableView reloadData];
            if (self.checkWaterArry.count == 0) {
                [[QPHUDManager sharedInstance]showTextOnly:@"没有数据"];
            }
        } else {
            [[QPHUDManager sharedInstance]showTextOnly:[responseData objectForKey:@"resp_msg"]];
        }
        
    } failure:^(NSError *error) {
        
        [[QPHUDManager sharedInstance]hiddenHUD];
        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
    }];
    
}


@end
