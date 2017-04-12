//
//  UINavigationItem+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "UINavigationItem+Common.h"

@implementation UINavigationItem (Common)
//**** 自定义标题 ****
-(void)setTitle:(NSString*)aTitle
          color:(UIColor*)aColor
           font:(CGFloat)aFont{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:aFont];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = aColor;
    self.titleView = label;
    label.text = aTitle;
    [label sizeToFit];
}

//**** 自定义左边按钮 ****
-(void)setLeftBarItem:(id)aTarget
               action:(SEL)aAction
                image:(NSString*)aImage
           focusImage:(NSString*)aFocusImage{
    UIImage *image = [UIImage imageNamed:aImage];
    UIImage *focusImage = [UIImage imageNamed:aFocusImage];
    UIButton *aButton = [[UIButton alloc] initWithFrame:
                         CGRectMake(0, 0, (int)image.size.width,(int)image.size.height)];
    [aButton setImage:image forState:UIControlStateNormal];
    [aButton setImage:focusImage forState:UIControlStateHighlighted];
    [aButton addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.leftBarButtonItem = aBarButtonItem;
}

//**** 自定义右边按钮 ****
-(void)setRightBarItem:(id)aTarget
                action:(SEL)aAction
                 image:(NSString*)aImage
            focusImage:(NSString*)aFocusImage{
    UIImage *image = [UIImage imageNamed:aImage];
    UIImage *focusImage = [UIImage imageNamed:aFocusImage];
    UIButton *aButton = [[UIButton alloc] initWithFrame:
                         CGRectMake(0, 0, (int)image.size.width,(int)image.size.height)];
    [aButton setImage:image forState:UIControlStateNormal];
    [aButton setImage:focusImage forState:UIControlStateHighlighted];
    [aButton addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.rightBarButtonItem = aBarButtonItem;
}

@end
