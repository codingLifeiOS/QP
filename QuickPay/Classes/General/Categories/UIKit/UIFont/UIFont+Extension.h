//
//  UIFont+Extension.h
//  WeChat
//
//  Created by Nie on 16/6/27.
//  Copyright © 2016年 com.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Extension)

/**
 *  创建小号 11
 *
 *  @return 字体
 */
+ (UIFont *)mis_tinyFont;

/**
 *  创建小号加粗字体 11
 *
 *  @return 字体
 */
+ (UIFont *)mis_tinyBoldFont;

/**
 *  创建小号字体 13
 *
 *  @return 字体
 */
+ (UIFont *)mis_smallFont;

/**
 *  创建小号加粗字体 13
 *
 *  @return 字体
 */
+ (UIFont *)mis_smallBoldFont;

/**
 *  创建中号字体 15
 *
 *  @return 字体
 */
+ (UIFont *)mis_normalFont;

/**
 *  创建中号加粗字体 15
 *
 *  @return 字体
 */
+ (UIFont *)mis_normalBoldFont;

/**
 *  创建大号字体 17
 *
 *  @return 字体
 */
+ (UIFont *)mis_largeFont;

/**
 *  创建大号加粗字体 17
 *
 *  @return 字体
 */
+ (UIFont *)mis_largeBoldFont;

/**
 *  创建超大号字体 19
 *
 *  @return 字体
 */
+ (UIFont *)mis_bigFont;

/**
 *  创建超大号加粗字体 19
 *
 *  @return 字体
 */
+ (UIFont *)mis_bigBoldFont;

+ (UIFont *)helveticaFontWithSize:(CGFloat)fontSize;
+ (UIFont *)boldFontWithSize:(CGFloat)fontSize;
+ (UIFont *)numberFontWithSize:(CGFloat)fontSize;

@end
