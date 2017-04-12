//
//  FTBaseWebViewController.h
//  new
//
//  Created by 王知 on 2016/11/28.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "FTBaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@protocol htmlDelegate <JSExport>


- (void)app:(NSString *)string;

//返回用户信息到js
- (NSString *)getUserInfo;

- (void)saveOpenIdent:(NSString *)openIdent;

@end

@interface FTBaseWebViewController : FTBaseViewController<htmlDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_search;
    BMKReverseGeoCodeOption *option;
}

/**
    web链接
 */
@property (strong, nonatomic)  NSString * webUrl;


/**
    上下文
 */
@property (strong, nonatomic)  JSContext * jsContext;


/**
    webview
 */
@property (strong, nonatomic)  UIWebView * webView;


/**
 oc与web之间的桥梁
 */
@property (strong, nonatomic)  NSString * bridge;


/**
 当前viewcontroller
 */
@property (strong, nonatomic) UIViewController *viewController;

/**
 图片data
 */
@property (strong, nonatomic) NSData *imageData;


/**
 图片路径
 */
@property (strong, nonatomic) NSString *imagePath;


/**
 图片回调js方法名
 */
@property (strong, nonatomic) NSString *imageCallBack;

 
/**
 模态切换的控制器
 */
@property (strong, nonatomic)  UIViewController * presentController;


/**
 返回到哪一层的controller
 */
@property (strong, nonatomic)  UIViewController * backWhichViewController;



@property (assign, nonatomic) BOOL isPush;

/** 从我的进入订单页面 */
@property (assign, nonatomic) BOOL isMine;


/**
 定位成功后
 */
@property (assign, nonatomic) CLLocationCoordinate2D coordinate2D;


/**
 定位成功后反编码的地址
 */
@property (strong, nonatomic) BMKAddressComponent *address;


/**
 打开相机，照片
 */
- (void)openCameraOrPhoto;


/**
 拨打电话

 @param phoneNumber 号码
 */
- (void)call:(NSString *)phoneNumber;


/**
 上传图片
 */
- (void)uploadImage;




@end
