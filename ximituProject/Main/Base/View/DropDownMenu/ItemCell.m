//
//  ItemCell.m
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/6/17.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.angleImgView.hidden = YES;
}
- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.titleLab.textColor = [UIColor redColor];
        self.angleImgView.hidden = NO;
    }else
    {
        self.titleLab.textColor = [UIColor blackColor];
        self.angleImgView.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
