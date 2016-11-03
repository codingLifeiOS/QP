//
//  UITableViewCell+CreatLine.h
//  QuickPay
//
//  Created by 周卫斌 on 15/10/21.
//  Copyright © 2015年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CellLineType) {
    TotalType,//整条显示
    FrontDistanceType,//前面留有距离
    EditeViewType,//编辑界面,第一行和最后一行的整条线,中间的是前面留有距离的
};
@interface UITableViewCell (CreatLine)
- (void)creatLinetableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath cellLineType:(CellLineType)type;

@end
