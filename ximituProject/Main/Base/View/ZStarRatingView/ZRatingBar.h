//
//  ZRatingBar.h
//  CustomRatingBar
//
//  Created by Wanrongtong on 16/6/21.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^starClickBlock)(NSInteger starCount);

@interface ZRatingBar : UIView
@property (nonatomic,copy)starClickBlock block;

/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用
 *  Block）实现
 *
 *  @param deselectedName   未选中图片名称
 *  @param halfSelectedName 半选中图片名称
 *  @param fullSelectedName 全选中图片名称
 *  @param delegate          代理
 */
- (void)setImageDeselected:(NSString *)deselectedName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName  andHandlerBlock:(starClickBlock)block;

/**
 *  设置评分值
 *
 *  @param rating 评分值
 */
- (void)displayRating:(float)rating;

/**
 *  获取当前的评分值
 *
 *  @return 评分值
 */
- (float)rating;

/**
 *  是否是指示器，如果是指示器，就不能滑动了，只显示结果，不是指示器的话就能滑动修改值
 *  默认为NO
 */
@property (nonatomic,assign) BOOL isIndicator;
/**
 *  当isIndicator为YES的时候,仅用于显示亮着星星的个数
 */
@property (nonatomic,assign) CGFloat defaultStar;

@end
