//
//  ZSegmentScrollView.h
//  ZSegmentControl
//
//  Created by Wanrongtong on 16/6/12.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSegmentView.h"

typedef void(^IndexBlock)(NSInteger index);

@interface ZSegmentScrollView : UIView


@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) IndexBlock block;



- (instancetype)initWithFrame:(CGRect)frame
                  titleArray:(NSArray *)titleArray
            contentViewArray:(NSArray *)contentViewArray
            hideSegmentValue:(BOOL)segHide
             hidePageControl:(BOOL)pageCtrlHide
                scrollEnabled:(BOOL)scroll
                   IndexBlock:(IndexBlock)block;

@end
