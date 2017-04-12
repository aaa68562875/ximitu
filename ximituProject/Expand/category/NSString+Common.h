//
//  NSString+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"
#import "GTMBase64.h"
#include <CommonCrypto/CommonCryptor.h>
/**
 *  货币精度处理
 *
 *  @return
 */
UIKIT_STATIC_INLINE NSString *decimalNumberMutiplyWithString(NSString *multiplierValue,NSString *multiplicandValue)
{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *product = [multiplicandNumber decimalNumberByMultiplyingBy:multiplierNumber];
    return [product stringValue];
}
#define FloatAccuracy(a,b) decimalNumberMutiplyWithString([NSString stringWithFormat:@"%f",a], [NSString stringWithFormat:@"%zd",b])
//获取一个字符串转换为URL
#define URL(str) [NSURL URLWithString:str]

/**
 判断字符串为空或者为空字符串
 @param str : 要判断的字符串
 @return 返回BOOL表示结果
 */
UIKIT_STATIC_INLINE BOOL StringIsNullOrEmpty(NSString* str)
{
    return (str==nil||[str isEqualToString:@""]);
}
/**
 判断字符串不为空并且不为空字符串
 @param str : 要判断的字符串
 @return 返回BOOL表示结果
 */
UIKIT_STATIC_INLINE BOOL StringNotNullAndEmpty(NSString* str)
{
    return (str!=nil&&![str isEqualToString:@""]);
}

///返回一个占位字符，用于做Placeholder显示
UIKIT_STATIC_INLINE NSString * StringPlaceholderForString(NSString* placeholder,NSString* string)
{
    return StringNotNullAndEmpty(string)?string:placeholder;
}
///用于判断字符串非空的结尾参数
UIKIT_EXTERN NSString * const kStringsNotNullAndEmptyEnd;
/**
 判断一级字符串不为空并且不为空字符串
 必需在字符串的最后一个放置kStringsNotNullAndEmptyEnd
 @param str1 : 要判断的字符串
 @return 返回BOOL表示结果
 */
UIKIT_STATIC_INLINE BOOL StringsNotNullAndEmpty(NSString * str1,...)
{
    if (StringIsNullOrEmpty(str1)) {
        return NO;
    }
    BOOL result=YES;
    va_list argptr;
    va_start(argptr, str1);
    str1=va_arg(argptr, id);
    while (str1!=kStringsNotNullAndEmptyEnd) {
        str1=va_arg(argptr, id);
        if (StringIsNullOrEmpty(str1)) {
            result=NO;
            break;
        }
    }
    va_end(argptr);
    return result;
}
//快速格式化一个字符串
#define _S(str,...) [NSString stringWithFormat:str,##__VA_ARGS__]

/******************************************************************************************/

@interface NSString (Common)


//**** 可以显示的object-->string ****
+ (NSString*)stringFromObject:(id)object;
- (id)showString;
- (BOOL)isEmpty;
/*
 转化为UTF8字符
 */
- (id)toUTF8String;
- (NSString*)replace:(NSString*)aReplace
                  to:(NSString*)aTo;

- (NSString*)MD5;
- (NSString*)filterUnKnowJson;
/**
 * url编码
 */
- (id)urlEncoded;

/**
 * 邮箱合法
 */
- (BOOL)validateEmail;
/**
 *  车牌号合法
 */
- (BOOL)validCarNum;

/**
 * 电话号码合法
 */
- (BOOL)validetePhoneNumber:(BOOL)isMobile;
/**
 *  手机号码设置中间密文显示
 */
- (NSString *)mobileNumberSetCiphertext;

+ (NSString *)fileSizeParseWithLength:(NSUInteger)length;

//根据文字，字体大小和宽度计算文字高度
- (CGFloat)calculateHeight:(UIFont *)Font :(CGFloat)width;
//计算一行Label宽度
- (CGFloat)calculateWidthWithFont:(UIFont *)myFont;
/**
 *NSString->NSMutableAttributedString转换，用于计算行间距
 */
-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing;
//判断字符串是否包含指定字符串
-(BOOL)isContainString:(NSString*)str;


//获取某固定文本的显示高度
+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font;

+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font Lines:(NSInteger)lines;

//返回取到的token的字符串格式
+(NSString*)tokenString:(NSData*)devToken;


//返回字符串经过md5加密后的字符
+(NSString*)stringDecodingByMD5:(NSString*)str;

-(NSString*)md5DecodingString;

//返回经base64编码过后的数据
+ (NSString*)base64Encode:(NSData *)data;
-(NSString*)base64Encode;

//返回经base64解码过后的数据
+ (NSString*) base64Decode:(NSString *)string;
-(NSString*)base64Decode;

/**
 *  使用des解密
 */
- (NSString*)decryptUseDESWithKey:(NSString*)key;
/**
 *  使用des加密
 */
- (NSString *)encryptUseDESWithKey:(NSString *)key;



// 方法1：使用NSFileManager来实现获取文件大小
+ (long long) fileSizeAtPath1:(NSString*) filePath;
// 方法1：使用unix c函数来实现获取文件大小
+ (long long) fileSizeAtPath2:(NSString*) filePath;


// 方法1：循环调用fileSizeAtPath1
+ (long long) folderSizeAtPath1:(NSString*) folderPath;
// 方法2：循环调用fileSizeAtPath2
+ (long long) folderSizeAtPath2:(NSString*) folderPath;
// 方法2：在folderSizeAtPath2基础之上，去除文件路径相关的字符串拼接工作
+ (long long) folderSizeAtPath3:(NSString*) folderPath;

/// 去除字符串中收尾空格和换行
- (NSString *)trimString;

/// 计算字符串字节数，英文为1，中文为2
- (int)byteCount;

/// 根据最大字节数截取字符串
- (NSString *)substringWithMaxByteCount:(NSInteger)maxByteCount;
@end

/*******************************************************************************/
@interface NSString (Validate)
-(BOOL)isChinese;
@end

@interface NSMutableString (Extension)

/**
 以指定格式向当前字符串追加一行
 @param string : 要追加的字符串
 */
-(void)appendLine:(NSString *)string;

@end

#pragma mark -
#pragma mark -regexs 以下部分提供一些常用的正则表达式
/**
 用于判断某个字符串是否为有效的邮箱地址的正则表达式
 @"(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w+)+)$"
 */
UIKIT_EXTERN NSString * const NSStringRegexIsEmail;

/**
 用于判断某个字符串是否为手机号（以1打头的11位数字）
 @"^1\d{10}$"
 */
UIKIT_EXTERN NSString * const NSStringRegexIsPhoneNumber;
