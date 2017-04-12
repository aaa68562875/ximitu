//
//  UIColor+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLOR_16(NSString) [[UIColor alloc] colorWithHexString:NSString]

@interface UIColor (Common)

/**
 *将16进制颜色转换成UIColor
 */
- (UIColor *) colorWithHexString: (NSString *)color;


@end
