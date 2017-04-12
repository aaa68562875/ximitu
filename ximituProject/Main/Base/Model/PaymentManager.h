//
//  PaymentManager.h
//  Yanwei
//
//  Created by peter on 15/10/11.
//  Copyright © 2015年 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXPayDataModel.h"

@interface PaymentManager : NSObject
+ (void)alipayWithPaymentInfo:(NSString *)sign payResultCallBack:(void(^)(BOOL))callBack;
+ (BOOL)wechatPayWithPaymentInfo:(WXPayDataModel *)paymentInfo;
@end
