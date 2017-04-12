//
//  NSDate+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Common)
/**
 将指定字符串格式化成时间
 @param dateString : 要格式的字符串
 @return 返回格式化后的时间
 */
+(NSDate *)dateWithString:(NSString*)dateString;

/**
 将指定字符串格式化为时间
 @param dateString : 要格式化的字符串
 @param format : 时间的格式
 @return 返回格式化后的时间
 */
+(NSDate*)dateWithString:(NSString *)dateString Format:(NSString*)format;

/**
 将当前对象格式化为字符串形式
 yyyy-mm-dd hh:MM:ss
 */
-(NSString *)stringDate;

/**
 将当前对象格式化为字符串形式
 @param formatString : 用来表示时间格式的字符串
 */
-(NSString*)stringDateWithFormat:(NSString*)formatString;

/**
 将当前对象格式化为字符串形式
 @param formatString : 用来表示时间格式的字符串
 */
-(NSString*)stringDateWithFormat:(NSString*)formatString Local:(NSString*)local;

//时间戳格式的字符串
-(NSString *)dateDiff;

/**
 返回当前时间所代表的年、月、日、时、分、秒
 */
-(int)year;
-(int)month;
-(int)day;
-(int)hour;
-(int)minute;
-(int)seconds;
@end

/*********************************************************************/

@interface DFDateFormatterFactory : NSObject {
    
    NSCache *loadedDataFormatters;
    
}

+ (DFDateFormatterFactory *)sharedFactory;
- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andLocale:(NSLocale *)locale;
- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andLocaleIdentifier:(NSString *)localeIdentifier;

@end
