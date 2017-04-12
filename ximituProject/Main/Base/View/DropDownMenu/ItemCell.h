//
//  ItemCell.h
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/6/17.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *angleImgView;
@property (nonatomic,assign) BOOL isSelected;
@end
