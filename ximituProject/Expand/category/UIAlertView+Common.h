//
//  UIAlertView+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Common)
/**
 * 设置标题(确定)
 */
+(void)showTip:(NSString*)aTipStr;

/**
 * 设置标题,事件(确定)
 */
+(void)showTip:(NSString*)aTipStr delegate:(id)aDelegate tag:(NSInteger)aTag;

/**
 * 设置询问事件
 */
+(void)showAskTip:(NSString*)aTipStr delegate:(id)aDelegate tag:(NSInteger)aTag;
@end
