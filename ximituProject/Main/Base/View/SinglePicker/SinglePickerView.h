//
//  SinglePickerView.h
//  XingsiluCloud
//
//  Created by Wanrongtong on 16/7/18.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^sendSelectRow)(NSInteger row);

@interface SinglePickerView : UIView


@property (nonatomic ,copy)sendSelectRow block;

- (instancetype)initAddressPickerView;

- (void)getData:(NSArray *)data;

- (void)handlerRowWithBlock:(sendSelectRow)block;

@end
