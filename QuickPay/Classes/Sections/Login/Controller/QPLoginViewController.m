//
//  QPLoginViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/21.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPLoginViewController.h"
#import "QPLoginView.h"


@interface QPLoginViewController ()
@end

@implementation QPLoginViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureSubViews];
}

#pragma mark - configureSubViews
- (void)configureSubViews{
    QPLoginView *loginView =[[QPLoginView alloc] init];
    self.view = loginView;
}


@end
