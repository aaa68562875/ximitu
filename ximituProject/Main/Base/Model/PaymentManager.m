//
//  PaymentManager.m
//  Yanwei
//
//  Created by peter on 15/10/11.
//  Copyright © 2015年 DCloud. All rights reserved.
//

#import "PaymentManager.h"

#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import <SVProgressHUD.h>
#import <MBProgressHUD.h>

//alipay util
#import "Order.h"
#import "DataSigner.h"
#define AlipaySignURL @"http://tchy.pay.nat123.net/payControl/payment?payid=ali"

@interface PaymentManager ()
@end

@implementation PaymentManager

+ (BOOL)wechatPayWithPaymentInfo:(WXPayDataModel *)paymentInfo {
    
//   
//    if (![WXApi isWXAppInstalled]) {
//        Fail(@"你还没安装微信客户端");
//        return NO;
//    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
    {
        NSLog(@"OK weixin://");
    }else {
        NSLog(@"no weixin://");
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [WXApi registerApp:paymentInfo.appid];
    });
    
    
//    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
//    [req init:WechatPayKey mch_id:WechatMchId];
//    //设置密钥
//    [req setKey:WechatParterID];
////    价格单位必须是分
//    NSString *price = [NSString converNumber:@((int)(paymentInfo.price * 100))];
//    NSMutableDictionary *dict = [req sendPayWithTitle:paymentInfo.description price:price];
//    
//    if(dict == nil){
//        //错误提示
//        NSString *debug = [req getDebugifo];
//        
//        NSLog(@"%@\n\n",debug);
//    }
//    else {
//        NSLog(@"%@\n\n",[req getDebugifo]);
//        
//        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//        
//        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = paymentInfo.appid;
        req.partnerId           = paymentInfo.partnerid;
        req.prepayId            = paymentInfo.prepayid;
        req.nonceStr            = paymentInfo.noncestr;
        req.timeStamp      = (UInt32)[paymentInfo.timestamp longLongValue];
        req.package         = paymentInfo.package;
        req.sign                = paymentInfo.sign;
        
        BOOL statue = [WXApi sendReq:req];
    return statue;
//    }
}

+ (void)alipayWithPaymentInfo:(NSString *)sign payResultCallBack:(void(^)(BOOL))callBack {
    NSString *appScheme = @"tianFuShop";
    
//    Order *order = [[Order alloc] init];
//    order.partner = AlipayPartner;
//    order.seller = AlipaySeller;
//    order.amount = [NSString stringWithFormat:@"%.2f",11.11];
//    order.productName = @"预约乘车费用";
//    order.productDescription = @"sdafads";
//    order.notifyURL = AlipayNotifyUrl;
//    order.service = @"mobile.securitypay.pay";
//    order.tradeNO =@"asdfadsfsfads1123123";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    id<DataSigner> signer = CreateRSADataSigner(AlipayPrivateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    NSLog(@"signedString:%@",signedString);
//    assert(signedString);
//    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                             orderSpec, signedString, @"RSA"];
////
//    
//    NSData *requestData = [NSData dataWithContentsOfURL:[NSURL URLWithString:AlipaySignURL]];
//    NSString *alipaySign = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
    [[AlipaySDK defaultService] payOrder:sign fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        //        9000
        //        订单支付成功
        //        8000
        //        正在处理中
        //        4000
        //        订单支付失败
        //        6001
        //        用户中途取消
        //        6002
        //        网络异常
        int status = [resultDic[@"resultStatus"] intValue];
        switch (status) {
            case 9000: {
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                if(callBack) {
                    callBack(YES);
                }
                return;
                break;
            }
            case 8000:
                [SVProgressHUD showErrorWithStatus:@"正在处理中"];
                break;
            case 4000:
                [SVProgressHUD showErrorWithStatus:@"订单支付失败"];
                break;
            case 6001:
                [SVProgressHUD showErrorWithStatus:@"取消操作"];
                break;
            case 6002:
                [SVProgressHUD showErrorWithStatus:@"网络异常"];
                break;
            default:
                break;
        }
        if(callBack) {
            callBack(NO);
        }
    }];
}

@end
