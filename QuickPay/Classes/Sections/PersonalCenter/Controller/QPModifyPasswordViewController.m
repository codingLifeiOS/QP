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
#import "QPHttpManager.h"
@interface QPModifyPasswordViewController ()<UITextFieldDelegate>
@property (strong,nonatomic) UITextField *oldpasswordTextField;
@property (strong,nonatomic) UITextField *newpasswordTextField;
@property (strong,nonatomic) UITextField *confirmpasswordTextField;
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
    oldlab.text = @"请输入旧密码:";
    [self.view addSubview:oldlab];
    
    self.oldpasswordTextField = [[UITextField alloc] init];
    self.oldpasswordTextField.frame = CGRectMake(oldlab.x,oldlab.bottom, oldlab.width, 40);
    self.oldpasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.oldpasswordTextField.returnKeyType = UIReturnKeyDone;
    self.oldpasswordTextField.backgroundColor = [UIColor whiteColor];
    self.oldpasswordTextField.layer.borderWidth = 1.0f;
    self.oldpasswordTextField.layer.cornerRadius = 8.0f;
    self.oldpasswordTextField.layer.borderColor=[[UIColor orangeColor]CGColor];
    self.oldpasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.oldpasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.oldpasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.oldpasswordTextField.delegate = self;
    [self.view addSubview:self.oldpasswordTextField];
    
    UILabel *onepasswordlab =  [[UILabel alloc]initWithFrame:CGRectMake(self.oldpasswordTextField.x, self.oldpasswordTextField.bottom, self.oldpasswordTextField.width, 30)];
    onepasswordlab.text = @"请输入新密码:";
    [self.view addSubview:onepasswordlab];
    
    self.newpasswordTextField = [[UITextField alloc] init];
    self.newpasswordTextField.frame=CGRectMake(self.oldpasswordTextField.x,onepasswordlab.bottom, self.oldpasswordTextField.width,self.oldpasswordTextField.height);
    self.newpasswordTextField.returnKeyType = UIReturnKeyDone;
    self.newpasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.newpasswordTextField.backgroundColor = [UIColor whiteColor];
    self.newpasswordTextField.layer.borderWidth = 1.0f;
    self.newpasswordTextField.layer.cornerRadius = 8.0f;
    self.newpasswordTextField.layer.borderColor=[[UIColor orangeColor]CGColor];
    self.newpasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.newpasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.newpasswordTextField  setSecureTextEntry:YES];
    self.newpasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.newpasswordTextField.delegate = self;
    [self.view addSubview:self.newpasswordTextField];

    UILabel *twopasswordlab =  [[UILabel alloc]initWithFrame:CGRectMake(self.newpasswordTextField.x, self.newpasswordTextField.bottom, self.newpasswordTextField.width, 30)];
    twopasswordlab.text = @"确认新密码:";
    [self.view addSubview:twopasswordlab];
    
    self.confirmpasswordTextField = [[UITextField alloc] init];
    self.confirmpasswordTextField.frame=CGRectMake(self.newpasswordTextField.x,twopasswordlab.bottom, self.newpasswordTextField.width,self.newpasswordTextField.height);
    self.confirmpasswordTextField.returnKeyType = UIReturnKeyDone;
    self.confirmpasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.confirmpasswordTextField.backgroundColor = [UIColor whiteColor];
    self.confirmpasswordTextField.layer.borderWidth = 1.0f;
    self.confirmpasswordTextField.layer.cornerRadius = 8.0f;
    self.confirmpasswordTextField.layer.borderColor=[[UIColor orangeColor]CGColor];
    self.confirmpasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.confirmpasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.confirmpasswordTextField  setSecureTextEntry:YES];
    self.confirmpasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.confirmpasswordTextField.delegate = self;
    [self.view addSubview:self.confirmpasswordTextField];
    
    UIButton *footBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame=CGRectMake(self.confirmpasswordTextField.x, self.confirmpasswordTextField.bottom+30, self.confirmpasswordTextField.width, 40);
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
    if ( self.newpasswordTextField.text.length == 0) {
        [[QPHUDManager sharedInstance]showTextOnly:@"请输入新密码"];
        return;
    }
    
    if ( self.confirmpasswordTextField.text.length == 0) {
        [[QPHUDManager sharedInstance]showTextOnly:@"请确认新密码"];
        return;
    }
    
    if ( self.confirmpasswordTextField.text.length < 4) {
        [[QPHUDManager sharedInstance]showTextOnly:@"密码长度至少四位以上"];
        return;
    }

    if ([self.newpasswordTextField.text isEqualToString: self.confirmpasswordTextField.text]) {
        WEAKSELF();
        [[QPHUDManager sharedInstance]showProgressWithText:@"提交中"];
        [QPHttpManager changePassWordWitholdpassword:self.oldpasswordTextField.text newpassword:self.newpasswordTextField.text Completion:^(id responseData) {
            [[QPHUDManager sharedInstance]hiddenHUD];
            STRONGSELF();
             [[QPHUDManager sharedInstance]showTextOnly:responseData[@"resp_msg"]];
            if ([[responseData objectForKey:QP_ResponseCode] isEqualToString:QP_Response_SuccsessCode]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.navigationController popViewControllerAnimated:YES];
                });
             }
        } failure:^(NSError *error) {
            [[QPHUDManager sharedInstance]hiddenHUD];
            [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
        }];
    } else {
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
