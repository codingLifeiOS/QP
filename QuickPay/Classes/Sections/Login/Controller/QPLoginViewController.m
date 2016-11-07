//
//  QPLoginViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/21.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPLoginViewController.h"
#import "QPLoginView.h"
#import "QPHttpManager.h"
#import "TabBarController.h"
#import "AppDelegate.h"
@interface QPLoginViewController ()<QPLoginViewDelegate>
@end

@implementation QPLoginViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureSubViews];
}

#pragma mark - configureSubViews
- (void)configureSubViews{
    QPLoginView *loginView = [[QPLoginView alloc] init];
    loginView.delegate = self;
    self.view = loginView;
}

- (void)loginBtnClickDelegateWithUsename:(NSString *)usename Password:(NSString *)password{
    
    [[QPHUDManager sharedInstance] showProgressWithText:@"登录中"];
    [QPHttpManager loginWithUsename:usename Password:password Completion:^(id responseData) {
        [[QPHUDManager sharedInstance] hiddenHUD];
        if ([[responseData objectForKey:@"resp_code"] isEqualToString:@"0000"]) {
            [[QPHUDManager sharedInstance] showTextOnly:responseData[@"resp_msg"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                delegate.window.rootViewController = [[TabBarController alloc]init];
            });
            
        } else {
            [[QPHUDManager sharedInstance] showTextOnly:responseData[@"resp_msg"]];
        }
        
    } failure:^(NSError *error) {
        
        [[QPHUDManager sharedInstance]hiddenHUD];
        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
        
    }];
}

@end
