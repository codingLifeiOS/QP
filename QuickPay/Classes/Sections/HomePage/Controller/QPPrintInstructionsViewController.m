//
//  QPPrintInstructionsViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/26.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPPrintInstructionsViewController.h"

@interface QPPrintInstructionsViewController ()
{
    UIScrollView *_scrollView;
}
@end

@implementation QPPrintInstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"使用说明"];
    [self createBackBarItem];
    [self configureUIScrollView];
}

#pragma mark - configureUIScrollView
-(void)configureUIScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"dayinshuom"];
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [scrollView addSubview:imageView];
    scrollView.contentSize = imageView.size;
    // 去掉弹簧效果
    scrollView.bounces = NO;
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    _scrollView = scrollView;
}
@end