//
//  MyTextField.h
//  tusheng
//
//  Created by Xtoucher08 on 15/8/11.
//  Copyright (c) 2015年 Xtoucher08. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWTextField : UITextField

@property(assign,nonatomic)BOOL canPaste;
@property(assign,nonatomic)BOOL canSelect;
@property(assign,nonatomic)BOOL canSelectAll;

@property(assign,nonatomic)NSInteger maxInputLength;
@property(assign,nonatomic)NSInteger minInputLength;

@end
