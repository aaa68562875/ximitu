//
//  NSArray+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Common)
/**
 *  返回数组第一个元素
 */
- (id)firstObject;

/**
 *  判断字符串数组是否包含某个字符串
 *  使用isEqualString来判断是否相同
 */
-(BOOL)containsString:(NSString *)string;

- (NSInteger)indexOfString:(NSString *)string;

/**
 *  使用一个block判断array中是否包含某个元素
 *  @param anObject : 要判断的对象
 *  @param compareBlock : 用于比较两个元素的block   此返回bool表示是否包含
 *  @return 返回bool表示是否包含
 */
-(BOOL)containsObject:(id)anObject usingCompareBlock:(BOOL(^)(id,id))compareBlock;

@end
