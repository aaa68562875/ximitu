//
//  NSMutableArray+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Common)

- (void)addSafeObject:(id)obj;

/**
 *  是否包含obj这个元素
 */
- (BOOL)isObjectInArray:(NSString *)obj;
//获取obj的位置
- (int)objectAtIndext:(NSString *)obj;
/**
 *  删除数组中obj这个元素
 */
- (void)deleteObject:(NSString *)obj;
/**
 *  删除数组中的重复元素
 */
- (void)deleteRepeatObject;
/**
 *  判断所有元素都为零
 */
- (BOOL)isALLObjectZero;
@end
