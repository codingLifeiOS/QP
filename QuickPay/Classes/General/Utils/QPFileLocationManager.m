//
//  QPFileLocationManager.m
//  QuickPay
//
//  Created by Nie on 2016/11/9.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "QPFileLocationManager.h"
#import<CommonCrypto/CommonDigest.h>

NSString * const kLoginData = @"MIS_Login_Data";
NSString * const kVoice = @"voice";
NSString * const kVideo = @"video";
NSString * const kImage = @"image";
NSString * const kFile = @"file";


@implementation QPFileLocationManager


#pragma mark - getter

+ (NSString *)getAppDocumentPath {
    
    static NSString *appDocumentPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *appKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        appDocumentPath = [[NSString alloc] initWithFormat:@"%@/%@/",[paths objectAtIndex:0], appKey];
        if (![[NSFileManager defaultManager] fileExistsAtPath:appDocumentPath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:appDocumentPath
                                      withIntermediateDirectories:NO
                                                       attributes:nil
                                                            error:nil];
        }
        [QPFileLocationManager addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:appDocumentPath]];
    });
    return appDocumentPath;
    
}

+ (NSString *)getAppTempPath {
    
    return NSTemporaryDirectory();
}

+ (NSString *)getUserDirectory {
    
    NSString *documentPath = [QPFileLocationManager getAppDocumentPath];
    NSString *userID = [QPUtils getMer_code];
    if ([userID length] == 0) {
        NSLog(@"Error: UserID为空，获取用户目录失败!");
    }
    
    NSString *userDirectory = [NSString stringWithFormat:@"%@%@/", documentPath, userID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:userDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:userDirectory
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:nil];
        
    }
    return userDirectory;
}

+ (NSString *)createFileDir:(NSString *)dirName {
    
    NSString *dirPath = dirName;
    if (![dirName containsString:[self getUserDirectory]])
        dirPath = [[self getUserDirectory] stringByAppendingString:[NSString stringWithFormat:@"%@/", dirName]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:nil];
    }
    return dirPath;
}

+ (NSString *)getVoiceFilePath {
    
    return [self createFileDir:kVoice];
}

+ (NSString *)getVideoFilePath {
    
    return [self createFileDir:kVideo];
}

+ (NSString *)getImageFilePath {
    
    return [self createFileDir:kImage];
}

+ (NSString *)getFilePath {
    
    return [self createFileDir:kFile];
}

+ (NSString *)genFileNameWithExt:(NSString *)ext {
    
    CFUUIDRef uuid = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuid);
    CFRelease(uuid);
    NSString *uuidStr = [[uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
    NSString *name = [NSString stringWithFormat:@"%@",uuidStr];
    return [ext length] ? [NSString stringWithFormat:@"%@.%@", name, ext] : name;
}

+ (BOOL)deleteVoiceDir{
    
    return NO;
}

+ (BOOL)deleteVoiceWithSubDir:(NSString *)subDirName{
    
    return NO;
}
#pragma mark - 辅助方法

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL {
    
    assert([[NSFileManager defaultManager] fileExistsAtPath:[URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:&error];
    if(!success) {
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+ (BOOL)fileExistWithFileName:(NSString *)fileName {
    NSString *filePath = [[QPFileLocationManager getFilePath] stringByAppendingPathComponent:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return YES;
    }
    return NO;
}

@end
