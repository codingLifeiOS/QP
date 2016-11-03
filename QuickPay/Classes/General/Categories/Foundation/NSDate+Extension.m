//
//  NSDate+Extension.m
//  WeChat
//
//  Created by Nie on 16/7/24.
//  Copyright © 2016年 com.Liu. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

#pragma mark - Verification

/**
 *  是否为今天
 */
- (BOOL)isToday {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *components = [calendar components:unit fromDate:self];
    
    return (components.year == components.year) && (components.month == nowComponents.month) && (components.day == nowComponents.day);
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];

    NSDate *nowDate = [[NSDate date] dateWithYMD];
    NSDate *date = [self dateWithYMD];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:date toDate:nowDate options:0];
    return components.day == 1;
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    int unit = NSCalendarUnitYear;
    
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *components = [calendar components:unit fromDate:self];
    
    return nowComponents.year == components.year;
}

#pragma mark - Format

/**
 *  返回一个格式为年月日的时间
 */
- (NSDate *)dateWithYMD {
    
    return [self dateWithFormat:@"yyyy-MM-dd"];
}

/**
 *  返回格式为年月日时分的时间
 */
- (NSDate *)dateWithYMDHM {
    
    return [self dateWithFormat:@"yyyy-MM-dd HH:mm"];
}

/**
 *  返回格式为时分的时间
 */
- (NSDate *)dateWithHM {
    
    return [self dateWithFormat:@"HH:mm"];
}

- (NSDate *)dateWithFormat:(NSString *)format {
    
    if ([NSString isBlank:format]) return nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = format;
    NSString *dateStr = [formatter stringFromDate:self];
    return [formatter dateFromString:dateStr];

}

#pragma mark - DateComponents

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

// 获取时间对应的星期数
- (NSString *)getWeekday {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSInteger unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    components = [calendar components:unit fromDate:self];
    NSInteger weekday = [components weekday];
    
    switch (weekday) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    
    return @"";
}


/*获取当前天*/
-(NSString *)getCurrentDay {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"dd"];
    NSString *dateTime = [formater stringFromDate:self];
    return dateTime;
    
}

/*获取当前月份*/
-(NSString *)getCurrentMonth{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"MM"];
    NSString *dateTime = [formater stringFromDate:self];
    return dateTime;
}

/*获取当前年份*/
-(NSString *)getCurrentYear{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy"];
    NSString *dateTime = [formater stringFromDate:self];
    return dateTime;
}

/*获取某月的有多少天*/
-(NSInteger)getAllDaysInMonth {
    NSInteger allDays;
    allDays =  [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    return allDays;
}

/*计算这个月的第一天是礼拜几*/
- (NSUInteger)weeklyOrdinality {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSDate *date = [calendar dateFromComponents:compt];
    return [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:self];
}

/*string 转为date */
- (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+ (NSString *)stringFromDateFormatter:(NSDate *)date formatter:(NSString *)formStr
{
   NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formStr;
    return [formatter stringFromDate:date];
}

+ (NSDate *)formatterDateFromString:(NSString *)date formatter:(NSString *)formStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formStr;
    return [formatter dateFromString:date];
}

+ (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
    
}

+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *fromDate = [self getCustomDateWithHour:fromHour];
    NSDate *toDate = [self getCustomDateWithHour:toHour];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:fromDate]==NSOrderedDescending && [currentDate compare:toDate]==NSOrderedAscending)
    {
        NSLog(@"该时间在 %ld:00-%ld:00 之间！", (long)fromHour, (long)toHour);
        return YES;
    }
    return NO;
}
@end
