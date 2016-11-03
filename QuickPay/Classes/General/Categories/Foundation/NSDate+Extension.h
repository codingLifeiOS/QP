//
//  NSDate+Extension.h
//  WeChat
//
//  Created by Nie on 16/7/24.
//  Copyright © 2016年 com.Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MIS)

/**
 *  判断时间是否是今天
 *
 *  @return YES or NO
 */
- (BOOL)isToday;

/**
 *  判断时间是否是昨天
 *
 *  @return YES or NO
 */
- (BOOL)isYesterday;

/**
 *  判断时间是否是今年
 *
 *  @return YES or NO
 */
- (BOOL)isThisYear;

/**
 *  将时间格式为年月日
 *
 *  @return 格式化后的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  将时间格式为年月日时分
 *
 *  @return 格式化后的时间
 */
- (NSDate *)dateWithYMDHM;

/**
 *  将时间格式化为时分
 *
 *  @return 格式化后的时间
 */
- (NSDate *)dateWithHM;

/**
 *  根据指定的时间格式返回时间
 *
 *  @param format 时间格式
 *
 *  @return 格式化后的时间
 */
- (NSDate *)dateWithFormat:(NSString *)format;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

/**
 *  获取时间对应的星期
 */
- (NSString *)getWeekday;


-(NSString *)getCurrentDay;///获取当前月的天

-(NSString *)getCurrentMonth;///获取当前月份

-(NSString *)getCurrentYear;///获取当前年份

-(NSInteger)getAllDaysInMonth;///获取某月中有多少天

- (NSUInteger)weeklyOrdinality;///计算这个月的第一天是礼拜几

- (NSDate *)dateFromString:(NSString *)dateString;///NSString转NSDate

+ (NSString *)stringFromDateFormatter:(NSDate *)date formatter:(NSString *)formStr;

+ (NSDate *)formatterDateFromString:(NSString *)date formatter:(NSString *)formStr;

//判断当前是否在某个时间段内
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour;

@end
