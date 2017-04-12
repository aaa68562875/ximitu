//
//  FTBaseManager.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTBaseManager.h"

@implementation FTBaseManager


- (void)showHUDWithText:(NSString *)text
{
    [self.delegate showHUDWithText:text];
}

- (void)showLoadingHUD
{
    [self.delegate showLoadingHUD];
}

- (void)showGifLoading{
    [self.delegate showGifLoading];
}

- (void)hideHUD
{
    [self.delegate hideHUD];
}

- (void)hideGifLoading{
    [self.delegate hideGifLoading];
}

- (void)showConnectionFailureView
{
    [self.delegate showConnectionFailureView];
}

- (void)hideConnectionFailureView
{
    [self.delegate hideConnectionFailureView];
}


@end
