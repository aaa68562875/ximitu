//
//  FTBaseViewController.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTBaseViewController.h"
#import "FTAccountManager.h"
#import "FTErrorView.h"
#import "FTAccountManager.h"
//#import "BMapKit.h"
#import "BaseNavigationViewController.h"


//#import "StringConstants.h"
@interface FTBaseViewController () <UIGestureRecognizerDelegate,
                                    FTErrorViewDelegate>

@end

@implementation FTBaseViewController{
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [self initUid];
//    [self createGuideView];
    
    [self setNavigationBar];
    
    [self setKeyViewController];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setKeyViewControllerNil];
    
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
  [super viewDidLoad];
    
    
    
    //全局手势返回
    self.navigationController.jz_fullScreenInteractivePopGestureEnabled = YES;
    
    kTWMesssageBarDemoControllerButtonColor = [UIColor colorWithWhite:0.0 alpha:0.25];
    
    _globalApp = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
  self.navigationController.navigationBar.translucent = NO;
  self.navigationController.navigationBarHidden = YES;
  [self initWithNotification];
  self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);

  [self initUid];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    }
    
    _personSB = [UIStoryboard storyboardWithName:@"Person" bundle:nil];
}

#pragma mark - FTGuideViewDelegate
- (void)removeView:(UIView *)view
{
    if (view!=nil) {
        [_guideView removeFromSuperview];
        _guideView = nil;
    }
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}


#pragma mark - FTGuideViewDelegate
- (void)createGuideView{
    NSString * value = [[NSUserDefaults standardUserDefaults] objectForKey:@"One"];
    if([value isEqualToString:@"YES"])//第一次进入app
    {
        self.navigationController.navigationBarHidden = YES;
        self.navigationController.tabBarController.tabBar.hidden = YES;
        _guideView = [[FTGuideView alloc]init];
        _guideView.guideDelegate = self;
        [self.view addSubview:_guideView];
    }else{
        self.navigationController.navigationBarHidden = NO;
    }
}

