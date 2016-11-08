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
#import "QPUserModel.h"
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
            
            [[NSUserDefaults standardUserDefaults] setObject:responseData[@"mer_code"] forKey:@"mer_code"];
            [[NSUserDefaults standardUserDefaults] setObject:responseData[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            // 登录成功 请求商户详情保存到本地
            [self getMerInfo];

        } else {
            [[QPHUDManager sharedInstance] showTextOnly:responseData[@"resp_msg"]];
        }
        
    } failure:^(NSError *error) {
        
        [[QPHUDManager sharedInstance]hiddenHUD];
        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
        
    }];
}

- (void)getMerInfo{

   [QPHttpManager getMerinfoCompletion:^(id responseData) {
       
      QPUserModel *userModel = [[QPUserModel alloc]initWithDictionary:responseData];
       NSString *path = NSHomeDirectory();
       NSString *userPath = [path stringByAppendingString:[QPUtils getMer_code]];
       NSString *filePath = [userPath stringByAppendingPathComponent:@"merInfo.data"];
       NSMutableArray *merInfoList = [[NSMutableArray alloc]init];
       [merInfoList addObject:userModel];
       // 归档
       [NSKeyedArchiver archiveRootObject: merInfoList toFile:filePath];
       
       dispatch_async(dispatch_get_main_queue(), ^{
           
           AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
           delegate.window.rootViewController = [[TabBarController alloc]init];
       });

   } failure:^(NSError *error) {
       
   }];
}
@end
