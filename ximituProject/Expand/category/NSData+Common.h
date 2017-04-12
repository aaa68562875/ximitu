//
//  NSData+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Common)
/*
 缓存的存放路径
 默认位于
 /Library/Caches/DataCache/
 */
+(NSString*)cacheDirectory;

/*
 读取来自某个url的数据，并且缓存此内容，下次读取时，如果已经存在，会使用缓存
 */
+(id)dataWithContentsOfURL:(NSURL *)url userCache:(BOOL)cache;
@end
