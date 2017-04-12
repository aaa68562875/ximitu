//
//  NSString+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "NSString+Common.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/stat.h>
#include <dirent.h>
@implementation NSString (Common)
//**** 可以显示的object-->string ****
+(NSString*)stringFromObject:(id)object{
    if ([object isKindOfClass:[NSString class]]) {
        if (![object isEmpty]) {
            return object;
        }
    }
    return @"";
}
//**** 可以打印的字符 ****
-(id)showString{
    if ([self isEmpty]) {
        return @"";
    }
    return self;
}
//**** 判断字符串是否为空 ****
- (BOOL)isEmpty {
    if ((NSNull *)self == [NSNull null]){
        return YES;
    }
    if (self == nil) {
        return YES;
    }
    else if ([self length] == 0) {
        return YES;
    }
    else {
        
        if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
            return YES;
        }
    }
    return NO;
}

//**** UTF8编码 ****
-(id)toUTF8String{

    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//**** 替换字符 ****
-(NSString*)replace:(NSString*)aReplace
                 to:(NSString*)aTo{
    NSMutableString *aMutableString = [NSMutableString stringWithString:self];
    [aMutableString replaceOccurrencesOfString:aReplace
                                    withString:aTo
                                       options:NSLiteralSearch
                                         range:NSMakeRange(0, [aMutableString length])];
    return aMutableString;
}


//**** MD5编码 ****
-(NSString*)MD5{
    if ([self isEmpty]) {
        return nil;
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (int)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

+ (NSString *)fileSizeParseWithLength:(NSUInteger)length {
    NSUInteger nSize = length;
    NSString *string = nil;
    if (nSize<1024)
    {
        string = [NSString stringWithFormat:@"%luB", (unsigned long)nSize];
    }
    else if (nSize<1048576)
    {
        string = [NSString stringWithFormat:@"%luK", (unsigned long)(nSize/1024)];
    }
    else if (nSize<1073741824)
    {
        if ((nSize%1048576)== 0 )
        {
            string = [NSString stringWithFormat:@"%luM", (unsigned long)(nSize/1048576)];
        }
        else
        {
            int decimal = 0; //小数
            NSString* decimalStr = nil;
            decimal = (nSize%1048576);
            decimal /= 1024;
            
            if (decimal < 10)
            {
                decimalStr = [NSString stringWithFormat:@"%d", 0];
            }
            else if (decimal >= 10 && decimal < 100)
            {
                int i = decimal / 10;
                if (i >= 5)
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 1];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 0];
                }
                
            }
            else if (decimal >= 100 && decimal < 1024)
            {
                int i = decimal / 100;
                if (i >= 5)
                {
                    decimal = i + 1;
                    
                    if (decimal >= 10)
                    {
                        decimal = 9;
                    }
                    
                    decimalStr = [NSString stringWithFormat:@"%d", decimal];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", i];
                }
            }
            
            if (decimalStr == nil || [decimalStr isEqualToString:@""])
            {
                string = [NSString stringWithFormat:@"%luMss", (unsigned long)nSize/1048576];
            }
            else
            {
                string = [NSString stringWithFormat:@"%lu.%@M", (unsigned long)nSize/1048576, decimalStr];
            }
        }
    }
    else	// >1G
    {
        string = [NSString stringWithFormat:@"%luG", nSize/1073741824];
    }
    
    return string;
    
}

