//
//  FTBaseBL.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTHTTPClient.h"
#import "DCKeyValueObjectMapping.h"

///网络连接状态码
enum networkStatusCode {
    kLoadSuccess = 1,
    kSessionInvalid = 1003,
};
@protocol FTBaseBLDelegate;
@interface FTBaseBL : NSObject <FTBaseRemoteDAODelegate>

@property(nonatomic, weak) id<FTBaseBLDelegate> delegate;
@property(nonatomic, strong) FTBaseRemoteDAO *remoteDao;

/**
 把字典型网络数据映射为core data对象
 */
- (BOOL)reflectDictionary:(NSDictionary *)dic
          toManagedObject:(NSString *)entityName;

/**
 把数组型网络数据映射为core data对象
 */
- (BOOL)reflectArray:(NSArray *)arr toManagedObject:(NSString *)entityName;
/**
 批量增加数据库数据并读出
 */
- (NSArray *)addManagedObject:(NSString *)entityName
                    withArray:(NSArray *)arr
                    predicate:(NSString *)pre
               sortDescriptor:(NSSortDescriptor *)descriptor;

/**
 批量更新数据库中的数据
 */
- (NSArray *)updateManagedObject:(NSString *)entityName
                       withArray:(NSArray *)arr
                       predicate:(NSString *)pre
                  sortDescriptor:(NSSortDescriptor *)descriptor;

/**
 单独更新数据库中的数据
 */
- (NSArray *)updateManagedObject:(NSString *)entityName
                  withDictionary:(NSDictionary *)dic
                       predicate:(NSString *)pre;

/**
 用某个类将网络数据解析为数组
 */
- (NSArray *)parseArray:(NSArray *)arr withClass:(NSString *)className;

/**
 用某个类将网络数据解析为字典
 */
- (NSDictionary *)parseDictionary:(NSDictionary *)dic
                        withClass:(NSString *)className;

/**
 *  处理网络异常数据
 */
- (void)processJSONResponse:(id)JSON forRequest:(NSString *)request;
@end

@protocol FTBaseBLDelegate <NSObject>
@optional
/**
 *  网络连接正常且服务器返回数据正确时调用这个方法传递数据给表现层
 */
- (void)didReceiveProcessedResponse:(id)JSON forRequest:(NSString *)request;

- (void)didReceiveCompleteBlock:(void (^)(BOOL success, NSDictionary *response,
                                          NSError *error))aBLock;

/**
 *  异常情况处理的用户提示
 */
- (void)showHUDWithText:(NSString *)text;

/**
 * 载入等待中
 */
- (void)showLoadingHUD;
- (void)showGifLoading;
/**
 * 隐藏掉HUD
 */
- (void)hideHUD;
- (void)hideGifLoading;
/**
 * 显示网络连接失败的界面
 */
- (void)showConnectionFailureView;

- (void)hideConnectionFailureView;
@end
