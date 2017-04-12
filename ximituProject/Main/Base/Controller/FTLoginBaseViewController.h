//
//  FTLoginBaseViewController.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

/**
 *  作为所有视图父类
 *  并提供所有公有的方法
 */
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "FTBaseBL.h"

@interface FTLoginBaseViewController
    : UIViewController <FTBaseBLDelegate, MBProgressHUDDelegate> {
  NSString *_titleOfController;
  UILabel *_navigationBarTitleLabel;
  MBProgressHUD *HUD;
}
@property(nonatomic, strong) NSString *titleOfController;
@property(nonatomic, strong) UILabel *navigationBarTitleLabel;

@property(weak, nonatomic) IBOutlet UINavigationItem *myNavgationItem;

@property(weak, nonatomic) IBOutlet UIBarButtonItem *myleftBarBut;

@property(weak, nonatomic) IBOutlet UIBarButtonItem *myrightBarBut;

//用户id
@property(nonatomic, strong) NSString *uid;

- (void)initUid;
- (void)useGestureForBack;
- (void)doHttpRequest;

/**
 *  HUD methods
 */
- (void)showHUDWithText:(NSString *)text;
- (void)showLoadingHUD;
- (void)hideHUD;

/**
 *
 */
//判断手机格式合法性
- (BOOL)isMobileNumber:(NSString *)mobileNum;

- (UIView *)errorView;
- (UIView *)loadingView;
- (void)showLoadingAnimated:(BOOL)animated;
- (void)hideLoadingViewAnimated:(BOOL)animated;
- (void)showErrorViewAnimated:(BOOL)animated;
- (void)hideErrorViewAnimated:(BOOL)animated;

- (void)didReceiveLoginSuccessNotification:(NSNotification *)notification;
- (void)didReceiveLogoutSuccessNotification:(NSNotification *)notification;
- (void)didReceiveLoginStateChangedNotification:(NSNotification *)notification;

- (IBAction)backToLeftView:(id)sender;

//显示模态登录控制器
- (void)presentLoginViewController;

- (void)presentBindingPhoneViewController;

@end
