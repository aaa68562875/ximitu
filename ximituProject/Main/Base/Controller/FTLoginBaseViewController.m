//
//  FTLoginBaseViewController.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTLoginBaseViewController.h"
#import "FTAccountManager.h"
#import "FTErrorView.h"
#import "FTAccountManager.h"
//#import "TPGestureTableViewCell.h"

@interface FTLoginBaseViewController () <FTErrorViewDelegate,
                                         UIGestureRecognizerDelegate>

@end

@implementation FTLoginBaseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.navigationController.navigationBarHidden = NO;
  [self initWithNotification];
  self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);

  [self initUid];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
  // ios7导航颜色设置
  CGFloat osVersion = [[UIDevice currentDevice].systemVersion floatValue];
  if (osVersion >= 7.0) {
    self.navigationController.navigationBar.barTintColor =
        [UIColor redColor]; // navigationBarColor;

    //        [self.myleftBarBut setTintColor:[UIColor blackColor]];
    //        [self.myrightBarBut setTintColor:[UIColor blackColor]];
    //        [[UIApplication sharedApplication] setStatusBarStyle:0];
  } else {
    self.navigationController.navigationBar.tintColor =
        [UIColor redColor]; // navigationBarColor;
    //        [self.myleftBarBut setTintColor:[UIColor blackColor]];
    //        [self.myrightBarBut setTintColor:[UIColor blackColor]];
    //        [[UIApplication sharedApplication] setStatusBarStyle:0];
  }

  //设置导航栏标题字体的颜色
  //    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"MySkin"]
  //    isEqualToString:@"blue"]) {
  //        [self.navigationController.navigationBar
  //        setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
  //        [UIColor whiteColor], UITextAttributeTextColor,nil]];
  //    }
  //    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"MySkin"]
  //    isEqualToString:@"red"]){
  //        [self.navigationController.navigationBar
  //        setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
  //        [UIColor yellowColor], UITextAttributeTextColor,nil]];
  //    }
  //    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"MySkin"]
  //    isEqualToString:@"yellow"]){
  //        [self.navigationController.navigationBar
  //        setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
  //        [UIColor blueColor], UITextAttributeTextColor,nil]];
  //    }
  //    else{
  //    [self.navigationController.navigationBar
  //    setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
  //    [UIColor whiteColor], UITextAttributeTextColor,nil]];
  //    }
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:kFTLoginSuccess
                                                object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:kFTLogoutSuccess
                                                object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:kFTLoginStateChanged
                                                object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:kFTAutoLoginLoginFailure
                                                object:nil];
}

#pragma mark - private method

- (void)initWithNotification {

  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(didReceiveLoginSuccessNotification:)
             name:kFTLoginSuccess
           object:nil];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(didReceiveLogoutSuccessNotification:)
             name:kFTLogoutSuccess
           object:nil];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(didReceiveLoginStateChangedNotification:)
             name:kFTLoginStateChanged
           object:nil];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(didReceiveLoginFailureNotification:)
             name:kFTAutoLoginLoginFailure
           object:nil];
}
//空方法   去警告
- (void)useGestureForBack {
}
- (void)doHttpRequest {
}
- (UIView *)errorView {
  return nil;
}
- (UIView *)loadingView {
  return nil;
}
- (void)showLoadingAnimated:(BOOL)animated {
}
- (void)hideLoadingViewAnimated:(BOOL)animated {
}

#pragma mark public method
- (void)initUid {
  if ([[FTAccountManager sharedManager].userInfo objectForKey:@"uid"] != nil) {
    self.uid = [[FTAccountManager sharedManager].userInfo objectForKey:@"uid"];

    [[NSUserDefaults standardUserDefaults] setObject:self.uid forKey:@"MYUID"];

  } else {
    self.uid = @"";
  }
}
#pragma
#pragma mark - 用户提示界面变化

