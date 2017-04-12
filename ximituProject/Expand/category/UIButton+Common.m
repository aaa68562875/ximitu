//
//  UIButton+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "UIButton+Common.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+Common.h"
#import "UIImage+Common.h"
#import "NSArray+Common.h"
#import <objc/runtime.h>
@implementation UIButton (Common)
-(void)setTitle:(NSString *)title
           font:(CGFloat)aFont
{
    if ([title isEmpty]) {
        title=@"";
    }
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:aFont];
}

-(void)setTitle:(NSString *)title
           font:(CGFloat)aFont
         color1:(UIColor*)aColor1
         color2:(UIColor*)aColor2{
    if ([title isEmpty]) {
        title=@"";
    }
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:aFont];
    [self setTitleColor:aColor1 forState:UIControlStateNormal];
    [self setTitleColor:aColor2 forState:UIControlStateHighlighted];
    [self setTitleColor:aColor2 forState:UIControlStateSelected];
}

-(void)setNormalImage:(NSString*)aImage1
       highlightImage:(NSString*)aImage2{
    [self setImage:[UIImage imageNamed:aImage1] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:aImage2] forState:UIControlStateHighlighted];
    [self setImage:[UIImage imageNamed:aImage2] forState:UIControlStateSelected];
}

-(void)setNormalBGImage1:(NSString*)aImage1
       highlightBGImage2:(NSString*)aImage2{
    [self setBackgroundImage:[UIImage imageNamed:aImage1] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:aImage2] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:aImage2] forState:UIControlStateSelected];
}

-(void)setTarget:(id)aTarget
          action:(SEL)aAction{
    [self addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
}

- (void)setFrame:(CGRect)rect
  setNormalImage:(NSString*)aImage1
  highlightImage:(NSString*)aImage2
       addTarget:(id)conctroller
         selctor:(SEL)selctor
{
    [self setFrame:rect];
    [self setImage:[UIImage imageNamed:aImage1] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:aImage2] forState:UIControlStateHighlighted];
    [self setImage:[UIImage imageNamed:aImage2] forState:UIControlStateSelected];
    [self addTarget:conctroller action:selctor forControlEvents:UIControlEventTouchUpInside];
}

- (void)setButtonWithImg:(UIImage *)img
                andTitle:(NSString *)title{
    
    // 在UIButton中有三个对EdgeInsets的设置：ContentEdgeInsets、titleEdgeInsets、imageEdgeInsets
    [self setImage:img forState:UIControlStateNormal];//给button添加image
    self.imageEdgeInsets = UIEdgeInsetsMake(5,29,22,self.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    
    [self setTitle:title forState:UIControlStateNormal];//设置button的title
    self.titleLabel.font = [UIFont systemFontOfSize:12];//title字体大小
    self.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    self.titleEdgeInsets = UIEdgeInsetsMake(25, -self.titleLabel.bounds.size.width-25, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
}

//_______________________________________________________________________________________//
#if 1
-(void)_setBackgroundImageWithString:(NSString*)str forState:(UIControlState)state
{
    [self setBackgroundImage:[UIImage resizableImageWithString:str] forState:state];
}
char * const kUIButtonBackgroundImageScaleableNameDisableKey="kUIButtonBackgroundImageScaleableNameDisableKey";
char * const kUIButtonBackgroundImageScaleableNameNormalKey="kUIButtonBackgroundImageScaleableNameNormalKey";
char * const kUIButtonBackgroundImageScaleableNameHighlightedKey="kUIButtonBackgroundImageScaleableNameHightedKey";
char * const kUIButtonBackgroundImageScaleableNameSelectedKey="kUIButtonBackgroundImageScaleableNameSelectedKey";
-(NSString*)disableBackgroundImageScaleableName
{
    return objc_getAssociatedObject(self, kUIButtonBackgroundImageScaleableNameDisableKey);
}
-(void)setDisableBackgroundImageScaleableName:(NSString *)backgroundImageScaleableName_Disable
{
    objc_setAssociatedObject(self, kUIButtonBackgroundImageScaleableNameDisableKey, backgroundImageScaleableName_Disable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _setBackgroundImageWithString:backgroundImageScaleableName_Disable forState:UIControlStateDisabled];
}

-(NSString*)normalBackgroundImageScaleableName
{
    return objc_getAssociatedObject(self, kUIButtonBackgroundImageScaleableNameNormalKey);
}
-(void)setNormalBackgroundImageScaleableName:(NSString *)backgroundImageScaleableName_Normal
{
    objc_setAssociatedObject(self, kUIButtonBackgroundImageScaleableNameNormalKey, backgroundImageScaleableName_Normal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _setBackgroundImageWithString:backgroundImageScaleableName_Normal forState:UIControlStateNormal];
}

-(NSString*)highlightedBackgroundImageScaleableName
{
    return objc_getAssociatedObject(self, kUIButtonBackgroundImageScaleableNameHighlightedKey);
}
-(void)setHighlightedBackgroundImageScaleableName:(NSString *)backgroundImageScaleableName_Normal
{
    objc_setAssociatedObject(self, kUIButtonBackgroundImageScaleableNameHighlightedKey, backgroundImageScaleableName_Normal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _setBackgroundImageWithString:backgroundImageScaleableName_Normal forState:UIControlStateHighlighted];
}

-(NSString*)selectedBackgroundImageScaleableName
{
    return objc_getAssociatedObject(self, kUIButtonBackgroundImageScaleableNameSelectedKey);
}
-(void)setSelectedBackgroundImageScaleableName:(NSString *)backgroundImageScaleableName_Selected
{
    objc_setAssociatedObject(self, kUIButtonBackgroundImageScaleableNameSelectedKey, backgroundImageScaleableName_Selected, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _setBackgroundImageWithString:backgroundImageScaleableName_Selected forState:UIControlStateSelected];
    
}

#endif


@end
