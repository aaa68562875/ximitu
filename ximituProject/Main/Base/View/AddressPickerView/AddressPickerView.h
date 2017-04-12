//
//  AddressPickerView.h
//  ChinaSelect
//
//  Created by Wanrongtong on 16/6/23.
//  Copyright © 2016年 my. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  address picker view handler data
 *
 *  @param message address string
 *  @param type    1-取消，2-确定,3-滑动传值
 */
typedef void(^sendAddressBlock)(NSString *message,NSString *type);

@interface AddressPickerView : UIView

@property (nonatomic,strong) sendAddressBlock block;

- (instancetype)initAddressPickerView;

- (void)HandlerMessageBlock:(sendAddressBlock)block;

@end
