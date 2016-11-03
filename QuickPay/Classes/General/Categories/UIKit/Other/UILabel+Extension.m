//
//  UILabel+Extension.m
//  ShangJiaBao
//
//  Created by Nie on 15/12/8.
//  Copyright © 2015年 SongJunbao. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+ (void)load
{
//    //方法交换应该被保证，在程序中只会执行一次
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        //获得viewController的生命周期方法的selector
//        SEL systemSel = @selector(willMoveToSuperview:);
//        //自己实现的将要被交换的方法的selector
//        SEL swizzSel = @selector(myWillMoveToSuperview:);
//        //两个方法的Method
//        Method systemMethod = class_getInstanceMethod([self class], systemSel);
//        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
//        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
//        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
//        if (isAdd) {
//            //如果成功，说明类中不存在这个方法的实现
//            //将被交换方法的实现替换到这个并不存在的实现
//            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
//        } else {
//            //否则，交换两个方法的实现
//            method_exchangeImplementations(systemMethod, swizzMethod);
//        }
//    });
}

- (void)myWillMoveToSuperview:(UIView *)newSuperview {
    [self myWillMoveToSuperview:newSuperview];
     if (self) {
//        此处用于某些特定的用系统方法
//        if (self.tag == 1314) {
//            self.font  = [UIFont fontWithName:LanTingFont size:self.font.pointSize];
//         } else {
        self.font  = [UIFont fontWithName:LanTingFont size:self.font.pointSize];
//        }
    }
}

- (CGFloat)autoLayouHeightForLable:(NSString *)lableText
                          fontSize:(CGFloat)fontSize
                     constrainSize:(CGSize)maxSize {
    
    CGSize constraintSize;
    
    //对比最大约束maxSize与CGSizeZero是否相等,如果是的话给他赋一个初值。以无限高为最大高度，以屏幕宽-30为宽度。如果不相等可以直接沿用
    if (CGSizeEqualToSize(maxSize, CGSizeZero)) {
        
        constraintSize = CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX);
    }else{
        constraintSize = maxSize;
    }
    
    
    //计算方式   记得一般情况要有Origin
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin;
    /*
     *字符串计算方式，NSStringDrawingUsesLineFragmentOrigin是以每行组成的矩形为单位计算整个文本的尺寸
     *UsesFontLeading则以字体间的行距（leading，行距：从一行文字的底部到另一行文字底部的间距。）来计算。
     *如果为NSStringDrawingTruncatesLastVisibleLine那么计算文本尺寸时将以每个字或字形为单位来计算。
     *如果为NSStringDrawingUsesDeviceMetric，那么计算文本尺寸时将以每个字或字形为单位来计算。
     */
    
    //设置字符串字体号,字体颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[[UIFont systemFontOfSize:fontSize],[UIColor blueColor]] forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName]];
    
    //iOS7以后用这个方法来计算lable自定义高度
    CGRect stringRect = [lableText boundingRectWithSize:constraintSize options:options attributes:dic context:nil];
    
    return stringRect.size.height;
}
@end
