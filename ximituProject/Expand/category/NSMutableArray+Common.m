//
//  NSMutableArray+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "NSMutableArray+Common.h"

@implementation NSMutableArray (Common)

- (void)addSafeObject:(id)obj{
    if ([obj isEqual:[NSNull null]] || obj ==nil) {
        return;
    }
    [self addObject:obj];
}
/**
 *  是否包含obj这个元素
 */
- (BOOL)isObjectInArray:(NSString *)obj{
    
    for (int i = 0 ; i<self.count; i++) {
        if ([obj isEqualToString:self[i]]) {
            return YES;
        }
    }
    
    return NO;
}
//获取obj的位置
- (int)objectAtIndext:(NSString *)obj{
    int index = 0;
    for (int i = 0 ; i<self.count; i++) {
        if ([obj isEqualToString:self[i]]) {
            index = i;
        }
    }
    return index;
}
/**
 *  删除数组中obj这个元素
 */
- (void)deleteObject:(NSString *)obj{

    if ([self isObjectInArray:obj]) {
        int index = [self objectAtIndext:obj]; //找到位置
        [self removeObjectAtIndex:index];
    }
}
/**
 *  删除数组中的重复元素
 */
- (void)deleteRepeatObject{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *object = @"";
    for (int i = 0; i<self.count; i++) {
        object = [NSString stringWithFormat:@"%@",self[i]];
        [dict setObject:object forKey:object];
    }
    [self removeAllObjects];
    for (id obj in dict.allValues) {
        object = [NSString stringWithFormat:@"%@",obj];
        [self addObject:object];
    }
}

- (BOOL)isALLObjectZero{
    NSInteger count = 0;
    for (id obj in self) {
        if ([obj isEqualToString:@"0"]) {
            count++;
        }
    }
    if (count == self.count) {
        return YES;
    }
    return NO;
}

@end
