//
//  BaseNavigationViewController.h
//  XingSiluSend
//
//  Created by zlc on 15/8/4.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTGuideView.h"
/**
 *  底层NavigationViewController  添加右滑返回手势
 */

@interface BaseNavigationViewController : UINavigationController

@property(nonatomic, assign)
    BOOL isSlideBack; //控制右滑手势  开YES
                      //关NO，在对应页面设置，离开对应页面需要设为YES开启



@end
