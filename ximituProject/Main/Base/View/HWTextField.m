//
//  MyTextField.m
//  tusheng
//
//  Created by Xtoucher08 on 15/8/11.
//  Copyright (c) 2015年 Xtoucher08. All rights reserved.
//

#import "HWTextField.h"

#define TEXT_LEFT_MARGIN 10.0

#define TEXT_BOUNDS CGRectMake(TEXT_LEFT_MARGIN, 0, bounds.size.width-TEXT_LEFT_MARGIN, bounds.size.height)

@implementation HWTextField

//-(void)awakeFromNib
//{
//    [super awakeFromNib];
//    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//}

//-(instancetype)initWithFrame:(CGRect)frame adjustWidth:(BOOL)flag {
//    self.frame = frame;
//    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0) adjustWidth:flag];
//    self.leftViewMode = UITextFieldViewModeAlways;
//    return self;
//}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))
        return self.canPaste;
    if (action == @selector(select:))
        return self.canSelect;
    if (action == @selector(selectAll:))
        return self.canSelectAll;
    return [super canPerformAction:action withSender:sender];
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    if (self.textAlignment == NSTextAlignmentLeft) {
        return TEXT_BOUNDS;
    }
    return bounds;
}

-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    if (self.textAlignment == NSTextAlignmentLeft) {
        return TEXT_BOUNDS;
    }
    return bounds;
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    if (self.textAlignment == NSTextAlignmentLeft) {
        return TEXT_BOUNDS;
    }
    return bounds;
}

@end
