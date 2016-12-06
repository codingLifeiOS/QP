//
//  QPMoreAboutViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/24.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPMoreAboutViewController.h"

#define KAlarmLocalNotificationKey @"KAlarmLocalNotificationKey"

@interface QPMoreAboutViewController ()<UIWebViewDelegate>

@end

@implementation QPMoreAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"人人购"];
    [self createBackBarItem];
    [self configureWebView];
}

#pragma mark - configureSubViews
-(void)configureWebView
{
    UIWebView * webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [webview setScalesPageToFit:YES];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.rrgpay.com"]]];
    [self.view addSubview:webview];
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [[QPHUDManager sharedInstance]showProgressWithText:@"正在加载网页"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[QPHUDManager sharedInstance]hiddenHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[QPHUDManager sharedInstance]hiddenHUD];
    [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
}
@end
