//
//  MyTimerPickerView.h
//  XingSiluSend
//
//  Created by zlc on 15/9/22.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnTimeStrBlock)(NSString *message, NSString *type);

@interface MyTimerPickerView : UIView {

  ReturnTimeStrBlock timeStrBlock;
}
- (id)initWithNibBundleWithView:(UIView *)view
                       withType:(NSString *)type
                      withBlock:(ReturnTimeStrBlock)block;

@property(nonatomic, strong) NSString *type; // 0:开始时间，1结束时间
@property(nonatomic, strong) UIView *superView;

#pragma mark - self 的出现和消失动画
- (void)pushMyTimerPickerView;
- (void)popMyTimerPickerView;

//移除自己
- (void)removeMySelf;

@property(weak, nonatomic) IBOutlet UIDatePicker *mydataPicker;

@property(weak, nonatomic) IBOutlet UIButton *cancellBtn;
@property(weak, nonatomic) IBOutlet UIButton *finishBtn;
#pragma mark - 确定/取消点击事件
- (IBAction)cancellClick:(UIButton *)sender;

- (IBAction)finishClick:(UIButton *)sender;

@end
