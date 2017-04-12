//
//  UINavigationController+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

/**
 *  自定义push/pop动画，随便玩玩
 */
#import <UIKit/UIKit.h>

@interface UINavigationController (Common)
#pragma mark - Push特效
//Push从右反转
- (void)CustomPushViewControllerCubeFromRight:(UIViewController *)viewController;
//Push从左反转
- (void)CustomPushViewControllerCubeFromLeft:(UIViewController *)viewController;
//Push从上移进
- (void)CustomPushViewControllerMoveinFromTop:(UIViewController *)viewController;
//Push从下移进
- (void)CustomPushViewControllerMoveinFromBottom:(UIViewController *)viewController;

#pragma mark - Pop特效
//Pop从右反转
- (void)CustomPopViewControllerCubeFromRight;
//Pop从左反转
- (void)CustomPopViewControllerCubeFromLeft;
//Pop从上移进
- (void)CustomPopViewControllerMoveinFromTop;
//Pop从下移进
- (void)CustomPopViewControllerMoveinFromBottom;
@end
