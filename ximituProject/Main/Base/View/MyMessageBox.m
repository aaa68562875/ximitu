//
//  MyMessageBox.m
//  XingSiluSend
//
//  Created by 周良才 on 15/9/23.
//  Copyright © 2015年 Wanrongtong. All rights reserved.
//

#import "MyMessageBox.h"

@implementation MyMessageBox

- (id)initWithNibName:(NSString *)nibName
              andView:(UIView *)view
          withMessage:(NSString *)message
            withFrame:(CGRect)frame {
  self = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil]
             .lastObject;
  if (self) {
    _superView = view;
    self.frame = frame;
    _messageLab.text = message;
    [_messageLab resizeHeight];
  }
  return self;
}

//
- (void)showMessageBox {
  self.alpha = 1;
  self.frame =
      CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
  self.center = POINT(kFTScreenWidth / 2, kFTScreenHeight / 2);
}
- (void)hideMessageBox {

  self.alpha = 0;
  self.frame =
      CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
  self.center = POINT(kFTScreenWidth / 2, kFTScreenHeight / 2);
}

- (IBAction)cancellClick:(id)sender {
  [self hideMessageBox];
}

- (IBAction)ensureClick:(id)sender {
  [self hideMessageBox];
}
@end
