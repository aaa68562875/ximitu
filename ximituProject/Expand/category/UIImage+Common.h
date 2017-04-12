//
//  UIImage+Common.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)
/**
 * 保存图片到路径下
 */
-(BOOL)saveWithPath:(NSString*)aPath;


/**
 * 初始化图片
 */
+(UIImage*)imageWithPath:(NSString*)aPath;
+(UIImage*)imageWithBundle:(NSString *)aImageName;


/**
 * 保存当前视图截图到默认目录下
 */
+(void)saveCurrentView:(UIView*)aView;



/**
 * 缩放图片
 */
+ (UIImage *)imageNamed: (NSString *)imageStr rect:(CGRect) rect;
+ (UIImage *)scaleImage:(UIImage *)image maxWidth:(float)maxWidth maxHeight:(float)maxHeight;


/**
 * 旋转图片
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/*
 *转换为黑白图片
 */
- (UIImage*)grayscale:(UIImage*)anImage type:(int)type;

//改变图标颜色
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

/****************************xincc*************************************/
/**
 格式为  imageName-{top, left, bottom, right}-{mode}
 最后一个mode参数可选
 */
+(UIImage*)resizableImageWithString:(NSString*)str;

//调整大小后的图像
-(UIImage*)sizedImage:(CGSize)size;
//旋转图片
+(UIImage *)rotateImage:(UIImage *)aImage;
//获取旋转后的图片
-(UIImage *)rotatedImage;

//指定图片的大小
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

-(UIImage *)scaleToSize:(CGSize)size;

/**
 *  按颜色和尺寸生成图片
 *
 *  @param color 颜色
 *  @param size  尺寸
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
@end

//IB_DESIGNABLE
//@interface UIImageView (Extension)
//
///**
// 可以在xib中设置可变形图片的名称与变形参数
// 格式为  imageName-{top, left, bottom, right}-{mode}
// 最后一个mode参数可选
// */
//@property (nonatomic,retain) IBInspectable NSString * imageScaleableName;
//
//@end
//
//IB_DESIGNABLE
//@interface UIButton (Extension)
//
///**
// 可以从xib设置的可变形图片--state normal
// */
//@property (nonatomic,retain) IBInspectable NSString * normalBackgroundImageScaleableName;
///**
// 可以从xib设置的可变形图片--state highlighted
// */
//@property (nonatomic,retain) IBInspectable NSString * highlightedBackgroundImageScaleableName;
///**
// 可以从xib设置的可变形图片--state Selected
// */
//@property (nonatomic,retain) IBInspectable NSString * selectedBackgroundImageScaleableName;
///**
// 可以从xib设置的可变形图片--state Disable
// */
//@property (nonatomic,retain) IBInspectable NSString * disableBackgroundImageScaleableName;



//@end

//@interface UIButton (<#category name#>)
//
//@end