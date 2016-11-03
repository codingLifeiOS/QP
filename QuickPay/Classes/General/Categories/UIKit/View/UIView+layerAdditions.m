//
//  UIView+layerAdditions.m
//  QuickPay
//
//  Created by Nie on 16/9/9.
//  Copyright © 2016年 Nie All rights reserved.
//

#import "UIView+layerAdditions.h"
#import <objc/runtime.h>

@implementation UIView (layerAdditions)

- (void)setBx_borderColor:(UIColor *)bx_borderColor
{
    objc_setAssociatedObject(self, @selector(bx_borderColor), bx_borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderColor = bx_borderColor.CGColor;
}

- (UIColor *)bx_borderColor
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBx_borderWidth:(CGFloat)bx_borderWidth
{
    objc_setAssociatedObject(self, @selector(bx_borderWidth), @(bx_borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderWidth = bx_borderWidth;
}

- (CGFloat)bx_borderWidth
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setBx_cornerRadius:(CGFloat)bx_cornerRadius
{
    objc_setAssociatedObject(self, @selector(bx_cornerRadius), @(bx_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.cornerRadius = bx_cornerRadius;
}

- (CGFloat)bx_cornerRadius
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setBx_maskToBounds:(BOOL)bx_maskToBounds
{
    objc_setAssociatedObject(self, @selector(bx_maskToBounds), @(bx_maskToBounds), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.masksToBounds = bx_maskToBounds;
}

- (BOOL)bx_maskToBounds
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
