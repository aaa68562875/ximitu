//
//  NSCache+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCache (Common)

@end



///收到此通知后所有的cache对象会清空cache
UIKIT_EXTERN NSString * const NSCacheCenterClearAllCacheNotification;

///缓存 中心默认缓存元素的大小
UIKIT_EXTERN int const NSCacheCenterDefaultMaxCacheCount;
/**
 提供一个NSCache对象管理中心
 指定key后可以获取到一个NSCache对象，该对象会自己创建
 同时CacheCenter会自己托管内存
 收到MemeryWarning后会自己清空cache
 线程安全，可以多线程访问
 */
@interface NSCacheCenter : NSObject

/**
 默认的缓存管理中心
 */
+(NSCacheCenter*)defaultCacheCenter;

/**
 获取指定的key的缓存对象
 
 如果此对象不存在，将会创建此对象
 @param key : 要获取的key
 */
-(NSCache*)cacheForKey:(id)key;

/**
 设置指定key的缓存对象
 
 如果对象已存在，将会覆盖对象
 @param key : 要设置的key
 */
-(void)setCache:(NSCache*)cache forKey:(id)key;
@end
