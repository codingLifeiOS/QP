//
//  QPAccountRecordDetailsViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/28.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPAccountRecordDetailsViewController.h"
#import "QPAccountRecordDetailsView.h"
@interface QPAccountRecordDetailsViewController ()

@end

@implementation QPAccountRecordDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"到账记录"];
    [self createBackBarItem];
    [self configureSubViews];
}
#pragma mark - configureSubViews
- (void)configureSubViews{
    
    QPAccountRecordDetailsView *accrecdetView = [[QPAccountRecordDetailsView alloc] init]; 
    self.view = accrecdetView;
}


@end
