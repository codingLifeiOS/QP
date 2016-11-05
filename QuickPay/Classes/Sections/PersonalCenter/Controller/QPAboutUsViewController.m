//
//  QPAboutUsViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/5.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPAboutUsViewController.h"

@interface QPAboutUsViewController ()

@end

@implementation QPAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"关于我们"];
    [self createBackBarItem];
    [self configureWebView];

}

#pragma mark - configureSubViews
-(void)configureWebView
{
    UIWebView * view = [[UIWebView alloc]initWithFrame:self.view.frame];
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.rrgpay.com/a/guanyuwomen/"]]];
    [self.view addSubview:view];
}

@end
