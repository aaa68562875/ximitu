//
//  FTTimeUtil.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTTimeUtil : NSObject
//将时间戳转化成时间
+ (NSString *)formatDateByTimeInterval:(NSString *)timeInterval;

//将时间转换成时间戳
+ (NSString *)formatTimeIntervalByDateString:(NSString *)dateString;

+ (NSString *)formatTimeStr:(NSString *)timeStr;
//格式化时间戳格式的时间
+ (NSString *)formartTime:(NSString *)timeStr;
+ (NSString *)formatTimeStr1:(NSString *)timeStr andType:(NSString *)type;
//
+ (NSString *)formatDateToString:(NSDate *)date;


//_______________________________________________//
//格式（yyyy年MM月dd日HH:mm） 分割yyyy,MM,dd,HH,mm存入数组
+ (NSMutableArray *)getTimeNumberArray:(NSString *)timeStr;
//时间字符串比较 格式（yyyy年MM月dd日HH:mm）
+ (NSInteger)compareTimeStrWithStr:(NSString *)lastStr andStr:(NSString *)currentStr;
//和系统时间的比较
+ (NSInteger)compareTimeStrWithSystemTime:(NSString *)timeStr;
//_______________________________________________//

@end
