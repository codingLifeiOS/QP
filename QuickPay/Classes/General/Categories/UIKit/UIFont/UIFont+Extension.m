//
//  UIFont+Extension.m
//  WeChat
//
//  Created by Nie on 16/6/27.
//  Copyright © 2016年 com.Liu. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)

+ (UIFont *)mis_tinyFont {
    return [UIFont systemFontOfSize:11];
}

+ (UIFont *)mis_tinyBoldFont {
    return [UIFont boldSystemFontOfSize:11];
}

+ (UIFont *)mis_smallFont {
    return [UIFont systemFontOfSize:13];
}

+ (UIFont *)mis_smallBoldFont {
    return [UIFont boldSystemFontOfSize:13];
}

+ (UIFont *)mis_normalFont {
    return [UIFont systemFontOfSize:15];
}

+ (UIFont *)mis_normalBoldFont {
    return [UIFont boldSystemFontOfSize:15];
}

+ (UIFont *)mis_largeFont {
    return [UIFont systemFontOfSize:17];
}

+ (UIFont *)mis_largeBoldFont {
    return [UIFont boldSystemFontOfSize:17];
}

+ (UIFont *)mis_bigFont {
    return [UIFont systemFontOfSize:19];
}

+ (UIFont *)mis_bigBoldFont {
    return [UIFont boldSystemFontOfSize:19];
}


+ (UIFont *)helveticaFontWithSize:(CGFloat)fontSize {
    
    return [self fontWithName:FONT_OF_NORMAL size:fontSize];
}

+ (UIFont *)boldFontWithSize:(CGFloat)fontSize {
    
    return [self fontWithName:FONT_OF_BOLD size:fontSize];
}

+ (UIFont *)numberFontWithSize:(CGFloat)fontSize {
    
    return [self fontWithName:NUMBER_FONT size:fontSize];
}

@end
