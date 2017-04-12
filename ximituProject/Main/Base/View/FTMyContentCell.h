//
//  FTMyContentCell.h
//  XingSiluSend
//
//  Created by zlc on 15/9/7.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) BOOL isSelect;

@end

@interface FTMyContentCell : UITableViewCell

/**
 *  选项item
 */
@property(weak, nonatomic) IBOutlet UILabel *itemLab;
@property(weak, nonatomic) IBOutlet UILabel *lineLab;
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;

@end
