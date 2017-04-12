//
//  FTVersionManager.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTVersionManager.h"

@implementation FTVersionManager
+ (FTVersionManager *)sharedManager
{
    static FTVersionManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[FTVersionManager alloc] init];
    });
    return _sharedManager;
}

- (NSString *)currentVersion
{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    return versionNum;
}


- (NSString *)appName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

@end
