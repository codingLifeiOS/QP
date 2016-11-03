//
//  QPNewsViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/25.
//  Copyright © 2016年 高晓东. All rights reserved.
//

#import "QPNewsViewController.h"
#import "NewsTableViewCell.h"
@interface QPNewsViewController ()

@end

@implementation QPNewsViewController

/**
 * 设置样式
 */
-(instancetype)init {
    return [self initWithStyle:(UITableViewStyleGrouped)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadComponent];
}
/**
 * 加载组件
 */
-(void) loadComponent {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadTopView];
    [self loadContentView];
    [self loadBottomView];
}
/**
 * 加载头部视图
 */
-(void) loadTopView {
    
}
/**
 * 加载内容视图
 */
-(void) loadContentView {
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gerenzhongxin_bj"]];
    imageView.image=[UIImage imageNamed:@"gerenzhongxin_bj"];
    [self.tableView setBackgroundView:imageView];
}
/**
 * 加载底部视图
 */
-(void) loadBottomView {
    
}
/**
 * 加载数据源
 */
-(void) loadDataSource {
    
}
/**
 * 加载刷新
 */
-(void) loadRefresh {
    
}


#pragma mark - tableView delegate and datasoure
/**
 *  每组展示个数
 **/
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
    static NSString *ID = @"cell";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    cell.leftView.image = [UIImage imageNamed:@"hxp"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 20))];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = RGBACOLOR(138, 140, 146, 1);
    
    timeLabel.text = @"10月20日";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    return timeLabel;
}

@end
