//
//  UIAlertController+AlertController.m
//  UIAlertViewForiOS9
//
//  Created by zlc on 15/10/28.
//  Copyright © 2015年 Henry. All rights reserved.
//

#import "UIAlertController+AlertController.h"

@implementation UIAlertController (AlertController)




//
+ (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle cancellAction:(UIAlertAction *)cancellAction ensureAction:(UIAlertAction *)ensureAction{
    
    UIAlertController *alertVC = [self alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    [alertVC addAction:cancellAction];
    [alertVC addAction:ensureAction];
    

    
    return alertVC;
}

+ (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle cancellAction:(UIAlertAction *)cancellAction deletAction:(UIAlertAction *)deletAction ensureAction:(UIAlertAction *)ensureAction{
    UIAlertController *alertVC = [self alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    [alertVC addAction:cancellAction];
    
    [alertVC addAction:deletAction];
    [alertVC addAction:ensureAction];
    
    
    return alertVC;

}


@end
