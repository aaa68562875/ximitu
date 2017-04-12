//
//  FTHTTPClient.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "FTBaseRemoteDAO.h"

@interface FTHTTPClient : AFHTTPSessionManager

+ (FTHTTPClient *)shareClient;

- (void)requestWithPath:(NSString *)path dao:(FTBaseRemoteDAO *)dao andMethod:(NSString *)method;

- (void)requestWithPath:(NSString *)path parameters:(NSDictionary *)params dao:(FTBaseRemoteDAO *)dao andMethod:(NSString *)method;

- (void)requestWithMethod:(NSString *)method path:(NSString *)path targetPath:(NSString *)target parameters:(NSDictionary *)params dao:(FTBaseRemoteDAO *)dao type:(int)requestType;

@end
