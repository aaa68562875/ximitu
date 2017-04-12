//
//  UIButton+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Common)
/**
 * 设置标题,字体,颜色(normal,hilight(selected))
 */
-(void)setTitle:(NSString *)title
           font:(CGFloat)aFont
         color1:(UIColor*)aColor1
         color2:(UIColor*)aColor2;

/**
 * 设置标题,字体
 */
-(void)setTitle:(NSString *)title
           font:(CGFloat)aFont;

/**
 * 设置图片
 */
-(void)setNormalImage:(NSString*)aImage1
       highlightImage:(NSString*)aImage2;

/**
 * 设置背景图片
 */
-(void)setNormalBGImage1:(NSString*)aImage1
       highlightBGImage2:(NSString*)aImage2;

/**
 * 设置事件 UIControlEventTouchUpInside
 */
-(void)setTarget:(id)aTarget
          action:(SEL)aAction;

/*
 * 设置Frame
 * 设置图片
 * 设置事件 UIControlEventTouchUpInside
 */
- (void)setFrame:(CGRect)rect
  setNormalImage:(NSString*)aImage1
  highlightImage:(NSString*)aImage2
       addTarget:(id)conctroller
         selctor:(SEL)selctor;

/**
 *  设置button上的文字和图片上下垂直/水平居中对齐
 */
- (void)setButtonWithImg:(UIImage *)img
                andTitle:(NSString *)title;

//---------------------------------------------------------------//
-(void)_setBackgroundImageWithString:(NSString*)str forState:(UIControlState)state;

-(NSString*)disableBackgroundImageScaleableName;

-(void)setDisableBackgroundImageScaleableName:(NSString *)backgroundImageScaleableName_Disable;

-(NSString*)normalBackgroundImageScaleableName;

-(void)setNormalBackgroundImageScaleableName:(NSString *)backgroundImageScaleableName_Normal;

-(NSString*)highlightedBackgroundImageScaleableName;

-(void)setHighlightedBackgroundImageScaleableName:(NSString *)backgroundImageScaleableName_Normal;

-(NSString*)selectedBackgroundImageScaleableName;

-(void)setSelectedBackgroundImageScaleableName:(NSString *)backgroundImageScaleableName_Selected;
@end
