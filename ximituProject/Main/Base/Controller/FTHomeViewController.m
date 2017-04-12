//
//  FTHomeViewController.m
//  XingsiluOwner
//
//  Created by peter on 2016/12/15.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "FTHomeViewController.h"
#import "FTBaseWebViewController.h"

@interface FTHomeViewController ()
@property (strong, nonatomic)  UIWebView * webView;
@property (strong, nonatomic) FTBaseWebViewController *web;
@end

@implementation FTHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebViewController];
}

- (void)initWebViewController {
    
    _web = [[FTBaseWebViewController alloc] init];
    //    _web.webUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]];
    
    if (self.ispushVC) {
        _web.isPush = YES;
    }else {
        _web.isPush = NO;
    }
    _web.webUrl = self.url;
    
    if (self.isMineIntoOrder) {
        _web.isMine = YES;
    }else {
        _web.isMine = NO;
    }
    
    [self addChildViewController:_web];
    [self.view addSubview:_web.view];
}
@end
