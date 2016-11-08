//
//  QPFileLocationManager.h
//  QuickPay
//
//  Created by Nie on 2016/11/9.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kLoginData;
extern NSString * const kVoice;
extern NSString * const kVideo;
extern NSString * const kImage;
extern NSString * const kFile;

@interface QPFileLocationManager : NSObject

/**
 *  获取应用文件夹路径
 */
+ (NSString *)getAppDocumentPath;

/**
 *  获取临时文件夹路径
 */
+ (NSString *)getAppTempPath;

/**
 *  获取用户文件夹路径
 */
+ (NSString *)getUserDirectory;

/**
 *  创建文件目录
 *
 *  @param dirName  文件目录
 *
 *  @return 文件路径
 */
+ (NSString *)createFileDir:(NSString *)dirName;

/**
 *  获取声音文件路径
 */
+ (NSString *)getVoiceFilePath;

/**
 *  生成视频文件路径
 */
+ (NSString *)getVideoFilePath;

/**
 *  生成图片文件路径
 */
+ (NSString *)getImageFilePath;

/**
 *  生成文件路径
 */
+ (NSString *)getFilePath;

+ (NSString *)genFileNameWithExt:(NSString *)ext;

+ (BOOL)deleteVoiceDir;

+ (BOOL)deleteVoiceWithSubDir:(NSString *)subDirName;

+ (BOOL)fileExistWithFileName:(NSString *)fileName;

@end
