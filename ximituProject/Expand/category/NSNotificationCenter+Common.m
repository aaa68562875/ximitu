//
//  NSNotificationCenter+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "NSNotificationCenter+Common.h"

@implementation NSNotificationCenter (Common)

-(void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo onMainThread:(BOOL)onMainThread
{
    if(onMainThread){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self postNotificationName:aName object:anObject userInfo:aUserInfo];
        });
    }else{
        [self postNotificationName:aName object:anObject userInfo:aUserInfo];
    }
}

-(void)postNotificationName:(NSString *)aName object:(id)anObject onMainThread:(BOOL)onMainThread

{
    [self postNotificationName:aName object:anObject userInfo:nil onMainThread:onMainThread];
}

@end
