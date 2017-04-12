//
//  UIAlertController+AlertController.h
//  UIAlertViewForiOS9
//
//  Created by zlc on 15/10/28.
//  Copyright © 2015年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (AlertController)

/**
 *  创建一个类似于UIAlertView、UIActionSheet的弹窗 确定、取消按钮
 *
 *  @param title          标题
 *  @param message        信息
 *  @param preferredStyle 决定显示是alert、actionSheet的样式
 *  @param cancellAction  取消按钮
 *  @param ensureAction   确定按钮
 *
 *  @return UIAlertController
 */
+ (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle cancellAction:(UIAlertAction *)cancellAction ensureAction:(UIAlertAction *)ensureAction;

/**
 *  创建一个类似于UIAlertView、UIActionSheet的弹窗
 *
 *  @param title          标题
 *  @param message        信息
 *  @param preferredStyle 决定显示是alert、actionSheet的样式
 *  @param cancellAction  取消按钮
 *  @param deletAction    删除按钮
 *  @param ensureAction   确定按钮
 *
 *  @return UIAlertController
 */
+ (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle cancellAction:(UIAlertAction *)cancellAction deletAction:(UIAlertAction *)deletAction ensureAction:(UIAlertAction *)ensureAction;
@end
