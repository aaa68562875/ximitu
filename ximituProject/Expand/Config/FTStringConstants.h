//
//  FTStringConstants.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#ifndef MyFrame_FTStringConstants_h
#define MyFrame_FTStringConstants_h

#pragma mark - 系统内部信息


#define kFTLoginStateChanged @"FTLoginStateChanged"
#define kFTReachabilityStateChanged @"FTReachabilityStateChanged"
#define kFTLoginSuccess @"FTLoginSuccess"
#define kFTLogoutSuccess @"FTLogoutSuccess"
#define kFTAutoLoginLoginFailure @"FTAutoLoginLoginFailure"
#pragma mark - 弹出用户提示信息


#define kFTConnectionNotReachable @"无法连接，请开启手机网络"
#define kFTConnectionViaWWAN @"连入数据网络"
#define kFTConnectionViaWifi @"连入无线wifi"
#define kFTUserAlertNetworkNotAvailable @"网络无法连接，请重试"
#define kFTUserAlertLoginFailed @"登录失败，请重新登录"
#define kFTUserAlertLoginOK @"登录成功"
#define kFTUserAlertLogoutOK @"注销成功"
#define kFTUserAlert3GNotice @"您当前正在3G状态下浏览，建议切换到wifi"
#define kFTUserAlertCanNotLoadMoreData @"没有更多"
#define kFTUserAlertSearchResultIsNone @"没有符合条件的内容"
#define kFTUserAlertLatestVersion @"当前已经是最新版本"
#define kFTUserAlertDeleteFromHomePage @"成功从主界面删除"
#define kFTUserAlertAddToHomePage @"成功添加到主界面"
#define kFTUserAlertAddToCalendar @"成功添加到本地日历"
#define kFTUserAlertAddToAddressBook @"成功添加到本地通讯录"
#define kFTUserAlertAddToReminder @"成功添加到提醒事项"

#define kFTUserAskLogout @"是否确认注销?"

#define kFTPlaceHolderImage @"headImage"

#endif
