//
//  FTTimeUtil.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTTimeUtil.h"

@interface FTTimeUtil ()


@end

@implementation FTTimeUtil


+ (NSString *)formatDateByTimeInterval:(NSString *)timeInterval
{
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]/1000];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df stringFromDate:dt];
}

+ (NSString *)formatTimeIntervalByDateString:(NSString *)dateString
{
    dateString = [NSString stringWithFormat:@"%f",[dateString doubleValue]/1000];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [df dateFromString:dateString];
    return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
}


//格式化时间戳格式的时间
+ (NSString *)formatTimeStr1:(NSString *)timeStr andType:(NSString *)type
{
    //当时间戳精确到毫秒时需要添加以下这行代码
    //    timeStr = [NSString stringWithFormat:@"%zd",[timeStr integerValue]/1000];
    
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]/1000];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    if ([type isEqualToString:@"1"]) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    else if ([type isEqualToString:@"2"]){
        [formatter setDateFormat:@"HH:mm:ss"];
    }
    else if([type isEqualToString:@"3"]){
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }else if ([type isEqualToString:@"4"]){
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else if ([type isEqualToString:@"5"]){
        [formatter setDateFormat:@"yyyy年MM月dd日"];
    }
    
    NSString *regStr = [formatter stringFromDate:dt];
    return regStr;
}
+ (NSString *)formatDateToString:(NSDate *)date{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy年MM月dd日HH:mm"];
    
    NSString *timerStr = [formater stringFromDate:date];
    
    return timerStr;
}

//格式化时间戳格式的时间
+ (NSString *)formatTimeStr:(NSString *)timeStr
{
//    timeStr = [NSString stringWithFormat:@"%zd",[timeStr integerValue]/1000];

    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]/1000];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate * date1 = [formatter dateFromString:[formatter stringFromDate:dt]];
    
    NSDate * date2 = [NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setTimeZone:timeZone];
    NSUInteger unitFlags =  NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:date1
                                                  toDate:date2 options:0];
    
    NSInteger days = [components day];
    NSInteger hours = [components hour];
    NSInteger minute = [components minute];
    if (days==0) {
        if (hours == 0) {
            return [NSString stringWithFormat:@"%d分钟前",(int)minute];
        }
        else{
            return [NSString stringWithFormat:@"%d小时前",(int)hours];
        }
        
    }
    else{
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *d = [cal components:unitFlags fromDate:date1];
        return [NSString stringWithFormat:@"%d月%d日",(int)[d month],(int)[d day]];
    }
}
+ (NSString *)formartTime:(NSString *)timeStr
{
//    timeStr = [NSString stringWithFormat:@"%zd",[timeStr integerValue]/1000];

    
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]/1000];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate * date1 = [formatter dateFromString:[formatter stringFromDate:dt]];
    
    NSDate * date2 = [NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setTimeZone:timeZone];
    NSUInteger unitFlags =  NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:date1
                                                  toDate:date2 options:0];
    
    NSInteger days = [components day];
    NSInteger hours = [components hour];
    NSInteger minute = [components minute];
    if (days==0) {
        if (hours == 0) {
            return [NSString stringWithFormat:@"%d分钟前",(int)minute];
        }
        else{
            return [NSString stringWithFormat:@"%d小时前",(int)hours];
        }
        
    }
    else{
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *d = [cal components:unitFlags fromDate:date1];
        
        //        NSLog(@"222222    %@",[NSString stringWithFormat:@"%d月%d日 %d:%d",(int)[d month],(int)[d day],(int)[d hour],(int)[d minute]]);
        
        if ([d minute]<10) {
            NSString *minute = [NSString stringWithFormat:@"0%d",(int)[d minute]];
            return [NSString stringWithFormat:@"%d月%d日 %d:%@",(int)[d month],(int)[d day],(int)[d hour],minute];
        }
        else{
            return [NSString stringWithFormat:@"%d月%d日 %d:%d",(int)[d month],(int)[d day],(int)[d hour],(int)[d minute]];
        }
        
        
    }
}