//**** 过来非法json字符 ****
-(NSString*)filterUnKnowJson{
    if (nil==self
        || [self isEqualToString:@""]
        || [self length]==0) {
        return self;
    }
    NSString *aString = [self stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
    NSRange range = [aString rangeOfCharacterFromSet:controlChars];
    if (range.location != NSNotFound) {
        NSMutableString *mutable = [NSMutableString stringWithString:aString];
        while (range.location != NSNotFound) {
            [mutable deleteCharactersInRange:range];
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return aString;
}
- (id)urlEncoded {
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                             (CFStringRef)self,NULL,
                                                                             (CFStringRef)@"!#$%&'()*+,/:;=?@[]",
                                                                             kCFStringEncodingUTF8);
    
    NSString *urlEncoded = [NSString stringWithString:(__bridge NSString *)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return urlEncoded;
}
- (BOOL)validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)validCarNum{
    NSString *carNumRegex = @"^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$";
    NSPredicate *carNumTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carNumRegex];
    return [carNumTest evaluateWithObject:self];
    
}

-(BOOL)validetePhoneNumber:(BOOL)isMobile{
    NSString *PhoneNumberRegex = @"";
    if (isMobile) {
        //**** 手机 ****
        PhoneNumberRegex = @"^(1(([35][0-9])|(47)|[8][01236789]))\\d{8}$";
    }else{
        //**** 固话 ****
        PhoneNumberRegex = @"^0\\d{2,3}(\\-)?\\d{7,8}$";
    }
    NSPredicate *PhoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PhoneNumberRegex];
    return [PhoneNumberTest evaluateWithObject:self];
}
- (NSString *)mobileNumberSetCiphertext{
    NSString *mobile = self;
    
    [mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    return mobile;
}



//根据文字，字体大小和宽度计算文字高度
- (CGFloat)calculateHeight:(UIFont *)Font :(CGFloat)width {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGRect rect =
        [self boundingRectWithSize:CGSizeMake(width, 100000)
                          options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{
                                    NSFontAttributeName : Font
                                    } context:nil];
        return ceilf(rect.size.height);
    } else {
        CGSize size =
        [self sizeWithFont:Font constrainedToSize:CGSizeMake(width, 10000)];
        return size.height;
    }
}
//计算一行Label宽度
- (CGFloat)calculateWidthWithFont:(UIFont *)myFont {
    
    CGSize size = [self sizeWithAttributes:@{NSFontAttributeName : myFont}];
    
    return size.width;
}

-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    
    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, [self length])];
    return attributedStr;
}
#if 1
//判断字符串是否包含指定字符串
-(BOOL)isContainString:(NSString*)str
{
    return [self isMatchedByRegex:[NSString stringWithFormat:@"%@+",str]];
}

+(NSString*)tokenString:(NSData *)devToken
{
    NSString *token=devToken.description;//[[deviceToken description] stringByReplacingOccurrencesOfString:@"" withString:@""];
    
    token=[token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token=[token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token=[token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return token;
}

//获取某固定文本的显示高度
+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font
{
    return [NSString heightForString:str Size:size Font:font Lines:0];
}

+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font Lines:(NSInteger)lines
{
    if (StringIsNullOrEmpty(str)) {
        return CGRectMake(0, 0, 0, 0);
    }
    static UILabel *lbtext;
    if (lbtext==nil) {
        lbtext    = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    }else{
        lbtext.frame=CGRectMake(0, 0, size.width, size.height);
    }
    lbtext.font=font;
    lbtext.text=str;
    lbtext.numberOfLines=lines;
    CGRect rect= [lbtext textRectForBounds:lbtext.frame limitedToNumberOfLines:lines];
    if(rect.size.height<0)
        rect.size.height=0;
    if (rect.size.width<0) {
        rect.size.width=0;
    }
    return rect;
    
}

//返回字符串经过md5加密后的字符
+(NSString*)stringDecodingByMD5:(NSString*)str
{
    const char * cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

-(NSString*)md5DecodingString
{
    return [NSString stringDecodingByMD5:self];
}


+ (NSString*) base64Decode:(NSString *)string
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[4];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (string == nil) {
        return @"";
    }
    
    ixtext = 0;
    
    tempcstring = (const unsigned char *)[string UTF8String];
    
    lentext = [string length];
    
    theData = [NSMutableData dataWithCapacity: lentext];
    
    ixinbuf = 0;
    
    while (true) {
        if (ixtext >= lentext){
            break;
        }
        
        ch = tempcstring [ixtext++];
        
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        } else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        } else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        } else if (ch == '+') {
            ch = 62;
        } else if (ch == '=') {
            flendtext = true;
        } else if (ch == '/') {
            ch = 63;
        } else {
            flignore = true;
        }
        
        if (!flignore) {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext) {
                if (ixinbuf == 0) {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                } else {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4) {
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++) {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    return [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];// theData;
}

-(NSString*)base64Decode
{
    return [NSString base64Decode:self];
}

+ (NSString*) base64Encode:(NSData *)data
{
    static char base64EncodingTable[64] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
        'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    };
    int length = (int)[data length];
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
            break;
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }
    return result;
}
-(NSString*)base64Encode
{
    return [NSString base64Encode:[self dataUsingEncoding:NSUTF8StringEncoding]];
}


/**
 *  使用des解密
 */
- (NSString*)decryptUseDESWithKey:(NSString*)key {
    // 利用 GTMBase64 解碼 Base64 字串
    NSData* cipherData = [GTMBase64 decodeString:self];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding| kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}
/**
 *  使用des加密
 */
- (NSString *)encryptUseDESWithKey:(NSString *)key
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding| kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [GTMBase64 stringByEncodingData:dataTemp];
    }else{
        NSLog(@"DES加密失败");
    }
    return plainText;
}



