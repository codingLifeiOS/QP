//
//  UITableView+RightIndex.h
//  QuickPay
//
//  Created by 周卫斌 on 15/8/6.
//  Copyright (c) 2015年 Nie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (RightIndex)
/**
 *  添加右边索引
 *
 *  @param sectionHeadArr title数组
 *  @param view           需要添加到哪个View上
 */
- (void)creatRightIndexBy:(NSArray *)sectionHeadArr View:(UIView *)view;

@end