//格式（yyyy年MM月dd日HH:mm） 分割yyyy,MM,dd,HH,mm存入数组
+ (NSMutableArray *)getTimeNumberArray:(NSString *)timeStr{
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *lastArr = [timeStr componentsSeparatedByString:@"年"];
    

    NSString *year = lastArr[0] ;
    lastArr = [lastArr[1] componentsSeparatedByString:@"月"];
    NSString *month = lastArr[0];
    lastArr = [lastArr[1] componentsSeparatedByString:@"日"];
    NSString *day = lastArr[0];
    lastArr = [lastArr[1] componentsSeparatedByString:@":"];
    NSString *hour = lastArr[0];
    NSString *minute = lastArr[1];
    
    [array addObject:year];
    [array addObject:month];
    [array addObject:day];
    [array addObject:hour];
    [array addObject:minute];
    
    return array;
}


/**
 *  时间字符串比较 格式（yyyy年MM月dd日HH:mm）
 *
 *  @param lastStr    上一个时间串
 *  @param currentStr 当前字符串
 *
 *  @return 0表示时间一样，-1表示小于上一个时间，1表示大于上一个时间
 */
+ (NSInteger)compareTimeStrWithStr:(NSString *)lastStr andStr:(NSString *)currentStr{
    
    NSInteger value;
    
    NSMutableArray *lastArr = [self getTimeNumberArray:lastStr];
    NSMutableArray *currentArr = [self getTimeNumberArray:currentStr];
    NSInteger year_r = [currentArr[0] integerValue] - [lastArr[0] integerValue];
    NSInteger month_r = [currentArr[1] integerValue] - [lastArr[1] integerValue];
    NSInteger day_r = [currentArr[2] integerValue] - [lastArr[2] integerValue];
    NSInteger hour_r = [currentArr[3] integerValue] - [lastArr[3] integerValue];
    NSInteger minute_r = [currentArr[4] integerValue] - [lastArr[4] integerValue];
    
    if (year_r < 0) {
        value = -1;
    }
    else if (year_r > 0){
        value = 1;
    }
    else{
        if (month_r < 0) {
            value = -1;
        }
        else if (month_r > 0){
            value = 1;
        }else{
            if (day_r < 0) {
                value = -1;
            }else if (day_r > 0){
                value = 1;
            }else{
                if (hour_r < 0) {
                    value = -1;
                }else if (hour_r > 0){
                    value = 1;
                }else{
                    if (minute_r < 0) {
                        value = -1;
                    }else if (minute_r > 0){
                        value = 1;
                    }else{
                        value = 0;
                    }
                }
            }
        }
    }
    
    return value;
}
/**
 *  和系统时间的比较大小
 *
 *  @param NSInteger
 *
 *  @return 0,1正确选择（选择时间必须大于等于当前时间），-1错误
 */

+ (NSInteger)compareTimeStrWithSystemTime:(NSString *)timeStr{
    NSInteger value;
    
    NSString *currentTimeStr = [self formatDateToString:[NSDate date]];
    
    NSMutableArray *systemArr = [self getTimeNumberArray:currentTimeStr];
    NSMutableArray *selArr = [self getTimeNumberArray:timeStr];
    NSLog(@"%@\n%@",systemArr,selArr);
    NSInteger year_r = [selArr[0] integerValue] - [systemArr[0] integerValue];
    NSInteger month_r = [selArr[1] integerValue] - [systemArr[1] integerValue];
    NSInteger day_r = [selArr[2] integerValue] - [systemArr[2] integerValue];
    NSInteger hour_r = [selArr[3] integerValue] - [systemArr[3] integerValue];
    NSInteger minute_r = [selArr[4] integerValue] - [systemArr[4] integerValue];
    
    if (year_r < 0) {
        value = -1;
    }
    else if (year_r > 0){
        value = 1;
    }
    else{
        if (month_r < 0) {
            value = -1;
        }
        else if (month_r > 0){
            value = 1;
        }else{
            if (day_r < 0) {
                value = -1;
            }else if (day_r > 0){
                value = 1;
            }else{
                if (hour_r < 0) {
                    value = -1;
                }else if (hour_r > 0){
                    value = 1;
                }else{
                    if (minute_r < 0) {
                        value = -1;
                    }else if (minute_r > 0){
                        value = 1;
                    }else{
                        value = 0;
                    }
                }
            }
        }
    }
    
    
    return value;
}
@end
