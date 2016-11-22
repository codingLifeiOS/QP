//
//  QPSetUpViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/11.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPSetUpViewController.h"
#import "QPSetUpableViewCell.h"
#import "QPModifyPasswordViewController.h"

static NSString *const cellIdentifier = @"QPSetUpableViewCell";


@interface QPSetUpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *homeTableView;
//@property(nonatomic,strong)NSArray *setuplabArry;

@end

@implementation QPSetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"设置"];
    [self createBackBarItem];
    self.view.backgroundColor = UIColorFromHex(0xf8f8f8);
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
    [ self.homeTableView registerClass:[QPSetUpableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.homeTableView];
//    self.setuplabArry = @[@"修改密码",@"常见问题"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QPSetUpableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.contentView.backgroundColor = [UIColor whiteColor];
//    cell.modifypasswordLab.text = self.setuplabArry[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        QPModifyPasswordViewController *QPmodpsasswordVC = [[QPModifyPasswordViewController alloc]init];
        [self.navigationController pushViewController:QPmodpsasswordVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0;
}


@end
