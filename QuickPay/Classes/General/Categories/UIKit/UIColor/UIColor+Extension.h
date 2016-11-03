//
//  UIColor+Extension.h
//  WeChat
//
//  Created by Nie on 16/6/27.
//  Copyright © 2016年 com.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

//
//#define BDRGBAColor(r, g, b,a) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:a]
//
//#define UIColorFromRGBA(rgbValue)[UIColor colorWithRed:((float)((rgbValue&0xFF000000)>>24))/255.0 green:((float)((rgbValue&0xFF0000)>>16))/255.0 blue:((float)((rgbValue&0xFF00)>>8))/255.0 alpha:((float)(rgbValue&0xFF))/255.0]

@interface UIColor (Extension)

+ (UIColor *)randomColor;

#pragma mark -

/**
 *  可以传入FFFFFF、#FFFFFF、0XFFFFFF类型的颜色值
 *
 *  @param hexString 色值
 *
 *  @return 透明度为1的对应UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 *  可以传入FFFFFF、#FFFFFF、0XFFFFFF类型的颜色值
 *
 *  @param hexString 色值
 *  @param alpha      0.0~1.0透明度数值
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString colorAlpha:(float)alpha;

#pragma mark - theme

/** #ebebeb */
+ (UIColor *)mis_backgroundColor;

/** #fc3159 */
+ (UIColor *)mis_themeColor;

/** #333333 */
+ (UIColor *)mis_titleColor;

/** #767676 */
+ (UIColor *)mis_subtitleColor;

/** dcdcdc */
+ (UIColor *)mis_sparatorColor;


//列表cell 文字颜色

+ (UIColor *)textOrangeColor;

+ (UIColor *)viewBackgroundGray;
+ (UIColor *)lineGray;
+ (UIColor *)textGray;
+ (UIColor *)textBlack;


+ (UIColor *)buttonGray;
+ (UIColor *)buttonBorderColor;

+ (UIColor *)backgroundGray;

+ (UIColor *)textLightGray;

+ (UIColor *)textDarkGray;

+ (UIColor *)textBlackGray;

+ (UIColor *)tabBarBackgroundGray;

+ (UIColor *)buttonEnableRed;

+ (UIColor *)buttonDisableRed;

+ (UIColor *)seperateLineColor;
@end