#pragma mark - back button
- (void)createBackBarButton{
    UIBarButtonItem *backItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back@2x"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(backToLeftView:)];
    //设置BarButtonItem颜色为白色
    [self.navigationController.navigationBar setTintColor:WhiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark - private method
- (void)setNavigationBar{
    // ios7导航颜色设置
    CGFloat osVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (osVersion >= 7.0) {
        
        self.navigationController.navigationBar.barTintColor = UIColorGromRGBV(38, 180, 99);
        //        [UIColor blueColor];//navigationBarColor;
    } else {
        self.navigationController.navigationBar.tintColor =    UIColorGromRGBV(38, 180, 99);
        //        [UIColor blueColor];//navigationBarColor;
    }
    
    //设置导航栏标题字体的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:WhiteColor}];
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

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


//根据文字，字体大小和宽度计算文字高度
- (CGFloat)calculateHeight:(NSString *)Str :(UIFont *)Font :(CGFloat)width {

  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    CGRect rect =
        [Str boundingRectWithSize:CGSizeMake(width, 100000)
                          options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{
                         NSFontAttributeName : Font
                       } context:nil];
    return ceilf(rect.size.height);
  } else {
    CGSize size =
        [Str sizeWithFont:Font constrainedToSize:CGSizeMake(width, 10000)];
    return size.height;
  }
}
//计算一行Label宽度
- (CGFloat)calculateWidthWith:(NSString *)getStr andFont:(UIFont *)myFont {

  CGSize size = [getStr sizeWithAttributes:@{NSFontAttributeName : myFont}];

  return size.width;
}
//重绘View高度
- (CGRect)reDrawLabelWithLabel:(UILabel *)label andHeight:(CGFloat)height {
  CGRect rect = label.frame;

  rect.size.height = height;

  label.frame = rect;

  return rect;
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
  if ([FTAccountManager sharedManager].userInfo[@"user"][@"id"] != nil) {
      self.uid = [FTAccountManager sharedManager].userInfo[@"user"][@"id"];

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
        initWithFrame:CGRectMake(0, 0, kFTScreenWidth,
                                 kFTScreenHeight)];
  } else {
    errorView = [[FTErrorView alloc]
        initWithFrame:CGRectMake(0, 0, kFTScreenWidth,
                                 kFTScreenHeight)];
  }
  errorView.delegate = self;
  errorView.alpha = 1.0f;
  errorView.tag = 404;
    errorView.backgroundColor = WhiteColor;
  [self.view addSubview:errorView];
  [self.view insertSubview:errorView belowSubview:_HUD];
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

- (IBAction)dismissVC:(id)sender {

  [self dismissViewControllerAnimated:NO completion:nil];
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
- (void)hideTabBar {
  self.tabBarController.tabBar.hidden = YES;
}
- (void)showTabBar {
  self.tabBarController.tabBar.hidden = NO;
}
//点击self.view hide键盘
- (void)tapView:(UITapGestureRecognizer *)tap {
  [self endEditRightNow];
}
//隐藏键盘
- (void)endEditRightNow {
  [self.view endEditing:YES];
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

//控制开关右滑返回手势
- (void)setRightSlideBack:(BOOL)isSlide {
  BaseNavigationViewController *rootNav =
      (BaseNavigationViewController *)self.navigationController;
  rootNav.isSlideBack = isSlide;
}

- (void)conversionCharacterInterval:(NSInteger)maxInteger
                            current:(NSString *)currentString
                          withLabel:(UILabel *)label {
    CGRect rect = [[currentString substringToIndex:1]
                   boundingRectWithSize:CGSizeMake(200, label.frame.size.height)
                   options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                   attributes:@{
                                NSFontAttributeName : label.font
                                
                                } context:nil];
    NSMutableAttributedString *attrString =
    [[NSMutableAttributedString alloc] initWithString:currentString];
    float strLength = [self getLengthOfString:currentString];
    [attrString addAttribute:NSKernAttributeName
                       value:@(((maxInteger - strLength) * rect.size.width) /
     (strLength - 1))
                       range:NSMakeRange(0, strLength)];
    label.attributedText = attrString;
}
- (float)getLengthOfString:(NSString *)str {
    float strLength = 0;
    char *p = (char *)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i = 0;
         i < [str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            strLength++;
        }
        p++;
    }
    return strLength / 2;
}

#pragma mark - HUD methods

- (void)showHUDWithText:(NSString *)text {
  if (_HUD) {
    [_HUD removeFromSuperview];
    _HUD = nil;
  }
  if (self.navigationController != nil) {
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
      
    [self.navigationController.view.window addSubview:_HUD];
    [self.navigationController.view.window bringSubviewToFront:_HUD];
  } else {
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view.window addSubview:_HUD];
    [self.view.window bringSubviewToFront:_HUD];
  }
    _HUD.yOffset = 0.f;
  _HUD.delegate = self;
  _HUD.mode = MBProgressHUDModeText;
//  _HUD.detailsLabelText = text;
    _HUD.labelText = text;
  [_HUD show:YES];
  [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1.0f];
}

- (void)hideHUD {
  [_HUD hide:YES];
}
- (void)hideGifLoading{
    [GifLoading hideLoadingForView:self.view];
}

- (void)showLoadingHUD {
  if (_HUD) {
    [_HUD removeFromSuperview];
    _HUD = nil;
  }
  if (_HUD == nil) {

    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    //        }
    _HUD.delegate = self;
    _HUD.mode = MBProgressHUDModeIndeterminate;
    // HUD.labelText = @"载入中...";
  }
  [_HUD show:YES];
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



#pragma mark - -----------------------------TWMessageBarManager
//- (id)initWithStyleSheet:(NSObject<TWMessageBarStyleSheet> *)stylesheet
//{
//    self = [super init];
//    if (self)
//    {
//        [TWMessageBarManager sharedInstance].styleSheet = stylesheet;
//    }
//    return self;
//}

//- (id)init
//{
//    return [self initWithStyleSheet:nil];
//}

#pragma mark - Orientation


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait); // pre-iOS 6 support
}

- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - -----------------------------

@end
