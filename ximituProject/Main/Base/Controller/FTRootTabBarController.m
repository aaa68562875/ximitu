//
//  FTRootTabBarController.m
//  XingSiluSend
//
//  Created by zlc on 15/8/4.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTRootTabBarController.h"
#import "BaseNavigationViewController.h"
//#import "FTLoginViewContrller.h"
#import "FTHomeViewController.h"
#import "AppDelegate.h"
//#import "FTAccountManager.h"

@interface FTRootTabBarController ()<UITabBarControllerDelegate>
{
    BOOL isLogin;
    AppDelegate *appDelegate;
}
@end

@implementation FTRootTabBarController{
    FTGuideView * _guideView;
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
//    NSString * value = [[NSUserDefaults standardUserDefaults]objectForKey:@"One"];
//    if([value isEqualToString:@"YES"])//第一次进入app
//    {
//        _guideView = [[FTGuideView alloc]init];
//        _guideView.guideDelegate = self;
//        [self.view addSubview:_guideView];
//    }
}

#pragma mark - FTGuideViewDelegate
- (void)removeView:(UIView *)view
{
    if (view!=nil) {
        [_guideView removeFromSuperview];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = UIColorGromRGBV(38, 190, 99);
    self.tabBar.barTintColor = WhiteColor;
    self.tabBar.backgroundColor = WhiteColor;
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    isLogin = YES;
    self.delegate = self;
    
    for (UITabBarItem * i in self.tabBar.items) {
        i.titlePositionAdjustment = UIOffsetMake(0, -4);
        i.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    }
    
#if 1
//    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"My" bundle:[NSBundle mainBundle]];
//    UIStoryboard *discoverStoryboard = [UIStoryboard storyboardWithName:@"Discover" bundle:[NSBundle mainBundle]];
    

    [self.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorGromRGBV(200, 200, 200)} forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorGromRGBV(79, 210, 148)} forState:UIControlStateSelected];
    
#endif
    
//    self.selectedIndex = 0;
//    self.selectedViewController = self.viewControllers[1];
//        self.tabBar.barTintColor = WhiteColor;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{


    NSInteger index = viewController.tabBarItem.tag;
    if (index == 2) {
        if (!USER_DEFAULTS_GET(@"UserOpenIdent")) {
            FTHomeViewController *home = [[FTHomeViewController alloc] init];
            home.ispushVC = NO;
            NSString *url = _S(@"%@login.html",kFTWebUrl);
            home.url = url;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:home];
            [self presentViewController:nav animated:YES completion:nil];
            return NO;
        }
        
    }
    
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}


@end
