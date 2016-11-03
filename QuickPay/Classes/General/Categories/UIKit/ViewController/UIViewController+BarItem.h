//
//  UIViewController+BarItem.h
//  LianjiaNG
//
//  Created by Nie on 14/12/12.
//  Copyright (c) 2014年 Lianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BarItem)

/*带有返回和title*/
- (void)createBackBarItemWithTitle:(NSString*)title;

/*在导航栏左侧增加带标题的导航栏返回 bar item。*/
-(void)createBackBarItemWithTitle:(NSString*)title
                      buttonTitle:(NSString*)buttonTitle;

///*带有title和左侧返回以及rightBarItem的点击回调*/
//- (void)createBackBarItemWithTitle:(NSString *)title
//                 rightBarItemTitle:(NSString *)rightBarItemTitle
//            rightBarItemClickBlock:(void(^)(id sender))block;

/*不带左侧返回，带有rightBarItem以及点击回调*/
- (void)createNavigationWithTitle:(NSString *)title
                rightBarItemTitle:(NSString *)rightBarItemTitle
           rightBarItemClickBlock:(void(^)(id sender))block;

/**
 *  带有title，不带返回，rightBarItem设置block，和点击回调
 */
- (void)createNavigationWithTitle:(NSString *)title
           rightButtonConfigBlock:(void(^)(UIButton *sender))buttonBlock
           rightBarItemClickBlock:(void(^)(id sender))block;

/**
 *  带有title，返回，rightBarItem设置block，以及点击回调
 */
- (void)createBackBarItemWithTitle:(NSString *)title
            rightButtonConfigBlock:(void(^)(UIButton *sender))buttonBlock
            rightBarItemClickBlock:(void(^)(id sender))block;

/*只有图片的按钮*/
-(void)createBackBarItem;
/*
 只带标题的按钮
 */
-(UIBarButtonItem *)createRightItemWithTitle:(NSString *)title
                         target:(id)target
                         action:(SEL)act;

/*
 创建toolbar上的按钮
 */
-(UIBarButtonItem *)createToolBarItemWithTitle:(NSString *)title target:(id)target action:(SEL)act;
/*
 创建导航栏右侧的按钮
 */

- (void)setRightItemWithNormalImageName:(NSString *)imgN
                      selectedImageName:(NSString *)imgS
                                 target:(id)target
                                 action:(SEL)act
                                tipView:(UIView *)msgTipView;

- (UIButton *)createRightItemWithNormalImageName:(NSString *)imgN
                               selectedImageName:(NSString *)imgS
                                          target:(id)target
                                          action:(SEL)act;
/*创建多个导航栏右侧按钮*/
- (void)createRightItemsWithNormalImageName1:(NSString *)imgN1
                           selectedImageName1:(NSString *)imgS1
                                      target1:(id)target1
                                      action1:(SEL)act1
                                     tipView1:(UIView *)msgTipView1
                                        Name2:(NSString *)imgN2
                           selectedImageName2:(NSString *)imgS2
                                      target2:(id)target2
                                      action2:(SEL)act2
                                     tipView2:(UIView *)msgTipView2;

/*在导航栏左侧增加带标题和返回样式的导航栏*/
-(void)createBarItemByImageName:(NSString*)imageName
                          title:(NSString*)title
                    buttonTitle:(NSString*)buttonTitle
                         target:(id)target
                         action:(SEL)action;

/*不带返回键的导航栏*/
-(void)createBackBarItemWithoutBackButtonAndTitle:(NSString*)title;

/*返回键只有文字的导航栏*/
- (void)createBarItemWithButtonTitle:(NSString*)buttonTitle;

/*增加导航栏标题*/
-(void)addTitleToNavBar:(NSString *)title;

/*返回*/
-(void)commonPushBack;

/*更改系统的返回键title*/
- (void)createSystemItemWithTitle:(NSString*)buttonTitle
                        titleText:(NSString*)titleString;
/*设置导航栏透明*/
- (void)setNavigationBarTranslucent:(BOOL)translucent;

/*
 左边有2个item的导航
 */
- (void)createBackBarItemsWithTitle:(NSString *)title
                       buttonTitle:(NSString *)buttonTitle
            closeButtonBlockHander:(void(^)(id sender))hander;


-(void)createRightBarItemByImageName:(NSString*)imageName
                              target:(id)target
                              action:(SEL)action;

- (void)addLeftBarButton:(UIButton *)leftBarButton;
- (void)addRightBarButton:(UIButton *)rigthBarButton;

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem;
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;
- (void)addLeftBarButtonItems:(NSArray *)leftBarButtonItems;
- (void)addRightBarButtonItems:(NSArray *)rightBarButtonItems;

/**
 *  左边和右边各有一个button的导航栏
 */
- (void)createLeftBarItemWithTitle:(NSString *)leftItemTitle
                 rightBarItemTitle:(NSString *)rightItemTitle
                             title:(NSString *)title
               LeftItemBlockHander:(void (^)(UIButton *))leftHander
              rightItemBlockHandle:(void (^)(UIButton *))rightHandle;

/**
 *  返回一个button
 */
- (UIButton *)barButtonItemWithTitle:(NSString *)title
                           imageName:(NSString *)imageName
                         buttonWidth:(CGFloat)width;
@end
