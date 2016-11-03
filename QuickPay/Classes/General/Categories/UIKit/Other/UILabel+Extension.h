//
//  UILabel+Extension.h
//  ShangJiaBao
//
//  Created by Nie on 15/12/8.
//  Copyright © 2015年 SongJunbao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UILabel (Extension)

- (CGFloat)autoLayouHeightForLable:(NSString *)lableText
                          fontSize:(CGFloat)fontSize
                     constrainSize:(CGSize)maxSize;
@end
