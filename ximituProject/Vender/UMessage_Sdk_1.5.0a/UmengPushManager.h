//
//  UmengPushManager.h
//  network
//
//  Created by myxgou on 16/7/28.
//  Copyright © 2016年 techinone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UmengPushManager : NSObject
+ (void)registerUmengPushWithKey:(NSString *)key launchOptions:(NSDictionary *)launchOptions;
+ (void)registerDeviceTokenWithData:(NSData *)data;
+ (void)openUmengPush;
+ (void)closeUmengPush;
+ (void)addAlians:(NSString *)alias response:(void(^)(id responseObject, NSError *error))response;
+ (void)removeAlians:(NSString *)alias response:(void(^)(id responseObject, NSError *error))response;
@end
