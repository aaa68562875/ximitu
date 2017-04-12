//
//  UIView+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

/**
 * 设置背景,图片名称,直接从资源文件加载
 */
- (void)setBackgroundImage:(NSString*)aImageStr;


/**
 * 移除某个子视图
 */
-(BOOL)removeSubview:(NSInteger)aTag;
/**
 * 移除所有子视图
 */
- (BOOL)removeAllSubViews;
/**
 * 初始化一个视图,按照中心点
 */
- (id)initWithCenterX:(CGFloat)x
              centerY:(CGFloat)y
                width:(CGFloat)w
               height:(CGFloat)w;

/********************************************
 *
 *@fuction frame center
 *
 */

/**
 * frame.origin.x
 */
- (CGFloat)left;
- (void)setLeft:(CGFloat)x;


/**
 * frame.origin.y
 */
- (CGFloat)top;
- (void)setTop:(CGFloat)y;


/**
 * frame.origin.x + frame.size.width
 */
- (CGFloat)right;
/**
 * 调整frame.origin.x(width不变)
 */
- (void)setRight:(CGFloat)right;


/**
 * frame.origin.y + frame.size.height
 */
- (CGFloat)bottom;
/**
 * 调整frame.origin.y(height不变)
 */
- (void)setBottom:(CGFloat)bottom;



/**
 * frame.size.width
 */
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

/**
 * frame.size.height
 */
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

/**
 *
 */
- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;

/**
 * frame.size
 */
- (CGSize)size;
- (void)setSize:(CGSize)size;


/**
 * center.x
 */
- (CGFloat)centerX;
- (void)setCenterX:(CGFloat)centerX;

/**
 * center.y
 */
- (CGFloat)centerY;
- (void)setCenterY:(CGFloat)centerY;


- (void)setShadowColor:(UIColor *)color
                offset:(CGSize)offset
               opacity:(CGFloat)opacity;

- (void)setBorderColor:(UIColor *)color
                 width:(CGFloat)width;

- (void)setCornerRadius:(CGFloat)cornerRadius andBorderColor:(UIColor *)borderColor andBorderWidth:(CGFloat)borderWidth;

@end
