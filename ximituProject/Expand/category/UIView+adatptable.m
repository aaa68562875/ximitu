//
//  UIView+adatptable.m
//  loc
//
//  Created by rimi on 15/8/12.
//  Copyright (c) 2015年 lili. All rights reserved.
//

#import "UIView+adatptable.h"
#import "Adapeter.h"

@implementation UIView (adatptable)

- (instancetype)initWithFrame:(CGRect)frame adjustWidth : (BOOL)flag
{
    self = [self initWithFrame:DHFlexibleFrame(frame,flag)];
    return self;
}



@end
