//
//  GetAndPhoneView.m
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/6/21.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "GetAndPhoneView.h"

@interface GetAndPhoneView ()
{
    BOOL isStar;
}




@end

@implementation GetAndPhoneView

- (instancetype)initWithFrame:(CGRect)frame andIsStared:(BOOL)stared andHandlerBlock:(sendTypeBlock)block{
    self = [[NSBundle mainBundle] loadNibNamed:@"GetAndPhoneView" owner:nil options:nil].lastObject;
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.0;
        self.block = block;
        isStar = stared;//
        
        
        
    }
    
    return self;
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 312:
        {
            if (self.block) {
                self.block(@"1");
            }
            [self hideMyself];
        }
            break;
        case 313:
        {
            if (self.block) {
                self.block(@"2");
            }
            [self hideMyself];
        }
            break;
        default:
            break;
    }

    
}

- (void)showMyself{
    self.alpha = 1;
    self.hidden = NO;
}
- (void)hideMyself{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)removeMyself{
    self.alpha = 0;
    [self removeFromSuperview];
}

@end
