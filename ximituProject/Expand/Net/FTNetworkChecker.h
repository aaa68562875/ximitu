//
//  FTNetworkChecker.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface FTNetworkChecker : NSObject


@property (nonatomic,copy) NSString *hostName;

+ (FTNetworkChecker *)checker;

- (int)checkForNetworkConnection;

@end
