//
//  FTErrorView.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//
/**
 *  提供error视图给网络请求出错时展现
 *  适用底层功能模块
 */
#import <UIKit/UIKit.h>
#import "IQUIView+Hierarchy.h"

@protocol FTErrorViewDelegate;
@interface FTErrorView : UIView

@property(nonatomic, assign) id<FTErrorViewDelegate> delegate;

@end

@protocol FTErrorViewDelegate <NSObject>

- (void)doHttpRequest;

@end