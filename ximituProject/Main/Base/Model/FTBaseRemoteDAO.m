//
//  FTBaseRemoteDAO.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTBaseRemoteDAO.h"
#import "Reachability.h"
#import "FTNetworkQueue.h"
#import "FTHTTPClient.h"
#import "FTAccountManager.h"
@implementation FTBaseRemoteDAO
/**
 请求数据的基本模式，子路径加参数
 */
- (void)fetchDataWithPath:(NSString *)path parameters:(NSDictionary *)params andMethod:(NSString *)method{
    //    NSLog(@"---%@",params);
    if ([self checkConnectionStatus] == NotReachable) {
        /**
         *  网络不可连接时返回
         */
        return;
    }
    
    //显示网络风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    ///公共字段封装
    FTHTTPClient *client = [FTHTTPClient shareClient];
    if (params == nil) {
        [client requestWithPath:path
                     parameters:[self basicHTTPParameters]
                            dao:self andMethod:method];
    } else {
        NSMutableDictionary *dict =
        [NSMutableDictionary dictionaryWithDictionary:params];
        [dict addEntriesFromDictionary:[self basicHTTPParameters]];
        [client requestWithPath:path parameters:dict dao:self andMethod:method];
    }
}
/**
 * 上传图片
 */
- (void)fetchDataWithPath:(NSString *)path
               parameters:(NSDictionary *)params
              requestType:(int)requestType andMethod:(NSString *)method{
    if ([self checkConnectionStatus] == NotReachable) {
        /**
         *  网络不可连接时返回
         */
        return;
    }
    
    //显示网络风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    ///公共字段封装
    FTHTTPClient *client = [FTHTTPClient shareClient];
    if (params == nil) {
        [client requestWithPath:path
                     parameters:[self basicHTTPParameters]
                            dao:self andMethod:method];
    } else {
        NSMutableDictionary *dict =
        [NSMutableDictionary dictionaryWithDictionary:params];
        [dict addEntriesFromDictionary:[self basicHTTPParameters]];
        [client requestWithMethod:@"POST"
                             path:path
                       targetPath:nil
                       parameters:params
                              dao:self
                             type:requestType];
    }
}
/**
 封装一些公用的键值对
 */
- (NSMutableDictionary *)basicHTTPParameters {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    if (USER_DEFAULTS_GET(@"UserOpenIdent")) {
       [dic setValue:USER_DEFAULTS_GET(@"UserOpenIdent") forKey:@"openIdent"];
    }else {
        [dic setValue:@"" forKey:@"openIdent"];
    }
//    if ([FTAccountManager sharedManager].openIdent.length) {
//        
//    }else {
//        [dic setValue:@"" forKey:@"openIdent"];
//    }
    
    return dic;
}

/**
 检查网络连接状态
 */
- (int)checkConnectionStatus {
    Reachability *r = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    NSInteger reachabililtyStatus = [r currentReachabilityStatus];
    if (reachabililtyStatus == NotReachable) {
        ///网络无法连接时，提示网络不可用处理流程
        [self.delegate connectionFail];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kFTConnectionNotReachable
         object:nil];
    }
    /// 3G网络和wifi的操作在这里做,根据网络状态的不同
    if (reachabililtyStatus == ReachableViaWWAN) {
        [[FTNetworkQueue shareQueue] setMaxConcurrentOperationCount:2];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kFTConnectionViaWWAN
         object:nil];
    }
    if (reachabililtyStatus == ReachableViaWiFi) {
        [[FTNetworkQueue shareQueue] setMaxConcurrentOperationCount:6];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kFTConnectionViaWifi
         object:nil];
    }
    return (int)reachabililtyStatus;
}

- (void)cancelCurrentRequest {
}

- (void)cancelRequestWithMethod:(NSString *)method path:(NSString *)path {
}

/// dao返回的数据全部直接回调到BL层，在BL层处理
- (void)didReceiveJSONResponse:(id)JSON forRequest:(NSString *)request {
    //    if ([request isEqualToString:kFTSendDeviceToken]) {
    //        NSLog(@"信鸽DeviceToken send ---- %@",JSON[@"message"]);
    //    }
    
    [self.delegate didGetJSONResponse:JSON forRequest:request];
}

@end
