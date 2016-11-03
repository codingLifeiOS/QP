//
//  UITableViewCell+CreatLine.m
//  QuickPay
//
//  Created by 周卫斌 on 15/10/21.
//  Copyright © 2015年 Nie. All rights reserved.
//

#import "UITableViewCell+CreatLine.h"

@implementation UITableViewCell (CreatLine)

- (void)creatLinetableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath cellLineType:(CellLineType)type
{
    NSInteger rowCount =  [tableView numberOfRowsInSection:indexPath.section];
    CGFloat rowHeight = [tableView rectForRowAtIndexPath:indexPath].size.height;
    if (type == EditeViewType) {
        if (indexPath.row == 0) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.4)];
            view.backgroundColor = [UIColor seperateLineColor];
            [self.contentView addSubview:view];
        }
        if (rowCount == indexPath.row + 1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, rowHeight - 0.4, SCREEN_WIDTH, 0.4)];
            view.backgroundColor = [UIColor seperateLineColor];
            [self.contentView addSubview:view];
        } else {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, rowHeight - 0.4, SCREEN_WIDTH - 15, 0.4)];
            view.backgroundColor = [UIColor seperateLineColor];
            [self.contentView addSubview:view];
        }
    } else if (type == TotalType){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, rowHeight - 0.4, SCREEN_WIDTH, 0.4)];
        view.backgroundColor = [UIColor seperateLineColor];
        [self.contentView addSubview:view];
    
    } else if (type == FrontDistanceType){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, rowHeight - 0.4, SCREEN_WIDTH -15, 0.4)];
        view.backgroundColor = [UIColor seperateLineColor];
        [self.contentView addSubview:view];
    }
}

@end
