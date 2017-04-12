//
//  MyMessageBox.h
//  XingSiluSend
//
//  Created by 周良才 on 15/9/23.
//  Copyright © 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessageBox : UIView

@property(nonatomic, strong) UIView *superView;
@property(nonatomic, assign) CGRect _frame;

- (id)initWithNibName:(NSString *)nibName
              andView:(UIView *)view
          withMessage:(NSString *)message
            withFrame:(CGRect)frame;

//
- (void)showMessageBox;
- (void)hideMessageBox;

@property(weak, nonatomic) IBOutlet UILabel *messageLab;
@property(weak, nonatomic) IBOutlet UILabel *lineLab;
@property(weak, nonatomic) IBOutlet UIView *botView;

//
- (IBAction)cancellClick:(id)sender;
- (IBAction)ensureClick:(id)sender;

@end
