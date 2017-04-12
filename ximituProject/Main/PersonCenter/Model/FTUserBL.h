//
//  FTUserBL.h
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/6/29.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "FTBaseBL.h"

#import "FTUser.h"
typedef void (^LoginBlock)(NSDictionary *userDic);
typedef void (^LogoutBlock)(BOOL success);

@interface FTUserBL : FTBaseBL {
    
    LoginBlock loginSuccess;
    LogoutBlock logoutSuccess;
}

- (void)loginWithUser:(FTUser *)user usingBlock:(LoginBlock)block;

- (void)logoutWithUsername:(NSString *)username usingBlock:(LogoutBlock)block;

- (BOOL)saveUserToKeyChain:(FTUser *)user;

- (id)getUserFromKeyChain;

- (void)deleteUserFromKeyChain;

- (void)saveUserToUserDefault:(FTUser *)user;

- (id)getUserFromUserDefault;@end
