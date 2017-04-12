//
//  FTNetworkUtil.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"
@interface FTNetworkUtil : NSObject

+ (FTNetworkUtil *)sharedManager;

- (void)reach;

@end
