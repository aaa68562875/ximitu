//
//  FTMyAccountBL.m
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/6/29.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "FTMyAccountBL.h"
#import "MD5Encryption.h"
@implementation FTMyAccountBL


-(void)getUserInfo {
    [self.remoteDao fetchDataWithPath:kFTConsumerInfo parameters:@{} andMethod:@"GET"];
}


//重写父类，必写
- (void)processJSONResponse:(id)JSON
                 forRequest:(NSString *)request{

    id obj = nil;
    
    if (obj == nil) {
        obj = JSON;
    }
    
    [self.delegate didReceiveProcessedResponse:obj forRequest:request];
}

@end
