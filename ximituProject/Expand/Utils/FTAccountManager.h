//
//  FTAccountManager.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTBaseManager.h"
#import "FTUser.h"


@interface FTAccountManager : FTBaseManager



/**
 基本账户信息
 */
@property (nonatomic, strong) FTUser *user;

//@property (nonatomic, strong) FTThirdLogin *third;
/**
 用户信息
 */
@property (nonatomic, strong) NSDictionary *userInfo;

@property (nonatomic, strong) NSDictionary *thirdUserInfo;

@property (strong, nonatomic) NSDictionary *dicInfo;

/**
 是否用户
 */
@property (nonatomic, assign) BOOL isUser;


@property (strong, nonatomic) NSString *openIdent;

+ (FTAccountManager *)sharedManager;
/**
 发起自动登录流程
 */
- (void)login;

//- (void)thirdLogin;

/**
 发起手动登录流程
 */
- (void)loginWithUser:(FTUser *)aUser;

//- (void)ThirdLoginWithUser:(FTThirdLogin *)thirdUser;

/**
 发起注销流程
 */
- (void)logout;
/**
 检测默认账户
 */
- (BOOL)defaultUserIsAvailable;

- (BOOL)defaultThirdUserIsAvailable;


/** 微信支付回调类型 */
@property (assign, nonatomic) NSInteger payType;


/**
 获取默认账户
 */
- (FTUser *)defaultUser;

//- (FTThirdLogin *)defaultThirdUser;

/**
 清除默认账户
 */
- (void)clearDefaultUser;

- (BOOL)saveUser:(FTUser *)user;

//- (BOOL)saveThirdUser:(FTThirdLogin *)thirdUser;


- (BOOL)deletePasswordByUserName:(NSString *)userName;

- (NSString *)getPasswordByUserName:(NSString *)userName;

@end
