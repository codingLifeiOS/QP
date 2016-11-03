//
//  LGLAlertView.h
//  LGLAlertView-Dome
//
//  Created by 李国良 on 2016/9/29.
//  Copyright © 2016年 李国良. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//警告框
typedef NS_ENUM(NSInteger, LGLAlertViewActionStyle) {
    LGLAlertViewActionStyleDefault = 0,
    LGLAlertViewActionStyleCancel,
    LGLAlertViewActionStyleDestructive
};

/** alertView的回调block */

typedef void (^CallBackBlock)(NSInteger btnIndex);

/** alertView的回调block */

typedef void (^TextFieldCallBackBlock)(NSString * text);


@interface LGLAlertView : NSObject

/**
 * 单个或者没有按钮 不执行任何操作 只是提示总用
 *  title    提示的标题
 *  message  提示信息
 *  btnTitle 单个按钮的标题名称
 *
 */
+ (void)showAlertViewWith:(UIViewController *)viewController title:(NSString *)title
            message:(NSString *)message buttonTitle:(NSString *)btnTitle
              buttonStyle:(LGLAlertViewActionStyle)buttonStyle;

/***
 * 有两个或者多个按钮 确定 取消
 *  title             提示的标题
 *  message           提示信息
 *  btnTitle          单个按钮的标题名称
 *  cancelBtnTitleBtn    destructiveBtn按钮
 *  otherButtonTitles 确定按钮
 */
+ (void)showAlertViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message
            CallBackBlock:(CallBackBlock)textBlock cancelButtonTitle:(NSString *)cancelBtnTitle
                destructiveButtonTitle:(NSString *)destructiveBtnTitle
                    otherButtonTitles:(NSString *)otherBtnTitles,...NS_REQUIRES_NIL_TERMINATION;


/**
 * 有输入框  确定 取消 (注： 这里只做了有一个输入框)
 *  title             提示的标题
 *  message           提示信息
 *  btnTitle          单个按钮的标题名称
 *  cancelBtnTitle 取消按钮
 *  destructiveBtn    destructiveBtn按钮
 *  otherBtnTitle 确定按钮
 */

+ (void)showAlertTextFieldViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message
            TextFeildCallBackBlock:(TextFieldCallBackBlock)block cancelButtonTitle:(NSString *)cancelBtnTitle
                otherButtonTitles:(NSString *)otherBtnTitle;

/**
 * 单个或者没有按钮ActionSheet 仅仅只是提示作用 按钮没有响应事件
 *  title    提示的标题
 *  message  提示信息
 *  btnTitle 单个按钮的标题名称
 *
 */
+ (void)showAlertActionSheetViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message
              buttonTitle:(NSString *)btnTitle buttonStyle:(LGLAlertViewActionStyle)buttonStyle;

/**
 * 没有按钮ActionSheet 按钮有响应事件
 *  title    提示的标题
 *  message  提示信息
 *  btnTitle 单个按钮的标题名称
 *
 */
+ (void)showAlertActionSheetWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message
              callbackBlock:(CallBackBlock)block destructiveButtonTitle:(NSString *)destructiveBtnTitle
                cancelButtonTitle:(NSString *)cancelBtnTitle
                    otherButtonTitles:(NSString *)otherBtnTitles, ...NS_REQUIRES_NIL_TERMINATION;
@end
