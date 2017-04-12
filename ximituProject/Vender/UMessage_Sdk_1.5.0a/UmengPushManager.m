//
//  UmengPushManager.m
//  network
//
//  Created by myxgou on 16/7/28.
//  Copyright © 2016年 techinone. All rights reserved.
//

#import "UmengPushManager.h"
#import "UMessage.h"

@implementation UmengPushManager
+ (void)registerUmengPushWithKey:(NSString *)key launchOptions:(NSDictionary *)launchOptions {
    [UMessage startWithAppkey:key launchOptions:launchOptions];
    [UMessage setLogEnabled:YES];
}

+ (void)registerDeviceTokenWithData:(NSData *)data {
    [UMessage registerDeviceToken:data];
}

+ (void)openUmengPush {
    UIRemoteNotificationType types7 = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
    UIUserNotificationType types8 = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
    [UMessage registerForRemoteNotifications:nil withTypesForIos7:types7 withTypesForIos8:types8];
    
}

+ (void)closeUmengPush {
    [UMessage unregisterForRemoteNotifications];
}

+ (void)addAlians:(NSString *)alias response:(void(^)(id responseObject, NSError *error))response {
    [UMessage addAlias:alias type:@"XINXUN_CLIENT" response:response];
}

+ (void)removeAlians:(NSString *)alias response:(void(^)(id responseObject, NSError *error))response {
    [UMessage removeAlias:alias type:@"XINXUN_CLIENT" response:response];
}

@end
