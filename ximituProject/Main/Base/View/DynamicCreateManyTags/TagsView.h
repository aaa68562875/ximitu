//
//  TagsView.h
//  TagsDemo
//
//  Created by Administrator on 16/1/21.
//  Copyright © 2016年 Administrator. All rights reserved.
//
/**
 *  动态创建多个标签，单选、多选
 */
#import <UIKit/UIKit.h>
#import "TagsFrame.h"
#import "NSArray+Common.h"
typedef void(^LabelClickBlcok)(NSArray *array);

@interface TagsView : UIView

- (instancetype)initWithFrame:(CGRect)frame andMultiSelect:(BOOL)isMultiSelect andHandleBlock:(LabelClickBlcok)block;

/**
 *  限制多选个数
 */
@property (nonatomic, assign) NSInteger limitNum;

@property (nonatomic, copy) LabelClickBlcok block;

@property (nonatomic, strong) TagsFrame *tagsFrame;



@end
