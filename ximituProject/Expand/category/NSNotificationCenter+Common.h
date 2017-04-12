//
//  NSNotificationCenter+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Common)
/**
 发送一个通知
 @param aName : 同postNotificationName:object:userInfo中的aName
 @param anObject : 同postNotificationName:object:userInfo中的anObject
 @param aUserInfo : 同postNotificationName:object:userInfo中的aUserInfo
 @param onMainThread : 是否在主线程上进行此操作，如果此值为YES，会在主线程上进行此发送操作
 */
-(void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo onMainThread:(BOOL)onMainThread;

/**
 发送一个通知
 @param aName : 同postNotificationName:object:userInfo中的aName
 @param anObject : 同postNotificationName:object:userInfo中的anObject
 @param onMainThread : 是否在主线程上进行此操作，如果此值为YES，会在主线程上进行此发送操作
 */
-(void)postNotificationName:(NSString *)aName object:(id)anObject onMainThread:(BOOL)onMainThread;
@end
