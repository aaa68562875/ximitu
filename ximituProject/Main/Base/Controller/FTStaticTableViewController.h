//
//  FTStaticTableViewController.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTBaseViewController.h"
//#import "GifLoading.h"
#import "FTBaseBL.h"
#import "AppDelegate.h"
@interface FTStaticTableViewController
    : UITableViewController <FTBaseBLDelegate, MBProgressHUDDelegate> {
  MBProgressHUD *HUD;
  CameraMoveDirection direction;
}

@property(nonatomic, strong) UIPanGestureRecognizer *slidePan;
//用户id
@property(nonatomic, strong) NSString *uid;


//------- get storyboard
@property (nonatomic,strong) UIStoryboard *myStoryboard;
@property (nonatomic,strong) UIStoryboard *discoverStoryboard;


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

//设置KeyViewController  用于appdelegate跳转到指定界面
- (void)setKeyViewController;
//置空KeyViewController
- (void)setKeyViewControllerNil;

@end
