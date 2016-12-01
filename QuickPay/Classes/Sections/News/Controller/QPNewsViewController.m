//
//  QPNewsViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/25.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPNewsViewController.h"
#import "NewsTableViewCell.h"
#import "QPHttpManager.h"
#import "QPNewsDetailsViewController.h"

static NSString *const cellIdentifier = @"NewsTableViewCell";

@interface QPNewsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *homeTableView;
@property (nonatomic,strong) NSArray *newsNamelabArry;
@property (nonatomic,strong) NSArray *infolabArry;


@end

@implementation QPNewsViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    [self configureTableView];
    [self getNews];
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
    [self.homeTableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.homeTableView];
    [self.homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.leftView.image = [UIImage imageNamed:@"xiaoxi_logo"];
    cell.NewsNameLabel.text = [self.newsNamelabArry[indexPath.section] objectForKey:@"name"];
    cell.InfoLabel.text = [self.newsNamelabArry[indexPath.section] objectForKey:@"key"];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QPNewsDetailsViewController * newsDetailsVC = [[QPNewsDetailsViewController alloc]init];
    newsDetailsVC.newsDetailsDict = self.newsNamelabArry[indexPath.row];
    [self.navigationController pushViewController:newsDetailsVC animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 10))];
    timeLabel.backgroundColor = [UIColor clearColor];
    return timeLabel;
}
- (void)getNews{
    WEAKSELF();
    [QPHttpManager getNewsCompletion:^(id responseData) {
        if ([[responseData objectForKey:QP_ResponseCode] isEqualToString:QP_Response_SuccsessCode]) {
            STRONGSELF();
            strongSelf.newsNamelabArry = [[NSArray alloc]init];
            strongSelf.infolabArry = [[NSArray alloc]init];
            strongSelf.newsNamelabArry = [responseData objectForKey:@"list"];
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
