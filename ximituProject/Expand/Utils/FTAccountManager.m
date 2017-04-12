//
//  FTAccountManager.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTAccountManager.h"
#import "FTBaseBL.h"
#import "FTHTTPClient.h"
#import "FTUserBL.h"
#import "SFHFKeychainUtils.h"
#import "FTVersionManager.h"
//#im
@interface FTAccountManager()<FTBaseBLDelegate>

@property(nonatomic,strong)FTUserBL *userBL;
//@property(nonatomic,strong)FTThirdLoginBL *thirdUserBL;

@end
@implementation FTAccountManager

+ (FTAccountManager *)sharedManager {
    static FTAccountManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[FTAccountManager alloc] init];
        _sharedManager.user = [[FTUser alloc]init];
        //        _sharedManager.third = [[FTThirdLogin alloc]init];
        
        /**
         *  如果有上次的记录
         */
        _sharedManager.isUser=NO;
    });
    return _sharedManager;
}

- (void)login
{
    /**
     *  默认登录模式如果有记录上次登录，则从读取上次登录的记录
     */
    if ([self defaultUserIsAvailable]) {
        
        //        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"login_way"];
        
        self.user.userId=USER_DEFAULTS_GET(@"UID");
        self.user.password=[self getPasswordByUserName:self.user.userId];
        [self loginWithUser:self.user];
        
    }else{
        
        //自定登录失败
        [[NSNotificationCenter defaultCenter]postNotificationName:kFTAutoLoginLoginFailure object:nil userInfo:nil];
    }
}

//-(void)thirdLogin
//{
//    /**
//     *  默认登录模式如果有记录上次登录，则从读取上次登录的记录
//     */
//    if ([self defaultThirdUserIsAvailable]) {
//
//        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"login_way"];
//
//
//        self.third.uid=USER_DEFAULTS_GET(@"UID");
//        self.third.platform =USER_DEFAULTS_GET(@"PLAT");
//        self.third.nickname =USER_DEFAULTS_GET(@"NICK");
//        self.third.portrait =USER_DEFAULTS_GET(@"PORT");
//        [self ThirdLoginWithUser:self.third];
//
//
//    }else{
//
//        //自定登录失败
//        [[NSNotificationCenter defaultCenter]postNotificationName:kFTAutoLoginLoginFailure object:nil userInfo:nil];
//    }
//
//
//}
- (void)logout
{
    __block FTHTTPClient *client=[FTHTTPClient shareClient];
    //[client clearAuthorizationHeader];
    /**
     *  清除所有的session
     */
    NSString *baseURL = USER_DEFAULTS_GET(@"URL");
    NSString *basePort = USER_DEFAULTS_GET(@"PORT");
    if (![baseURL isString]) {
        baseURL = kFTBaseURL;
    }
    if (![basePort isString]) {
        basePort = kFTBasePort;
    }
    if (self.userBL == nil) {
        _userBL = [[FTUserBL alloc] init];
        
    }
#if 1
    //登录接口未写，用于退出登录
    client = nil;
    self.isUser = NO;
    self.userInfo = nil;
    USER_DEFAULTS_SET(@"0", @"LOGIN");
    [[NSNotificationCenter defaultCenter] postNotificationName:kFTLogoutSuccess object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kFTLoginStateChanged object:nil userInfo:nil];
#endif
#if 0
    _userBL.delegate = self;
    [_userBL logoutWithUsername:@"" usingBlock:^(BOOL success) {
        NSString *combinedUrl = [NSString stringWithFormat:@"http://%@:%@/",baseURL,basePort];
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:combinedUrl]];
        for (NSHTTPCookie *cookie in cookies)
        {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
        
        client = nil;
        self.isUser = NO;
        self.userInfo = nil;
        USER_DEFAULTS_SET(@"0", @"LOGIN");
        [[NSNotificationCenter defaultCenter] postNotificationName:kFTLogoutSuccess object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kFTLoginStateChanged object:nil userInfo:nil];
    }];
    
#endif
    
    
    
    
}

- (void)loginWithUser:(FTUser *)aUser
{
    ///每次重新认证的时候把之前的client注销
    FTHTTPClient *client=[FTHTTPClient shareClient];
    client=nil;
    if (self.userBL==nil) {
        self.userBL=[[FTUserBL alloc]init];
    }
    self.userBL.delegate = self;
    [self.userBL loginWithUser:aUser usingBlock:^(NSDictionary *userDic) {
//        NSLog(@"%@",userDic);
        /**
         获取到返回的用户详情数据,类似获取token
         */
        self.userInfo = userDic;
        self.isUser = YES;
        self.user.userId = aUser.userId;
        self.user.password = aUser.password;
        USER_DEFAULTS_SET(aUser.userId, @"UID");
    
        /**
         *  密码保存到keychain
         */
        [self saveUser:aUser];
        USER_DEFAULTS_SET(@"1", @"LOGIN");
        [[NSNotificationCenter defaultCenter]postNotificationName:kFTLoginSuccess object:nil userInfo:userDic];
        [[NSNotificationCenter defaultCenter]postNotificationName:kFTLoginStateChanged object:nil userInfo:nil];
    }];
}