// 方法1：使用NSFileManager来实现获取文件大小
+ (long long) fileSizeAtPath1:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

// 方法1：使用unix c函数来实现获取文件大小
+ (long long) fileSizeAtPath2:(NSString*) filePath{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}


#pragma mark 获取目录大小


// 方法1：循环调用fileSizeAtPath1
+ (long long) folderSizeAtPath1:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        if ([self fileSizeAtPath1:fileAbsolutePath] != [self fileSizeAtPath2:fileAbsolutePath]){
            NSLog(@"%@, %lld, %lld", fileAbsolutePath,
                  [self fileSizeAtPath1:fileAbsolutePath],
                  [self fileSizeAtPath2:fileAbsolutePath]);
        }
        folderSize += [self fileSizeAtPath1:fileAbsolutePath];
    }
    return folderSize;
}


// 方法2：循环调用fileSizeAtPath2
+ (long long) folderSizeAtPath2:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath2:fileAbsolutePath];
    }
    return folderSize;
}


// 方法3：完全使用unix c函数
+ (long long) folderSizeAtPath3:(NSString*) folderPath{
    return [self _folderSizeAtPath:[folderPath cStringUsingEncoding:NSUTF8StringEncoding]];
}
+ (long long) _folderSizeAtPath: (const char*)folderPath{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        int folderPathLength = (int)strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += [self _folderSizeAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    return folderSize;
}

- (NSString *)trimString
{
    NSString *newString = nil;
    
    if (StringNotNullAndEmpty(self)) {
        newString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //        newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //        newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    
    if (StringIsNullOrEmpty(newString)) {
        newString = nil;
    }
    
    return newString;
}

- (int)byteCount
{
    int count = 0;
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    const char* cString = [self cStringUsingEncoding:gbkEncoding];
    if (cString) {
        count = (int)strlen(cString);
    }
    return count;
}

- (NSString *)substringWithMaxByteCount:(NSInteger)maxByteCount
{
    NSString *substring = nil;
    
    if ([self byteCount] > maxByteCount) {
        int currentByteCount = 0;
        NSRange subRange;
        NSString *nextWord = nil;
        
        substring = [NSString string];
        while (currentByteCount < maxByteCount) {
            subRange.location = substring.length;
            subRange.length = ((maxByteCount - substring.length) / 2);
            if ((subRange.location + subRange.length) > self.length) {
                subRange.length = (self.length - subRange.location);
            }
            substring = [substring stringByAppendingString:[self substringWithRange:subRange]];
            if ([substring byteCount] > maxByteCount) {
                substring = [substring substringToIndex:(substring.length - 1)];
                subRange.length -= 1;
            }
            currentByteCount = [substring byteCount];
            nextWord = [self substringWithRange:NSMakeRange((subRange.location + subRange.length), 1)];
            if ((currentByteCount + [nextWord byteCount]) > maxByteCount) {
                break;
            }
        }
        
        if (StringIsNullOrEmpty(substring)) {
            substring = nil;
        }
    } else {
        substring = [NSString stringWithString:self];
    }
    
    return substring;
}
#endif
@end


@implementation NSMutableString (Extension)

-(void)appendLine:(NSString *)string
{
    [self appendFormat:@"%@\n",string];
}

@end

@implementation NSString (Validate)

-(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

@end

NSString * const NSStringRegexIsEmail = @"(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w+)+)$";
NSString * const NSStringRegexIsPhoneNumber = @"^((13)|(15)|(17)|(14)|(18))\\d{9}$";
