//
//  NSObject+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "NSObject+Common.h"
#import <objc/runtime.h>
NSString * const kAssociatedObjectKey=@"associatedobjectkey-234242";
NSString * const kAssociatedObjectRetainKey=@"associatedobjectretainkey-235424";

@implementation NSObject (Common)

- (BOOL)isString
{
    if ([self isKindOfClass:[NSString class]]) {
        return YES;
    }
    else{
        return NO;
    }
}

- (BOOL)isArray
{
    if ([self isKindOfClass:[NSArray class]]) {
        return YES;
    }
    else{
        return NO;
    }
}

- (BOOL)isDictionary
{
    if ([self isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    else{
        return NO;
    }
}

- (BOOL)isNull
{
    if (self==nil || [self isEqual:[NSNull null]]||[((NSString *)self) isEqualToString:@"<null>"]) {
        return YES;
    }
    else{
        return NO;
    }
}

/**
 获取关联的一个参数对象
 此对象会被 retain一次，
 此对象会在dealloc的时候释放，所以请注意不要发生retinCycle
 */
- (void)setAssociatedObjectRetain:(id)object
{
    objc_setAssociatedObject(self, (__bridge const void *)(kAssociatedObjectRetainKey), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)associatedObjectRetain
{
    return objc_getAssociatedObject(self, (__bridge const void *)(kAssociatedObjectRetainKey));
}

/**
 获取关联的一个参数对象
 此对象不会被 retain，只是一个弱引用
 */
- (void)setAssociatedObject:(id)object
{
    objc_setAssociatedObject(self, (__bridge const void *)(kAssociatedObjectKey), object, OBJC_ASSOCIATION_ASSIGN);
}
- (id)associatedObject
{
    return objc_getAssociatedObject(self, (__bridge const void *)(kAssociatedObjectKey));
}

@end
