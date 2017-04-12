//
//  FTUser.h
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/6/29.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "FTEntity.h"

@interface FTUser : FTEntity

@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *password;
- (id)initWithUserId:(NSString *)uid password:(NSString *)pw;

@end
