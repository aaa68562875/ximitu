//
//  FTMethodConstants.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#ifndef MyFrame_FTMethodConstants_h
#define MyFrame_FTMethodConstants_h

#pragma mark - 调试输出

// DLog displays output if DEBUG
#ifdef DEBUG
#ifndef DLog
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#endif
#ifndef ELog
#   define ELog(err) {if(err) DLog(@"%@", err)}
#endif
#else
#ifndef DLog
#   define DLog(...)
#endif
#ifndef ELog
#   define ELog(err)
#endif
#endif

#endif

#pragma mark - 设置userDefault的value

#define USER_DEFAULTS_SET(__OBJECT,__KEY) {\
[[NSUserDefaults standardUserDefaults] setObject:__OBJECT forKey:__KEY];\
[[NSUserDefaults standardUserDefaults] synchronize];}

#pragma mark - 获取userDefault的value

#define USER_DEFAULTS_GET(__KEY) ([[NSUserDefaults standardUserDefaults] objectForKey:__KEY])

#pragma mark - 删除userDefault的value

//隐藏键盘
#define HIDE_KEYBOARD() [[[UIApplication sharedApplication] keyWindow] endEditing:YES]

#define USER_DEFAULTS_DELETE(__KEY) ([[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY])
#define Load(string) [SVProgressHUD showWithStatus:string]
#define Diss [SVProgressHUD dismiss]
#define Sucess(string) [SVProgressHUD showSuccessWithStatus:string]
#define Fail(string) [SVProgressHUD showErrorWithStatus:string]

#pragma mark Judge
// Judge whether it is an empty string.
#define IsEmptyString(s) (s == nil || [s isKindOfClass:[NSNull class]] || ([s isKindOfClass:[NSString class]] && s.length == 0))

// Judge whether it is a nil or null object.
#define IsEmptyObject(obj) (obj == nil || [obj isKindOfClass:[NSNull class]])

// Judge whether it is a vaid dictionary.
#define IsDictionary(objDict) (objDict != nil && [objDict isKindOfClass:[NSDictionary class]])
