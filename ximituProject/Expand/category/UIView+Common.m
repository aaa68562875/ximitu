//
//  UIView+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)
- (void)setBackgroundImage:(NSString *)aImageStr {
  NSString *path = [[NSBundle mainBundle] pathForResource:aImageStr ofType:nil];
  UIImage *smallImage = [[UIImage alloc] initWithContentsOfFile:path];
  self.backgroundColor = [UIColor colorWithPatternImage:smallImage];
}

- (BOOL)removeSubview:(NSInteger)aTag {
  if (nil != [self viewWithTag:aTag] &&
      [[self viewWithTag:aTag] isKindOfClass:[UIView class]]) {
    [[self viewWithTag:aTag] removeFromSuperview];
    return YES;
  }
  return NO;
}

- (BOOL)removeAllSubViews {
  for (int i = 0; i < self.subviews.count; i++) {
    UIView *subView = [self.subviews objectAtIndex:i];
    [subView removeFromSuperview];
  }
  if (self.subviews.count == 0) {
    return YES;
  } else {
    return NO;
  }
}

- (id)initWithCenterX:(CGFloat)x
              centerY:(CGFloat)y
                width:(CGFloat)w
               height:(CGFloat)h {
  self = [super init];
  if (self) {
    self.bounds = CGRectMake(0, 0, w, h);
    self.center = CGPointMake(x, y);
  }
  return self;
}

#pragma mark -
#pragma mark 属性
- (CGFloat)left {
  return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
  CGRect frame = self.frame;
  frame.origin.x = x;
  self.frame = frame;
}

- (CGFloat)top {
  return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
  CGRect frame = self.frame;
  frame.origin.y = y;
  self.frame = frame;
}

- (CGFloat)right {
  return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
  CGRect frame = self.frame;
  frame.origin.x = right - frame.size.width;
  self.frame = frame;
}

- (CGFloat)bottom {
  return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
  CGRect frame = self.frame;
  frame.origin.y = bottom - frame.size.height;
  self.frame = frame;
}

- (CGFloat)width {
  return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
  CGRect frame = self.frame;
  frame.size.width = width;
  self.frame = frame;
}

- (CGFloat)height {
  return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
  CGRect frame = self.frame;
  frame.size.height = height;
  self.frame = frame;
}

- (CGPoint)origin {
  return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
  CGRect frame = self.frame;
  frame.origin = origin;
  self.frame = frame;
}

- (CGSize)size {
  return self.frame.size;
}

- (void)setSize:(CGSize)size {
  CGRect frame = self.frame;
  frame.size = size;
  self.frame = frame;
}

- (CGFloat)centerX {
  return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
  self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
  return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
  self.center = CGPointMake(self.center.x, centerY);
}

- (void)setShadowColor:(UIColor *)color
                offset:(CGSize)offset
               opacity:(CGFloat)opacity {
  self.layer.shadowColor = color.CGColor;
  self.layer.shadowOffset = offset;
  self.layer.shadowOpacity = opacity;
}

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width {
  self.layer.borderColor = color.CGColor;
  self.layer.borderWidth = width;
}
/**
 *  设置边框
 *
 *  @param cornerRadius 角弧
 *  @param borderColor  边框色
 *  @param borderWidth  边框宽度
 */
- (void)setCornerRadius:(CGFloat)cornerRadius
         andBorderColor:(UIColor *)borderColor
         andBorderWidth:(CGFloat)borderWidth {
  self.layer.masksToBounds = YES;
  self.layer.cornerRadius = cornerRadius;
  self.layer.borderColor = borderColor.CGColor;
  self.layer.borderWidth = borderWidth;
}

@end
