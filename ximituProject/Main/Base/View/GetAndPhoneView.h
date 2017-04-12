//
//  GetAndPhoneView.h
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/6/21.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//
/**
 *  用于物流详情页面的右上弹窗，可点击收藏和拨打物流商电话
 */
#import <UIKit/UIKit.h>
/**
 *  传递回去点击的是什么
 *
 *  @param type 1-->收藏 1-->打电话
 */
typedef void(^sendTypeBlock)(NSString *type);

@interface GetAndPhoneView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *starImg;

@property (nonatomic,weak) IBOutlet UIButton *starBtn;

@property (nonatomic,weak) IBOutlet UIButton *callBtn;

@property (nonatomic,copy) sendTypeBlock block;

- (instancetype)initWithFrame:(CGRect)frame andIsStared:(BOOL)stared andHandlerBlock:(sendTypeBlock)block;

- (void)showMyself;
- (void)hideMyself;
- (void)removeMyself;
@end
