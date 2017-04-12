//
//  FTWarningView.h
//  XingSiluSend
//
//  Created by zlc on 16/1/28.
//  Copyright © 2016年 Flybor. All rights reserved.
//


typedef void(^HandleBlock)(BOOL status);
#import <UIKit/UIKit.h>

@interface FTWarningView : UIView
{
    HandleBlock block;
}

/**
 *  顶部View
 */
@property (weak, nonatomic) IBOutlet UIView *topView;
/**
 *  底部View
 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *cancellBtn;
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;

/**
 *  提示信息
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
/**
 *  确定
 *
 *  @param sender
 */
- (IBAction)cancellClick:(id)sender;
/**
 *  确定
 *
 *  @param sender
 */
- (IBAction)ensureClick:(id)sender;

#pragma mark - 
- (id)initWithSuperView:(UIView *)view withContent:(NSString *)content handleOperateWithBlock:(HandleBlock)handle;


- (void)showSelf;
- (void)hideSelf;
- (void)removeSelf;
@end
