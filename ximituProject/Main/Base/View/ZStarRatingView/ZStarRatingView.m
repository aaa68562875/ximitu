//
//  ZStarRatingView.m
//  CustomRatingBar
//
//  Created by Wanrongtong on 16/6/21.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "ZStarRatingView.h"
#import "ZRatingBar.h"

@interface ZStarRatingView ()

@property (nonatomic,strong) ZRatingBar *ratingBar;

@property (weak, nonatomic) IBOutlet ZRatingBar *ratingBar1;
@property (weak, nonatomic) IBOutlet ZRatingBar *ratingBar2;
@property (weak, nonatomic) IBOutlet ZRatingBar *ratingBar3;
@property (weak, nonatomic) IBOutlet ZRatingBar *ratingBar4;
//存储星级数组
@property (nonatomic,strong) NSMutableArray *countArray;
@end
@implementation ZStarRatingView

- (instancetype)initWithFrame:(CGRect)frame andIsIndicator:(BOOL)isIndicator andDefaultStarArray:(NSArray *)defaultStar andHandlerBlock:(sendStarBlock)block{
    self = [[NSBundle mainBundle] loadNibNamed:@"ZStarRatingView" owner:nil options:nil].lastObject;
    if (self) {
        
        _countArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
        
        self.frame = frame;
        self.myBlock = block;
        self.ratingBar1.isIndicator = isIndicator;
        self.ratingBar2.isIndicator = isIndicator;
        self.ratingBar3.isIndicator = isIndicator;
        self.ratingBar4.isIndicator = isIndicator;
        if(defaultStar.count != 0){
            self.ratingBar1.defaultStar = [defaultStar[0] floatValue];
            self.ratingBar2.defaultStar = [defaultStar[1] floatValue];
            self.ratingBar3.defaultStar = [defaultStar[2] floatValue];
            self.ratingBar4.defaultStar = [defaultStar[3] floatValue];
            [_countArray removeAllObjects];
            [_countArray addObjectsFromArray:defaultStar];
        }
        [self.ratingBar1 setImageDeselected:@"emptyStar" halfSelected:@"iconfont-banxing" fullSelected:@"allStar" andHandlerBlock:^(NSInteger starCount) {
            [_countArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%zd",starCount]];
            BOOL zero = NO;
            if ([_countArray containsString:@"0"]) {
                zero = YES;
            }else{
                zero = NO;
            }
            if (_myBlock) {
                _myBlock(_countArray,zero);
            }
        }];
        [self.ratingBar2 setImageDeselected:@"emptyStar" halfSelected:@"iconfont-banxing" fullSelected:@"allStar" andHandlerBlock:^(NSInteger starCount) {
            [_countArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%zd",starCount]];
            BOOL zero = NO;
            if ([_countArray containsString:@"0"]) {
                zero = YES;
            }else{
                zero = NO;
            }
            if (_myBlock) {
                _myBlock(_countArray,zero);
            }
        }];
        [self.ratingBar3 setImageDeselected:@"emptyStar" halfSelected:@"iconfont-banxing" fullSelected:@"allStar" andHandlerBlock:^(NSInteger starCount) {
            [_countArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%zd",starCount]];
            BOOL zero = NO;
            if ([_countArray containsString:@"0"]) {
                zero = YES;
            }else{
                zero = NO;
            }
            if (_myBlock) {
                _myBlock(_countArray,zero);
            }
        }];
        [self.ratingBar4 setImageDeselected:@"emptyStar" halfSelected:@"iconfont-banxing" fullSelected:@"allStar" andHandlerBlock:^(NSInteger starCount) {
            [_countArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%zd",starCount]];
            BOOL zero = NO;
            if ([_countArray containsString:@"0"]) {
                zero = YES;
            }else{
                zero = NO;
            }
            if (_myBlock) {
                _myBlock(_countArray,zero);
            }
        }];
    }
    
    return self;
}

@end
