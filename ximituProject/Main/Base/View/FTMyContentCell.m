//
//  FTMyContentCell.m
//  XingSiluSend
//
//  Created by zlc on 15/9/7.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTMyContentCell.h"

@implementation ItemModel

- (id)initWithTitle:(NSString *)title andSelect:(BOOL)select{
    
    self = [super init];
    if (self) {
        _title = title;
        _isSelect = select;
    }
    
    return self;
}

@end

@implementation FTMyContentCell




@end
