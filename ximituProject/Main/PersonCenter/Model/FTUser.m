//
//  FTUser.m
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/6/29.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "FTUser.h"

@implementation FTUser

- (id)initWithUserId:(NSString *)uid password:(NSString *)pw
{
    if (self=[super init]) {
        self.userId = uid;
        self.password = pw;
    }
    return self;
}

@end
