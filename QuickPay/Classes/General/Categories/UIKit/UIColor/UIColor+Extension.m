//
//  UIColor+Extension.m
//  WeChat
//
//  Created by Nie on 16/6/27.
//  Copyright © 2016年 com.Liu. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)randomColor {
    
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark - colorWithHex

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    
    return [UIColor colorWithHexString:hexString colorAlpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString colorAlpha:(float)alpha {
    
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor clearColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range = NSMakeRange(0, 2);
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

#pragma mark - theme

+ (UIColor *)mis_backgroundColor {
    
    return [self colorWithHexString:@"#f1f1f1"];
}

+ (UIColor *)mis_themeColor {
    
    return [self colorWithHexString:@"#ff2e55"];
}

+ (UIColor *)mis_titleColor {
    
    return [UIColor blackColor];
//    return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)mis_subtitleColor {
    
    return [self colorWithHexString:@"#767676"];
}

+ (UIColor *)mis_sparatorColor {
    
    return [self colorWithHexString:@"#dcdcdc"];
}

#pragma mark -

+ (UIColor *)textOrangeColor {
    
    return UIColorFromHex(0xfa8538);
}

+ (UIColor *)viewBackgroundGray {
    
    return UIColorFromHex(0xf6f6f6);
}

+ (UIColor *)lineGray {
    
    return UIColorFromHex(0xdcdcdc);
}

+ (UIColor *)textGray {

    return UIColorFromHex(0xaaaaaa);
}

+ (UIColor *)textBlack {
    
    return UIColorFromHex(0x555555);
}

+ (UIColor *)buttonGray {
    
    return UIColorFromHex(0xfdfdfd);
}

+ (UIColor *)buttonBorderColor {
    
    return UIColorFromHex(0xbbbbbb);
}

+ (UIColor *)backgroundGray {
    
    return UIColorFromHex(0xe2e2e2);
}

+ (UIColor *)textLightGray {
    
    return UIColorFromHex(0x99959E);
}

+ (UIColor *)textDarkGray {
    
    return UIColorFromHex(0x666666);
}

+ (UIColor *)textBlackGray {
    
    return UIColorFromHex(0x2c2c2c);
}

+ (UIColor *)tabBarBackgroundGray {
    
    return UIColorFromHex(0xe6e6e6);
}

+ (UIColor *)buttonEnableRed {
    return UIColorFromHex(0xee5153);
}

+ (UIColor *)buttonDisableRed {
    return UIColorFromHex(0xf6a6a7);
}

+ (UIColor *)seperateLineColor {
    return UIColorFromHex(0xdcdcdc);
}
@end
