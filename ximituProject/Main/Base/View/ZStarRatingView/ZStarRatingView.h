//
//  ZStarRatingView.h
//  CustomRatingBar
//
//  Created by Wanrongtong on 16/6/21.
//  Copyright © 2016年 HHL. All rights reserved.
//
typedef void(^sendStarBlock)(NSArray *starArr,BOOL zero);

#import <UIKit/UIKit.h>
@class ZStarRatingView ;

@interface ZStarRatingView : UIView

@property (nonatomic,copy)sendStarBlock myBlock;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**
 *  创建ZStarRatingView
 *
 *  @param isIndicator 是否仅用于显示
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame andIsIndicator:(BOOL)isIndicator andDefaultStarArray:(NSArray *)defaultStar andHandlerBlock:(sendStarBlock)block;

@end
