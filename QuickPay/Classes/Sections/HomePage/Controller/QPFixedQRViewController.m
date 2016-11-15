//
//  QPFixedQRViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/15.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPFixedQRViewController.h"

@interface QPFixedQRViewController ()

@end

@implementation QPFixedQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"店铺收款码"];
    [self createBackBarItem];
    [self configureWebView];
    
}

#pragma mark - configureSubViews
-(void)configureWebView
{
    UIWebView * webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [webview setScalesPageToFit:YES];
    NSString * url = [NSString stringWithFormat:@"%@/%@",QP_GetFixedQR,[QPUtils getMer_code]];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:webview];
    
    UIButton *preservationBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    preservationBtn.frame=CGRectMake(0, SCREEN_HEIGHT-114, SCREEN_WIDTH, 50);
    [preservationBtn setTitle:@"保 存 到 相 册" forState:UIControlStateNormal];
    preservationBtn.backgroundColor = [UIColor orangeColor];
    [preservationBtn  addTarget:self action:@selector(preservationimage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:preservationBtn];
}

- (void)preservationimage
{
    NSString * url = [NSString stringWithFormat:@"%@/%@",QP_GetFixedQR,[QPUtils getMer_code]];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:url]];
    UIImage *image = [UIImage imageWithData:data]; // 取得图片
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