//- (void)ThirdLoginWithUser:(FTThirdLogin *)thirdUser
//{
//    //每次重新认证的时候把之前的client注销
//    FTHTTPClient *client=[FTHTTPClient shareClient];
//    client=nil;
//    if (self.thirdUserBL==nil) {
//        self.thirdUserBL=[[FTThirdLoginBL alloc]init];
//    }
//    self.thirdUserBL.delegate=self;
//
//
//    [self.thirdUserBL thirdLoginWith:thirdUser usingBlock:^(NSDictionary *thirdLoginDic) {
//        //获取到返回的用户详情数据
//        self.userInfo = thirdLoginDic;
//        self.isUser = YES;
//        self.third.uid=thirdUser.uid;
//        self.third.platform = thirdUser.platform;
//        self.third.nickname = thirdUser.nickname;
//        self.third.portrait = thirdUser.portrait;
//        USER_DEFAULTS_SET(thirdUser.uid, @"UID");
//        USER_DEFAULTS_SET(thirdUser.platform, @"PLAT");
//        USER_DEFAULTS_SET(thirdUser.nickname, @"NICK");
//        USER_DEFAULTS_SET(thirdUser.portrait, @"PORT");
//
//        [self saveThirdUser:thirdUser];
//        USER_DEFAULTS_SET(@"1", @"LOGIN");
//        [[NSNotificationCenter defaultCenter]postNotificationName:kFTLoginSuccess object:nil userInfo:thirdLoginDic];
//        [[NSNotificationCenter defaultCenter]postNotificationName:kFTLoginStateChanged object:nil userInfo:nil];
//
//    }];
//
//
//}


- (FTUser *)defaultUser
{
    FTUser *user = [[FTUser alloc]init];
    user.userId=USER_DEFAULTS_GET(@"UID");
    user.password=[self getPasswordByUserName:user.userId];
    return user;
}
//- (FTThirdLogin *)defaultThirdUser
//{
//    FTThirdLogin *third = [[FTThirdLogin alloc]init];
//    third.uid = USER_DEFAULTS_GET(@"UID");
//    third.platform =USER_DEFAULTS_GET(@"PLAT");
//    third.nickname =USER_DEFAULTS_GET(@"NICK");
//    third.portrait =USER_DEFAULTS_GET(@"PORT");
//
//    return third;
//}
- (BOOL)defaultUserIsAvailable
{
    return [USER_DEFAULTS_GET(@"LOGIN")boolValue];
}
- (BOOL)defaultThirdUserIsAvailable
{
    return [USER_DEFAULTS_GET(@"LOGIN")boolValue];
}
- (void)clearDefaultUser
{
    [self deletePasswordByUserName:USER_DEFAULTS_GET(@"UID")];
    USER_DEFAULTS_SET(nil, @"UID");
}

- (BOOL)saveUser:(FTUser *)user
{
    NSError *error = nil;
    [SFHFKeychainUtils storeUsername:user.userId andPassword:user.password forServiceName:[[FTVersionManager sharedManager] appName] updateExisting:YES error:&error];
    if (error) {
        DLog(@"keychain保存失败 %@",error);
        return NO;
    }
    return YES;
}

//- (BOOL)saveThirdUser:(FTThirdLogin *)thirdUser
//{
//    NSError *error = nil;
//    [SFHFKeychainUtils storeUsername:thirdUser.uid andPassword:thirdUser.nickname forServiceName:[[FTVersionManager sharedManager] appName] updateExisting:YES error:&error];
//    if (error) {
//        DLog(@"keychain保存失败 %@",error);
//        return NO;
//    }
//    return YES;
//}

- (BOOL)deletePasswordByUserName:(NSString *)userName
{
    NSError *error = nil;
    [SFHFKeychainUtils deleteItemForUsername:userName andServiceName:[[FTVersionManager sharedManager] appName] error:&error];
    if (error) {
        DLog(@"keychain保存失败 %@",error);
        return NO;
    }
    return YES;
}

- (NSString *)getPasswordByUserName:(NSString *)userName
{
    NSError *error = nil;
    return [SFHFKeychainUtils getPasswordForUsername:userName andServiceName:[[FTVersionManager sharedManager] appName] error:&error];
    
}


@end
