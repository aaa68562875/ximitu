//
//  FTBaseRemoteDAO.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>
///**** 网络交互模式 ****
enum FTRequestType {
    FTRequestTypeJSON = 201,
    FTRequestTypeXML,
    FTRequestTypeImage,
    FTRequestTypeDownLoad,
    FTRequestTypePropertyList,
};

@protocol FTBaseRemoteDAODelegate;

@interface FTBaseRemoteDAO : NSObject

@property(nonatomic, weak) id<FTBaseRemoteDAODelegate> delegate;

/**
 请求数据的基本模式，子路径加参数
 */
- (void)fetchDataWithPath:(NSString *)path parameters:(NSDictionary *)params andMethod:(NSString *)method;

/**
 *传输图片
 */
- (void)fetchDataWithPath:(NSString *)path
               parameters:(NSDictionary *)params
              requestType:(int)requestType andMethod:(NSString *)method;

/**
 接受数据的基本模式，用request判断请求类型，对象JSON封装返回的数据
 */
- (void)didReceiveJSONResponse:(id)JSON forRequest:(NSString *)request;
/**
 封装一些公用的键值对
 */
- (NSMutableDictionary *)basicHTTPParameters;
/**
 检查网络连接状态
 */
- (int)checkConnectionStatus;

- (void)cancelCurrentRequest;

- (void)cancelRequestWithMethod:(NSString *)method path:(NSString *)path;

@end

//协议
@protocol FTBaseRemoteDAODelegate <NSObject>
/**
 BL层从DAO层获取返回正确数据的接口
 */
- (void)didGetJSONResponse:(id)JSON forRequest:(NSString *)request;
/**
 网络连接错误时的数据返回接口
 */
- (void)connectionFail;

@end
