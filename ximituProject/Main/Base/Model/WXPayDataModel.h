//
//  WXPayDataModel.h
//  Yanwei
//
//  Created by peter on 15/11/5.
//  Copyright © 2015年 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
/**
    {"sign":"487C592B5A02AB1F8284DBC2BE4697B2","timestamp":"1446702741","noncestr":"qEIiHtTyF5THDUwh","partnerid":"1276850101","prepayid":"wx2015110513525151efdff0110762596592","package":"Sign\u003dWXPay","appid":"wxf290810f0b3b638c"}
 */

@interface WXPayDataModel : JSONModel
@property(nonatomic, strong) NSString *sign;
@property(nonatomic, strong) NSString *timestamp;
@property(nonatomic, strong) NSString *noncestr;
@property(nonatomic, strong) NSString *partnerid;
@property(nonatomic, strong) NSString *prepayid;
@property(nonatomic, strong) NSString *package;
@property(nonatomic, strong) NSString *appid;
@end
