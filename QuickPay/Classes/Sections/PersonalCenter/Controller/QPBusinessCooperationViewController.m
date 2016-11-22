//
//  QPBusinessCooperationViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/4.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPBusinessCooperationViewController.h"
#import "QPBusinessCooperationTableViewCell.h"

static NSString *const cellIdentifier = @"QPBusinessCooperationTableViewCell";

@interface QPBusinessCooperationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *homeTableView;
@property(nonatomic,strong)NSArray *busslabArry;
@property(nonatomic,strong)NSArray *infolabArry;
@property(nonatomic,strong)NSArray *bussimageArry;
@end

@implementation QPBusinessCooperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"商务合作"];
    [self createBackBarItem];
    [self configureTableView];
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
    [ self.homeTableView registerClass:[QPBusinessCooperationTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.homeTableView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shangwu_beijing"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.homeTableView setBackgroundView:imgView];
    
    self.busslabArry = @[@"商家入驻",@"配送服务加盟",@"城市代理申请",@"媒体公关合作",@"品牌广告合作",@"开放平台合作"];
    self.infolabArry = @[@"610310365@qq.com",@"610310365@qq.com",@"610310365@qq.com",@"610310365@qq.com",@"610310365@qq.com",@"610310365@qq.com"];
    self.bussimageArry = @[@"shangwu_pic1",@"shangwu_pic2",@"shangwu_pic3",@"shangwu_pic4",@"shangwu_pic5",@"shangwu_pic6"];
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
    QPBusinessCooperationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.contentView.backgroundColor = UIColorFromHex(0xfefdfd);
    cell.bussLab.text = self.busslabArry[indexPath.row];
    cell.infoLab.text = self.infolabArry[indexPath.row];
    cell.bussimage.image = [UIImage imageNamed:self.bussimageArry[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0;
}

@end
