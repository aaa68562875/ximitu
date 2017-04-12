//
//  NSData+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "NSData+Common.h"
#import "NSString+Common.h"
@implementation NSData (Common)
static NSString *cacheDirectoryString=nil;
+(NSString*)cacheDirectory
{
    if (cacheDirectoryString==nil) {
        cacheDirectoryString=[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),@"/Library/Caches/DataCache/"];
        BOOL isDirectory=NO;
        if (![[NSFileManager defaultManager] fileExistsAtPath:cacheDirectoryString]||!isDirectory) {
            [[NSFileManager defaultManager] createDirectoryAtPath:cacheDirectoryString withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return cacheDirectoryString;
}

+(id)dataWithContentsOfURL:(NSURL *)url userCache:(BOOL)cache
{
    NSData *data=nil;
    
    NSString *cachefilename=[NSString stringWithFormat:@"%@%@",[NSData cacheDirectory],[url.absoluteString md5DecodingString]];
    //如果使用缓存，从缓存读取
    if (cache) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:cachefilename]) {
            data=[NSData dataWithContentsOfFile:cachefilename];
        }else{
            data=[NSData dataWithContentsOfURL:url];
            
            //缓存此内容
            if (data!=nil) {
                [data writeToFile:cachefilename atomically:YES];
            }
        }
    }
    
    //如果缓存没有取出来,返回从网上取到的内容
    if (data==nil) {
        data=[NSData dataWithContentsOfURL:url];
    }
    return data;
}

@end
