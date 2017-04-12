//
//  FTErrorView.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTErrorView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation FTErrorView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    //临时测试代码
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]
        initWithTarget:self
                action:@selector(didTapOnErrorView:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:gesture];

    UIImageView *noNetworkImg =
        [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 90, 90)];
    noNetworkImg.center = CGPointMake(self.centerX, self.centerY - 100);
    noNetworkImg.image = [UIImage imageNamed:@"yemianwufa"];
    [self addSubview:noNetworkImg];

    UILabel *titleLbl = [[UILabel alloc]
        initWithFrame:CGRectMake(0, noNetworkImg.top + noNetworkImg.height + 40,
                                 ScreenWidth, 30)];
    titleLbl.text = @"数据加载失败";
    titleLbl.textColor = UIColorFromRGB(0x848484);
    titleLbl.font = [UIFont systemFontOfSize:17.0f];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLbl];

    UILabel *textLbl = [[UILabel alloc]
        initWithFrame:CGRectMake(0, titleLbl.top + titleLbl.height + 18,
                                 ScreenWidth, 30)];
    textLbl.text = @"请检查您的手机是否联网,"
                   @"点击屏幕重新加载";
    textLbl.textColor = UIColorFromRGB(0xababab);
    textLbl.font = [UIFont systemFontOfSize:12.0f];
    textLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:textLbl];
  }
  return self;
}

- (void)didTapOnErrorView:(UITapGestureRecognizer *)gesture {
  [self.delegate doHttpRequest];
}

@end
