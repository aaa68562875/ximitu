//
//  FTNetworkChecker.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTNetworkChecker.h"

static FTNetworkChecker *_checker = nil;

@implementation FTNetworkChecker

@synthesize hostName;

+ (FTNetworkChecker *)checker {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _checker = [[FTNetworkChecker alloc] init];
        
    });
    return _checker;
}

- (int)checkForNetworkConnection
{
    Reachability *r = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    return [r currentReachabilityStatus];
}

@end
