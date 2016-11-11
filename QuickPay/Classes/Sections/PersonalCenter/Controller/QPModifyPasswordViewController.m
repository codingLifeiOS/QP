//
//  QPModifyPasswordViewController.m
//  QuickPay
//
//  Created by Nie on 2016/11/11.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPModifyPasswordViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "QPLoginViewController.h"

@interface QPModifyPasswordViewController ()<UITextFieldDelegate>
@property (strong,nonatomic) UITextField *oldpasswordTextField;
@property (strong,nonatomic) UITextField *onepasswordTextField;
@property (strong,nonatomic) UITextField *twopasswordTextField;
@end

@implementation QPModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleToNavBar:@"修改密码"];
    [self createBackBarItem];
    self.view.backgroundColor = UIColorFromHex(0xf8f8f8);
    [self configureView];

}
#pragma mark - configureSubViews
-(void)configureView
{
   
    UILabel *oldlab =  [[UILabel alloc]initWithFrame:CGRectMake(30, 20, SCREEN_WIDTH-60, 30)];
    oldlab.text = @"请输入旧密码";
    [self.view addSubview:oldlab];
    
    self.oldpasswordTextField = [[UITextField alloc] init];
    self.oldpasswordTextField.frame = CGRectMake(oldlab.x,oldlab.bottom, oldlab.width, 40);
    self.oldpasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.oldpasswordTextField.returnKeyType = UIReturnKeyDone;
    self.oldpasswordTextField.backgroundColor = [UIColor whiteColor];
    self.oldpasswordTextField.layer.borderWidth=2.0f;
    self.oldpasswordTextField.layer.cornerRadius = 8.0f;
    self.oldpasswordTextField.layer.borderColor=[[UIColor orangeColor]CGColor];
    self.oldpasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.oldpasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.oldpasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.oldpasswordTextField.delegate = self;
    [self.view addSubview:self.oldpasswordTextField];
    
    UILabel *onepasswordlab =  [[UILabel alloc]initWithFrame:CGRectMake(self.oldpasswordTextField.x, self.oldpasswordTextField.bottom, self.oldpasswordTextField.width, 30)];
    onepasswordlab.text = @"请输入新密码";
    [self.view addSubview:onepasswordlab];
    
    self.onepasswordTextField = [[UITextField alloc] init];
    self.onepasswordTextField.frame=CGRectMake(self.oldpasswordTextField.x,onepasswordlab.bottom, self.oldpasswordTextField.width,self.oldpasswordTextField.height);
    self.onepasswordTextField.returnKeyType = UIReturnKeyDone;
    self.onepasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.onepasswordTextField.backgroundColor = [UIColor whiteColor];
    self.onepasswordTextField.layer.borderWidth=2.0f;
    self.onepasswordTextField.layer.cornerRadius = 8.0f;
    self.onepasswordTextField.layer.borderColor=[[UIColor orangeColor]CGColor];
    self.onepasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.onepasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.onepasswordTextField  setSecureTextEntry:YES];
    self.onepasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.onepasswordTextField.delegate = self;
    [self.view addSubview:self.onepasswordTextField];

    UILabel *twopasswordlab =  [[UILabel alloc]initWithFrame:CGRectMake(self.onepasswordTextField.x, self.onepasswordTextField.bottom, self.onepasswordTextField.width, 30)];
    twopasswordlab.text = @"确认新密码";
    [self.view addSubview:twopasswordlab];
    
    self.twopasswordTextField = [[UITextField alloc] init];
    self.twopasswordTextField.frame=CGRectMake(self.onepasswordTextField.x,twopasswordlab.bottom, self.onepasswordTextField.width,self.onepasswordTextField.height);
    self.twopasswordTextField.returnKeyType = UIReturnKeyDone;
    self.twopasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.twopasswordTextField.backgroundColor = [UIColor whiteColor];
    self.twopasswordTextField.layer.borderWidth=2.0f;
    self.twopasswordTextField.layer.cornerRadius = 8.0f;
    self.twopasswordTextField.layer.borderColor=[[UIColor orangeColor]CGColor];
    self.twopasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.twopasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.twopasswordTextField  setSecureTextEntry:YES];
    self.twopasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.twopasswordTextField.delegate = self;
    [self.view addSubview:self.twopasswordTextField];
    
    UIButton *footBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame=CGRectMake(self.twopasswordTextField.x, self.twopasswordTextField.bottom+30, self.twopasswordTextField.width, 40);
    [footBtn setBackgroundImage:[UIImage imageNamed:@"mima_tijiao"] forState:UIControlStateNormal];
    [footBtn setBackgroundImage:[UIImage imageNamed:@"mima_tijiao"] forState:UIControlStateHighlighted];
    [footBtn  addTarget:self action:@selector(performSubmitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:footBtn];

}
#pragma mark - ButtonAction
- (void)performSubmitAction
{
    if (self.oldpasswordTextField.text.length == 0) {
        [[QPHUDManager sharedInstance]showTextOnly:@"请输入旧密码"];
        return;
    }
    
    if ( self.onepasswordTextField.text.length == 0) {
        [[QPHUDManager sharedInstance]showTextOnly:@"请输入新密码"];
        return;
    }
    
    if ( self.twopasswordTextField.text.length == 0) {
        [[QPHUDManager sharedInstance]showTextOnly:@"请确认新密码"];
        return;
    }
    
    if (self.oldpasswordTextField.text.length > 0 && self.onepasswordTextField.text.length > 0 && self.twopasswordTextField.text.length > 0) {
        QPLoginViewController *QPloginVC = [[QPLoginViewController alloc]init];
        [self.navigationController pushViewController:QPloginVC animated:YES];
    } else {
        [[QPHUDManager sharedInstance]hiddenHUD];
        [[QPHUDManager sharedInstance]showTextOnly:@"两次密码不一致"];
    }

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.view endEditing:YES];
    return YES;
}

@end
