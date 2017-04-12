//
//  FTBaseViewController.h
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
#import "GifLoading.h"
#import "FTBaseBL.h"
#import "AppDelegate.h"
#import "FTRootTabBarController.h"

//#import "TWMessageBarManager.h"    //
#import "FTGuideView.h"
// Numerics
//CGFloat const kTWMesssageBarDemoControllerButtonPadding = 10.0f;
//CGFloat const kTWMesssageBarDemoControllerButtonHeight = 50.0f;

// Colors
static UIColor *kTWMesssageBarDemoControllerButtonColor = nil;


@interface FTBaseViewController
    : UIViewController <FTBaseBLDelegate, MBProgressHUDDelegate,FTGuideViewDelegate> {
  NSString *_titleOfController;
  UILabel *_navigationBarTitleLabel;
  
}

@property (nonatomic,strong) AppDelegate *globalApp;

@property (nonatomic,strong) FTGuideView * guideView;

@property (nonatomic,strong) MBProgressHUD *HUD;
@property(nonatomic, strong) NSString *titleOfController;
@property(nonatomic, strong) UILabel *navigationBarTitleLabel;
@property(weak, nonatomic) IBOutlet UIBarButtonItem *backItem;

//用户id
@property(nonatomic, strong) NSString *uid;

//------- get storyboard
@property (nonatomic,strong) UIStoryboard *mainSB;
@property (nonatomic,strong) UIStoryboard *personSB;


- (void)initUid;
- (void)useGestureForBack;
- (void)doHttpRequest;

/**
 *  HUD methods
 */
- (void)showHUDWithText:(NSString *)text;
- (void)showLoadingHUD;
- (void)showGifLoading;
- (void)hideHUD;
- (void)hideGifLoading;

/**
 *
 */

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
- (IBAction)dismissVC:(id)sender;

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


#pragma mark - status bar message show-----------TWMessageBarManager.h

//- (id)initWithStyleSheet:(NSObject<TWMessageBarStyleSheet> *)stylesheet;

#pragma mark - --------------------------------------------end
// 返回按钮
- (void)createBackBarButton;
//设置KeyViewController  用于appdelegate跳转到指定界面
- (void)setKeyViewController;
//置空KeyViewController
- (void)setKeyViewControllerNil;


//显示模态登录控制器
- (void)presentLoginViewController;

- (void)presentBindingPhoneViewController;

//判断手机格式合法性
- (BOOL)isMobileNumber:(NSString *)mobileNum;



//控制开关右滑返回手势
- (void)setRightSlideBack:(BOOL)isSlide;

- (void)conversionCharacterInterval:(NSInteger)maxInteger
                            current:(NSString *)currentString
                          withLabel:(UILabel *)label;
/**
 *  hide or show tabBar
 */
- (void)hideTabBar;
- (void)showTabBar;
//点击self.view hide键盘
- (void)tapView:(UITapGestureRecognizer *)tap;
//隐藏键盘
- (void)endEditRightNow;
//根据文字，字体大小和宽度计算文字高度
- (CGFloat)calculateHeight:(NSString *)Str :(UIFont *)Font :(CGFloat)width;
//计算一行Label宽度
- (CGFloat)calculateWidthWith:(NSString *)getStr andFont:(UIFont *)myFont;
//重绘Label高度
- (CGRect)reDrawLabelWithLabel:(UILabel *)label andHeight:(CGFloat)height;

@end
