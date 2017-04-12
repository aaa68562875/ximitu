//
//  UINavigationItem+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (Common)

/**
 * 自定义标题
 */
- (void)setTitle:(NSString*)aTitle
          color:(UIColor*)aColor
           font:(CGFloat)aFont;

/**
 * 自定义左边按钮 @2x高清图
 */
- (void)setLeftBarItem:(id)aTarget
               action:(SEL)aAction
                image:(NSString*)aImage
           focusImage:(NSString*)aFocusImage;

/**
 * 自定义右边按钮 @2x高清图
 */
- (void)setRightBarItem:(id)aTarget
                action:(SEL)aAction
                 image:(NSString*)aImage
            focusImage:(NSString*)aFocusImage;


@end
