//
//  UINavigationController+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "UINavigationController+Common.h"

@implementation UINavigationController (Common)

/*transition.type = @"reveal";//moveIn(落下)cube(翻转)reveal(下拉)*/

#pragma mark - Push特效
//Push从右反转
- (void)CustomPushViewControllerCubeFromRight:(UIViewController *)viewController
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self pushViewController:viewController animated:NO];
}
//Push从左反转
- (void)CustomPushViewControllerCubeFromLeft:(UIViewController *)viewController
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromLeft;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self pushViewController:viewController animated:NO];
}
//Push从上移进
- (void)CustomPushViewControllerMoveinFromTop:(UIViewController *)viewController{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"moveIn";
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self pushViewController:viewController animated:NO];
}
//Push从下移进
- (void)CustomPushViewControllerMoveinFromBottom:(UIViewController *)viewController{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"moveIn";
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self pushViewController:viewController animated:NO];
}

#pragma mark - Pop特效
//Pop从右反转
- (void)CustomPopViewControllerCubeFromRight{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self popViewControllerAnimated:NO];
}
//Pop从左反转
- (void)CustomPopViewControllerCubeFromLeft{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromLeft;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self popViewControllerAnimated:NO];
}
//Pop从上移进
- (void)CustomPopViewControllerMoveinFromTop{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"moveIn";
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self popViewControllerAnimated:NO];
}
//Pop从下移进
- (void)CustomPopViewControllerMoveinFromBottom{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"moveIn";
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self popViewControllerAnimated:NO];
}


@end
