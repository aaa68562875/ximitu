//
//  FTStaticTableViewController.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTStaticTableViewController.h"
#import "FTAccountManager.h"
#import "FTErrorView.h"

@interface FTStaticTableViewController () <FTErrorViewDelegate,
                                           UIGestureRecognizerDelegate>

@end

@implementation FTStaticTableViewController
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
    
//    _myStoryboard = [UIStoryboard storyboardWithName:@"My" bundle:[NSBundle mainBundle]];
//    _discoverStoryboard = [UIStoryboard storyboardWithName:@"Discover" bundle:[NSBundle mainBundle]];
    
    [self initWithNotification];
  if ([[FTAccountManager sharedManager].userInfo objectForKey:@"uid"] != nil) {
    self.uid = [[FTAccountManager sharedManager].userInfo objectForKey:@"uid"];
  } else {
    self.uid = @"";
  }

  //右滑返回手势

  //    self.slidePan = [[UIPanGestureRecognizer alloc] initWithTarget:self
  //    action:@selector(slideBack:)];
  //    self.slidePan.delegate = self;
  //    [self.view addGestureRecognizer:_slidePan];
}

- (void)slideBack:(UIPanGestureRecognizer *)pan {
  CGPoint translation = [pan translationInView:self.view];
  if (pan.state == UIGestureRecognizerStateBegan) {
    direction = kCameraMoveDirectionNone;
  } else if (pan.state == UIGestureRecognizerStateChanged &&
             direction == kCameraMoveDirectionNone) {
    direction = [self determineCameraDirectionIfNeeded:translation];
    // ok, now initiate movement in the direction indicated by the user's
    // gesture
    switch (direction) {
    case kCameraMoveDirectionDown:
      break;
    case kCameraMoveDirectionUp:

      break;
    case kCameraMoveDirectionRight: {
      [self.navigationController popViewControllerAnimated:YES];
    } break;
    case kCameraMoveDirectionLeft: {
    } break;
    default:
      break;
    }
  } else if (pan.state == UIGestureRecognizerStateEnded) {
    // now tell the camera to stop
  }
}
// This method will determine whether the direction of the user's swipe
- (CameraMoveDirection)determineCameraDirectionIfNeeded:(CGPoint)translation {
  if (direction != kCameraMoveDirectionNone)
    return direction;
  // determine if horizontal swipe only if you meet some minimum velocity
  if (fabs(translation.x) > 20) {
    BOOL gestureHorizontal = NO;
    if (translation.y == 0.0)
      gestureHorizontal = YES;
    else
      gestureHorizontal = (fabs(translation.x / translation.y) > 5.0);
    if (gestureHorizontal) {
      if (translation.x > 0.0)
        return kCameraMoveDirectionRight;
      else
        return kCameraMoveDirectionLeft;
    }
  }
  // determine if vertical swipe only if you meet some minimum velocity
  else if (fabs(translation.y) > 20) {
    BOOL gestureVertical = NO;
    if (translation.x == 0.0)
      gestureVertical = YES;
    else
      gestureVertical = (fabs(translation.y / translation.x) > 5.0);
    if (gestureVertical) {
      if (translation.y > 0.0)
        return kCameraMoveDirectionDown;
      else
        return kCameraMoveDirectionUp;
    }
  }
  return direction;
}
#pragma mark - gesture delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {

  if (self.navigationController.childViewControllers.count == 1) {
    return NO;
  }

  return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {

  //    NSLog(@"%@",[touch.view.superview class]);
  //    if ([touch.view.superview isKindOfClass:[TPGestureTableViewCell class]])
  //    {
  //        return NO;
  //    }

  return YES;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
    [self setKeyViewController];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self setKeyViewControllerNil];
    
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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

- (IBAction)backToLeftView:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

//设置KeyViewController
- (void)setKeyViewController{
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    app.KeyViewController = self;
}
//置空KeyViewController
- (void)setKeyViewControllerNil{
//    ((AppDelegate *)[UIApplication sharedApplication].delegate).KeyViewController = nil;
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
  [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1.5f];
}

- (void)hideHUD {
  [HUD hide:YES];
}

- (void)hideGifLoading{
    [GifLoading hideLoadingForView:self.view];
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

- (void)showGifLoading{
    [GifLoading showLoadingForView:self.view allowUserInteraction:NO];
}

- (void)showConnectionFailureView {
  [self showErrorViewAnimated:YES];
}

- (void)hideConnectionFailureView {
  [self hideErrorViewAnimated:YES];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section

{
  //设置第一个section与顶部的间隔为20，这样就统一了section与顶部，section与section之间的间隔
  return section == 0 ? 20.0 : 10.0;
}
#pragma mark - 空方法  去警告
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
#pragma mark - handle notification received methods
- (void)didReceiveLoginSuccessNotification:(NSNotification *)notification {
}

- (void)didReceiveLoginStateChangedNotification:(NSNotification *)notification {
}

- (void)didReceiveLogoutSuccessNotification:(NSNotification *)notification {
}

- (void)didReceiveLoginFailureNotification:(NSNotification *)notification {
}
@end
