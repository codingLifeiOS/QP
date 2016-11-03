//
//  UIView+layerAdditions.h
//  QuickPay
//
//  Created by Nie on 16/9/9.
//  Copyright © 2016年 Nie All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (layerAdditions)

@property (nonatomic, assign) IBInspectable CGFloat bx_borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *bx_borderColor;
@property (nonatomic, assign) IBInspectable CGFloat bx_cornerRadius;
@property (nonatomic, assign) IBInspectable BOOL bx_maskToBounds;

@end
