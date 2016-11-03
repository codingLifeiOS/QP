//
//  UIBarButtonItem+Extension.m
//  QuickPay
//
//  Created by 周卫斌 on 15/10/14.
//  Copyright © 2015年 Nie. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btn setTitleColor:UIColorFromHex(0x555555) forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置尺寸
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : btn.titleLabel.font} context:nil].size;
    CGFloat width = (size.width > 100 ? 100 : size.width) + 10;
    btn.size = CGSizeMake(width, 44);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    //    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    rightButton.frame = CGRectMake(0, 0, 50, 50);
    //    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    //    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    //    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    //    [rightButton setTitleColor:UIColorFromHex(0x555555) forState:UIControlStateNormal];
    //    [rightButton addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    //    self.navigationItem.rightBarButtonItem = saveItem;

    
}

@end