- (void)showErrorViewAnimated:(BOOL)animated {
  FTErrorView *errorView = (FTErrorView *)[self.view viewWithTag:404];
  if (errorView) {
    [errorView removeFromSuperview];
    errorView = nil;
  }
  if (self.navigationController.navigationBar.hidden == NO) {
    errorView = [[FTErrorView alloc]
        initWithFrame:CGRectMake(0, kFTNaviBarHeight, kFTScreenWidth,
                                 self.view.bounds.size.height -
                                     kFTNaviBarHeight)];
  } else {
    errorView = [[FTErrorView alloc]
        initWithFrame:CGRectMake(0, kFTNaviBarHeight, 320,
                                 self.view.bounds.size.height -
                                     kFTNaviBarHeight)];
  }
  errorView.delegate = self;
  errorView.alpha = 0.0f;
  errorView.tag = 404;
  [self.view addSubview:errorView];
  [self.view insertSubview:errorView belowSubview:HUD];
  double duration = animated ? 0.4f : 0.0f;
  [UIView animateWithDuration:duration
                   animations:^{
                     errorView.alpha = 1.0f;
                   }];
}

- (void)hideErrorViewAnimated:(BOOL)animated {
  UIView *errorView = [self.view viewWithTag:404];
  double duration = animated ? 0.3f : 0.0f;
  [UIView animateWithDuration:duration
      animations:^{
        errorView.alpha = 0.0f;
      }
      completion:^(BOOL finished) {
        [errorView removeFromSuperview];
      }];
}

#pragma mark - handle notification received methods
- (void)didReceiveLoginSuccessNotification:(NSNotification *)notification {
}

- (void)didReceiveLoginStateChangedNotification:(NSNotification *)notification {
}

- (void)didReceiveLogoutSuccessNotification:(NSNotification *)notification {
}

- (void)didReceiveLoginFailureNotification:(NSNotification *)notification {
}

- (IBAction)backToLeftView:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)presentLoginViewController {
  UIViewController *loginViewController = [self.storyboard
      instantiateViewControllerWithIdentifier:@"loginNavController"];
  [self presentViewController:loginViewController animated:YES completion:nil];
}

- (void)presentBindingPhoneViewController {
  UIViewController *bindingPhoneViewController = [self.storyboard
      instantiateViewControllerWithIdentifier:@"bindingPhoneNavController"];
  [self presentViewController:bindingPhoneViewController
                     animated:NO
                   completion:nil];
}
//判断手机格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {

  NSString *DD = @"^1[3|4|5|7|8][0-9]\\d{8}$";
  NSPredicate *regextestmobile =
      [NSPredicate predicateWithFormat:@"SELF MATCHES %@", DD];
  if ([regextestmobile evaluateWithObject:mobileNum] == YES) {

    return YES;
  } else {
    return NO;
  }
}
#pragma mark - HUD methods

- (void)showHUDWithText:(NSString *)text {
  if (HUD) {
    [HUD removeFromSuperview];
    HUD = nil;
  }
  if (self.navigationController != nil) {
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    [self.navigationController.view bringSubviewToFront:HUD];
  } else {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
  }
  HUD.delegate = self;
  HUD.mode = MBProgressHUDModeText;
  HUD.labelText = text;
  [HUD show:YES];
  [self performSelector:@selector(hideHUD) withObject:nil afterDelay:2.0f];
}

- (void)hideHUD {
  [HUD hide:YES];
}
- (void)showLoadingHUD {
  if (HUD) {
    [HUD removeFromSuperview];
    HUD = nil;
  }
  if (HUD == nil) {

    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    //        }
    HUD.delegate = self;
    HUD.mode = MBProgressHUDModeIndeterminate;
    // HUD.labelText = @"载入中...";
  }
  [HUD show:YES];
}

- (void)showConnectionFailureView {
  [self showErrorViewAnimated:YES];
}

- (void)hideConnectionFailureView {
  [self hideErrorViewAnimated:YES];
}

@end
