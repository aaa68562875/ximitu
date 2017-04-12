//
//  GifLoading.h
//  XingSiluSend
//
//  Created by zlc on 15/10/27.
//  Copyright © 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GifLoading : UIView

+ (void)showLoadingForView:(UIView *)view;
+ (void)showLoadingForView:(UIView *)view allowUserInteraction:(BOOL)allowUserInteraction;

+ (void)showGrayLoadingForView:(UIView *)view;
+ (void)showGrayLoadingForView:(UIView *)view allowUserInteraction:(BOOL)allowUserInteraction;

+ (BOOL)hideLoadingForView:(UIView *)view;

@end
