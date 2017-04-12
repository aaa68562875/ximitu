//
//  FTNetworkUtil.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTNetworkUtil.h"

@implementation FTNetworkUtil

+ (FTNetworkUtil *)sharedManager
{
    static FTNetworkUtil *_sharedNetManagerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNetManagerInstance = [[self alloc] init];
    });
    
    return _sharedNetManagerInstance;
}

- (id)init{
    if (self  =[super init]) {
        
    }
    return self;
}

//网络判断
- (void)reach
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == 0) {
            UIAlertView *notReachAlertView = [[UIAlertView alloc] initWithTitle:@"网络无连接，请检查网络" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [notReachAlertView show];
        }
    }];
}


@end
