//
//  AppDelegate.h
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/6/7.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/**
 *  添加订单内部数据临时存储
 */
@property (strong, nonatomic) NSMutableDictionary *orderDict;

@property (strong, nonatomic)  JSValue *paytype;

@end

