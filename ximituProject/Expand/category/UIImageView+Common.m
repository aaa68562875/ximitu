//
//  UIImageView+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "UIImageView+Common.h"

@implementation UIImageView (Common)


- (void)setImageViewOriginX:(float)originX
                    OriginY:(float)originY
                   setImage:(NSString *)imageStr
{
    UIImage *image=[UIImage imageNamed:imageStr];
    [self setFrame:CGRectMake(originX, originY, image.size.width, image.size.height)];
    [self setImage:image];
}

@end
