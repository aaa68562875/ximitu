//
//  FTVersionManager.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//
/**
 *  @模块名称    版本管理者
 *  @功能说明    应用版本信息
 *  @模块版本    1.0.0.0 （适用底层功能模块）
 */
#import <Foundation/Foundation.h>

@interface FTVersionManager : NSObject
+ (FTVersionManager *)sharedManager;
/**
 查看本机当前版本信息
 */
- (NSString *)currentVersion;

/**
 *  获取appName
 */
- (NSString *)appName;

@end
