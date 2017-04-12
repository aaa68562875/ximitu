//
//  NSURL+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Common)

/**
 获取paramString对应生成的url中的附加参数
 */
- (NSDictionary*)paramDictionary;

/**
 返回URL中指定参数的值
 */
- (NSString*)valueForParam:(NSString*)param;

@end
