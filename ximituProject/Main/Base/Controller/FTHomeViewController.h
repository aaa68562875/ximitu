//
//  FTHomeViewController.h
//  XingsiluOwner
//
//  Created by peter on 2016/12/15.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "FTBaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface FTHomeViewController : FTBaseViewController

@property (strong, nonatomic)  JSContext * jsContext;
@property (strong, nonatomic) NSString *url;
@property (assign, nonatomic) BOOL ispushVC;

/** 从我的进入订单页面 */
@property (assign, nonatomic) BOOL isMineIntoOrder;

@end
