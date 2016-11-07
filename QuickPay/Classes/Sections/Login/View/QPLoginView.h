//
//  QPLoginView.h
//  QuickPay
//
//  Created by Nie on 2016/10/25.
//
//

#import <UIKit/UIKit.h>
@protocol  QPLoginViewDelegate <NSObject>
- (void)loginBtnClickDelegateWithUsename:(NSString*)usename Password:(NSString*)password;

@end
@interface QPLoginView : UIView
@property (strong,nonatomic) UITextField *loginIdTextField;
@property (strong,nonatomic) UITextField *passwordTextField;
@property (nonatomic,weak) id <QPLoginViewDelegate>delegate;
@end
