//
//  GlobalHeader.h
//  QuickPay
//
//  Created by Nie on 16/9/5.
//  Copyright © 2016年 Nie All rights reserved.
//

#ifndef GlobalHeader_h
#define GlobalHeader_h

// 百度Map Key
static NSString * const kBaiduMapAppKey = @"I41PhbarLGqdLf9VIYIrGISDG77L6xYf";

// 接口配置
#import "InterfaceConfig.h"

//代码布局适配
#import "Masonry.h"
#import "UIView+LayoutMethods.h"

// 分类
#import "UIColor+Extension.h"
#import "UIFont+Extension.h"
#import "NSString+Extension.h"
#import "NSDate+Extension.h"
#import "UIImage+Extension.h"
#import "UIImageView+WebCache.h"
#import "UIView+Additions.h"
#import <BlocksKit/BlocksKit.h>
#import "BlocksKit+UIKit.h"

// 网络请求
#import "MJExtension.h"
#import "NSArray+Log.h"

// Controller
#import "UIViewController+BarItem.h"

// View
#import "QPHUDManager.h"
#import "BlocksKit+UIKit.h"
#import "QPAlertView.h"

// 常用宏定义
#import "Consts.h"
#import "QPStringDefines.h"
#import "QPImageDefines.h"

// Other
#import "QPUtils.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

#if DEBUG
static const int ddLogLevel = DDLogLevelInfo;
#else
static const int ddLogLevel = DDLogLevelWarning;
#endif

#endif /* GlobalHeader_h */
