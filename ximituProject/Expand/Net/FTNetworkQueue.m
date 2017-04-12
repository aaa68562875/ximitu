//
//  CLNetworkQueue.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTNetworkQueue.h"


static FTNetworkQueue *_sharedQueue = nil;

@implementation FTNetworkQueue
+ (FTNetworkQueue *)shareQueue
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedQueue = [[FTNetworkQueue alloc] init];
    });
    //wifi网络状态下最大并发请求6个
    _sharedQueue.maxConcurrentOperationCount = 6;
    return _sharedQueue;
}

@end
