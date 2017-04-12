//
//  UITextField+Common.m
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/8/24.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "UITextField+Common.h"

@implementation UITextField (Common)

- (void)setLeftViewSpace{
    UIView *View = [[UIView alloc] initWithFrame:FRAME(0, 0, 10, 30)];
    self.leftViewMode = UITextFieldViewModeUnlessEditing;
    self.leftView = View;
}

@end
