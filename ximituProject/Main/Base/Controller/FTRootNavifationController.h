//
//  FTRootNavifationController.h
//  XingSiluSend
//  //右拉手势返回
//  http://code4app.com/ios/XXNavigation/531bce0d933bf08e3e8b68b0
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// window窗口
#define WINDOW [[UIApplication sharedApplication] keyWindow]
#define SCREEN_VIEW_WIDTH self.view.bounds.size.width
static const float kDurationTime = 0.3;
static const float kScaleValue = 0.95;
@interface FTRootNavifationController : UINavigationController {
  CGPoint startTouch; //拖动开始时位置
  BOOL isMoving;      //是否在拖动中

  UIView *blackMask;
  // The snapshot
  UIImageView *lastScreenShotView;
}
@property(nonatomic, retain) UIView *backgroundView;          //背景
@property(nonatomic, retain) NSMutableArray *screenShotsList; //存截
@end
