//
//  UIImageView+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Common)


/*
 *初始化UIImageView数据
 *originX,坐标x
 *originY,坐标y
 */
- (void)setImageViewOriginX:(float)originX
                    OriginY:(float)originY
                   setImage:(NSString *)imageStr;

@end
