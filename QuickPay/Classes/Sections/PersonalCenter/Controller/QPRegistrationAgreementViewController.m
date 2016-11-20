//
//  QPRegistrationAgreementViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/19.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPRegistrationAgreementViewController.h"

@interface QPRegistrationAgreementViewController ()<UIWebViewDelegate>

@end

@implementation QPRegistrationAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTitleToNavBar:[self.serviceAgreementDict objectForKey:@"name"]];
    [self createBackBarItem];
    [self configureWebView];
    
}

#pragma mark - configureSubViews
-(void)configureWebView
{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.serviceAgreementDict objectForKey:@"value"]]]];
    [self.view addSubview:webView];
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
