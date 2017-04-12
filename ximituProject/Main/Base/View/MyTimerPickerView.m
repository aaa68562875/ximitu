//
//  MyTimerPickerView.m
//  XingSiluSend
//
//  Created by zlc on 15/9/22.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "MyTimerPickerView.h"
#import "FTTimeUtil.h"
@implementation MyTimerPickerView
- (id)initWithNibBundleWithView:(UIView *)view
                       withType:(NSString *)type
                      withBlock:(ReturnTimeStrBlock)block {
  self = [[[NSBundle mainBundle] loadNibNamed:@"MyTimerPickerView"
                                        owner:nil
                                      options:nil] objectAtIndex:0];
  if (self) {
    timeStrBlock = block;
    _superView = view;
    _type = type;
    self.frame = FRAME(0, kFTScreenHeight, kFTScreenWidth, 217);
  }

  return self;
}

- (IBAction)cancellClick:(UIButton *)sender {

  [self popMyTimerPickerView];
}

- (IBAction)finishClick:(UIButton *)sender {
  NSString *timeStr = [NSString
      stringWithFormat:@"%@",
                       [NSDate dateWithTimeInterval:3600 * 8
                                          sinceDate:[_mydataPicker date]]];
  timeStr = [FTTimeUtil formatDateToString:[_mydataPicker date]];
  NSLog(@"%@", timeStr);

  [self popMyTimerPickerView];
  _mydataPicker.date = [NSDate date];

  //发送选择的消息
  if (timeStrBlock != nil) {
    timeStrBlock(timeStr, _type);
  }
}

#pragma mark - self 的出现和消失动画
- (void)pushMyTimerPickerView {
  [UIView animateWithDuration:0.2
                   animations:^{
                     self.frame =
                         CGRectMake(0, _superView.bounds.size.height - 217,
                                    _superView.bounds.size.width, 217);
                   }];
}
- (void)popMyTimerPickerView {
  [UIView animateWithDuration:0.2
      animations:^{
        self.frame = CGRectMake(0, _superView.bounds.size.height,
                                _superView.bounds.size.width, 217);
      }
      completion:^(BOOL finished){

      }];
}

- (void)removeMySelf {
  for (UIView *view in self.subviews) {
    [view removeFromSuperview];
  }
  [self removeFromSuperview];
}
@end
