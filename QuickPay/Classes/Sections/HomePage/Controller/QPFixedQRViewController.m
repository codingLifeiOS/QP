//
//  QPFixedQRViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/15.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPFixedQRViewController.h"
#import "QPPrintInstructionsViewController.h"
@interface QPFixedQRViewController ()<UIWebViewDelegate>
{
    UIImageView *codeimage;
}
@end

@implementation QPFixedQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"店铺收款码"];
    [self createBackBarItem];
    [self configureWebView];
    [self createRightBarItemByImageName:@"dianpu_bangzhu" target:self action:@selector(printlick)];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
#pragma mark - configureSubViews
-(void)configureWebView
{
    codeimage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, SCREEN_HEIGHT-164)];
    NSString *path = [NSString stringWithFormat:@"%@/%@",QP_GetFixedQR,[QPUtils getMer_code]];
    codeimage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
    [self.view addSubview:codeimage];
    
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
    } else {
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)printlick
{
    QPPrintInstructionsViewController *QPprintQRVC = [[QPPrintInstructionsViewController alloc]init];
    [self.navigationController pushViewController:QPprintQRVC animated:YES];

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
