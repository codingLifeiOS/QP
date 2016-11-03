//
//  QuickPayUtils.h
//  QuickPay
//
//  Created by Nie on 16/9/23.
//  Copyright © 2016年 Nie All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QPUtils : NSObject

// 获取app版本
+ (NSString *)getAPPVersion;

// 获取app build版本
+ (NSString *)getAPPBuild;

// 获取接口version头数据
+ (NSString *)getVersionHeader;

// 获取设备IMEI
+ (NSString *)getDeviceIMEI;

// 获取设备信息
+ (NSString *)getDeviceVersionInfo;

// 获取设备型号
+ (NSString *)getDeviceModel;

@end
