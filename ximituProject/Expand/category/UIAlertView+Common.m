//
//  UIAlertView+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "UIAlertView+Common.h"

@implementation UIAlertView (Common)
/**
 * 设置标题(确定)
 */
+ (void)showTip:(NSString*)aTipStr{
    UIAlertView *aAlert = [[UIAlertView alloc] initWithTitle:nil
                                                     message:aTipStr
                                                    delegate:nil
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil];
    [aAlert show];
}

/**
 * 设置标题,事件(确定)
 */
+ (void)showTip:(NSString*)aTipStr delegate:(id)aDelegate tag:(NSInteger)aTag{
    UIAlertView *aAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                     message:aTipStr
                                                    delegate:aDelegate
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil];
    aAlert.tag = aTag;
    [aAlert show];
}

/**
 * 设置询问事件
 */
+ (void)showAskTip:(NSString*)aTipStr delegate:(id)aDelegate tag:(NSInteger)aTag{
    UIAlertView *aAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                     message:aTipStr
                                                    delegate:aDelegate
                                           cancelButtonTitle:@"否"
                                           otherButtonTitles:@"是",
                           nil];
    aAlert.tag = aTag;
    [aAlert show];
}
@end
