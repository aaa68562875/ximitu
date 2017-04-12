//
//  FTGuideView.h
//  XingSiluSend
//
//  Created by zlc on 15/11/28.
//  Copyright © 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FTGuideViewDelegate <NSObject>

- (void)removeView:(UIView *)view;

@end

@interface FTGuideView : UIScrollView<UIScrollViewDelegate>
/**
 *  引导页代理
 */
@property (nonatomic,weak) id<FTGuideViewDelegate> guideDelegate;

@end

