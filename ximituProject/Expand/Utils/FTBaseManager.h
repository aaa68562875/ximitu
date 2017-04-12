//
//  FTBaseManager.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTEntity.h"

@protocol FTBaseManagerDelegate;

@interface FTBaseManager : FTEntity


@property(nonatomic,weak)id<FTBaseManagerDelegate>delegate;


@end


@protocol FTBaseManagerDelegate <NSObject>

- (void)showHUDWithText:(NSString *)text;

- (void)showLoadingHUD;

- (void)showGifLoading;

- (void)hideHUD;

- (void)hideGifLoading;

- (void)showConnectionFailureView;

- (void)hideConnectionFailureView;

- (void)didReceiveNewVersion:(BOOL)isNew withInfo:(NSDictionary *)info;
@end