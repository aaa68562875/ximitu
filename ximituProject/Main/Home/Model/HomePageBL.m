//
//  HomePageBL.m
//  FianFuShopping
//
//  Created by peter on 2017/3/7.
//  Copyright © 2017年 Wanrongtong. All rights reserved.
//

#import "HomePageBL.h"

@implementation HomePageBL



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
