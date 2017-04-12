//
//  FTUserBL.m
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/6/29.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "FTUserBL.h"

#import "AppDelegate.h"
#import "MD5Encryption.h"
#import "FTMyAccountBL.h"

@implementation FTUserBL

- (void)loginWithUser:(FTUser *)user usingBlock:(LoginBlock)block {
    
    loginSuccess = block;
    NSDictionary *dic = [NSDictionary
                         dictionaryWithObjectsAndKeys:user.userId, @"login_name", [MD5Encryption md5:user.password],
                         @"password", nil];
    
    [self.delegate showLoadingHUD];
    
    [self.remoteDao fetchDataWithPath:kFTLogin parameters:dic andMethod:@""];
}

- (void)logoutWithUsername:(NSString *)username usingBlock:(LogoutBlock)block {
    logoutSuccess = block;
    NSDictionary *dic =@{@"token":USER_DEFAULTS_GET(@"token")};
    [self.delegate showLoadingHUD];
    [self.remoteDao fetchDataWithPath:kFTLogout parameters:dic andMethod:@""];
    
}


- (BOOL)saveUserToKeyChain:(FTUser *)user {
    
    return YES;
}
- (id)getUserFromKeyChain {
    return self;
}

- (void)deleteUserFromKeyChain {
}
- (id)getUserFromUserDefault {
    
    NSString *userid = USER_DEFAULTS_GET(@"UID");
    NSString *password = USER_DEFAULTS_GET(@"PWD");
    FTUser *user = [[FTUser alloc] initWithUserId:userid password:password];
    
    return user;
}
- (void)saveUserToUserDefault:(FTUser *)user {
    USER_DEFAULTS_SET(user.userId, @"UID");
    USER_DEFAULTS_SET(user.password, @"PWD");
}

#pragma mark - network process method

- (void)processJSONResponse:(id)JSON forRequest:(NSString *)request {
    
    if ([request isEqualToString:kFTLogin]) {
        ///做对象映射和数据处理
        ///数据返回成功
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            NSDictionary *userDic = [NSDictionary dictionaryWithDictionary:JSON];
            //存储token、userId
            NSString *token = [NSString stringWithFormat:@"%@", userDic[@"token"]];
            NSString *userId = [NSString stringWithFormat:@"%@", userDic[@"user"][@"id"]];
            NSString *headImgStr =
            [NSString stringWithFormat:@"%@", userDic[@"iconUrl"]];
            NSString *phone = [NSString stringWithFormat:@"%@",userDic[@"user"][@"mobile"]];
            
            USER_DEFAULTS_SET(token, @"token");        //保存用户token
            USER_DEFAULTS_SET(userId, @"userId");      //保存用户ID
            USER_DEFAULTS_SET(headImgStr, @"headImg"); //保存用户头像
            USER_DEFAULTS_SET(phone, @"phone"); //保存用户电话
            
            if (((NSString *)USER_DEFAULTS_GET(@"registrationID")).length != 0) {
                
            }else{
                
            }
            
            DLog(@"%@", userDic);
            loginSuccess(userDic);
            
        } else {
            
            
        }
    }else if ([request isEqualToString:kFTLogout]){
        USER_DEFAULTS_SET(@"", @"token");        //清空用户token
        USER_DEFAULTS_SET(@"", @"userId");       //清空用户ID
        USER_DEFAULTS_SET(@"", @"headImg");      //清空用户头像
        USER_DEFAULTS_SET(@"", @"phone");        //清空用户电话
        logoutSuccess(YES);
        NSLog(@"%@",JSON);
    }
    
    
    
    
    
}


@end
