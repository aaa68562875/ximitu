//
//  UILabel+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Common)
/**
 * 设置背景文字,字体,颜色(normal,hilight)
 */
-(void)setText:(NSString *)aText
          font:(CGFloat)aFont
        color1:(UIColor*)aColor1
        color2:(UIColor*)aColor2;

- (void)setSafeText:(NSString *)text;

/**
 * 设置对齐方式(并默认设置UIViewContentModeTop,UILineBreakModeWordWrap)
 */
-(void)setAlignment:(NSTextAlignment)aAlignment;

/**
 * 自适应高度
 */
-(UILabel *)resizeHeight;

/**
 * 自适应宽度
 */
-(void)resizeWidth;

//_______________________________________________//
/**
 将此文本标签垂直居中
 注意：此方法只有在设置 text属性后再调用才生效
 */
-(void)verticalAlignmentCerter;

/**
 将此文本标签垂直居上
 注意：此方法只有在设置 text属性后再调用才生效
 */
-(void)verticalAlignmentTop;

/**
 将此文本标签垂直居下
 注意：此方法只有在设置 text属性后再调用才生效
 */
-(void)verticalAlignmentBottom;
@end
