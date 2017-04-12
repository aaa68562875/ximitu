//
//  FTGuideView.m
//  XingSiluSend
//
//  Created by zlc on 15/11/28.
//  Copyright © 2015年 Wanrongtong. All rights reserved.
//

#import "FTGuideView.h"

@interface FTGuideView ()

{
    UIPageControl *_pageControl;
}
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation FTGuideView

- (id)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kFTScreenWidth, kFTScreenHeight);
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.contentSize = CGSizeMake(4*kFTScreenWidth, kFTScreenHeight);
        self.scrollView.bounces = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        [self imageLayout];
    }
    
    return self;
}

#pragma mark - imageView布局
-(void)imageLayout
{
    NSArray * imgArr = @[@"index1", @"index2", @"index3", @"index4"];
    for (int i = 0; i < imgArr.count; i++)
    {
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i%imgArr.count * kFTScreenWidth ,0, kFTScreenWidth, kFTScreenHeight)];
        imgView.image = [UIImage imageNamed:imgArr[i]];
        [self.scrollView addSubview:imgView];
        
        if (i<3) {
            //            UIButton *nextPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //            nextPageBtn.frame = CGRectMake(kFTScreenWidth/2-40/2,(i+1)*kFTScreenHeight-90 , 40, 40);
            //            [nextPageBtn setImage:[UIImage imageNamed:@"往下"] forState:UIControlStateNormal];
            //            nextPageBtn.tag = i+1;
            //            [nextPageBtn addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
            //            [self addSubview:nextPageBtn];
            //
            //            UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //            skipBtn.frame = CGRectMake(kFTScreenWidth-49-20,(i+1)*kFTScreenHeight-40 , 49, 15);
            //            [skipBtn setImage:[UIImage imageNamed:@"跳过"] forState:UIControlStateNormal];
            //            [skipBtn addTarget:self action:@selector(getInto:) forControlEvents:UIControlEventTouchUpInside];
            //            [self addSubview:skipBtn];
        }else{
            //最后一屏
            UIButton *lastPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            lastPageBtn.frame = CGRectMake(i*kFTScreenWidth + 60,kFTScreenHeight - 160 , kFTScreenWidth- 120, 40);
            [lastPageBtn setBackgroundColor:UIColorGromRGBV(38, 180, 99)];
            [lastPageBtn setTitle:@"开启服务" forState:0];
            [lastPageBtn setTitleColor:WhiteColor forState:0];
            [lastPageBtn setCornerRadius:10 andBorderColor:nil andBorderWidth:0];
            [lastPageBtn addTarget:self action:@selector(getInto:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:lastPageBtn];
        }
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kFTScreenHeight - 35, kFTScreenWidth, 35)];
    _pageControl.numberOfPages = imgArr.count;
    _pageControl.currentPageIndicatorTintColor = UIColorGromRGBV(38, 180, 99);
    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    _pageControl.enabled = NO;
    
    [self addSubview:_pageControl];
}

#pragma mark - scrollView滚动代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _pageControl.currentPage = scrollView.contentOffset.x/kFTScreenWidth;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


#pragma mark - 进入
-(void)getInto:(UIButton*)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"One"];
    [self.guideDelegate removeView:self];
    
    if (self != nil) {
        [self removeFromSuperview];
    }
    
    
}

- (void)changePage:(UIButton *)btn
{
    
    [self.scrollView setContentOffset:CGPointMake(0,kFTScreenHeight* btn.tag) animated:YES];
}
@end
