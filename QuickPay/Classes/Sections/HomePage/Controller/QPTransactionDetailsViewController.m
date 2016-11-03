//
//  QPTransactionDetailsViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/28.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPTransactionDetailsViewController.h"
#import "QPTransactionDetailsView.h"
@interface QPTransactionDetailsViewController ()

@end

@implementation QPTransactionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"交易详情"];
    [self createBackBarItem];
    [self configureSubViews];
}
#pragma mark - configureSubViews
- (void)configureSubViews{
    
    QPTransactionDetailsView *transacdetView =[[QPTransactionDetailsView alloc] init];
    self.view = transacdetView;
}

@end
