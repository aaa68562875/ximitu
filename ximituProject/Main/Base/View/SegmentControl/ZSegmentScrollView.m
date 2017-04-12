//
//  ZSegmentScrollView.m
//  ZSegmentControl
//
//  Created by Wanrongtong on 16/6/12.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#define MainScreen_W [UIScreen mainScreen].bounds.size.width


#import "ZSegmentScrollView.h"

@interface ZSegmentScrollView ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (strong,nonatomic) NSArray *titles;
//下面的滚动视图
@property (strong,nonatomic)UIScrollView *bgScrollView;
//顶部segmentView
@property (strong,nonatomic)ZSegmentView *segmentToolView;
//segmentView下划线
@property  (strong,nonatomic)UIView *botLine;
//pageControl
@property (strong,nonatomic) UIPageControl *pageControl;
//滚动属性
@property (nonatomic,assign) BOOL scrollEnable;

@end

@implementation ZSegmentScrollView

- (instancetype)initWithFrame:(CGRect)frame
                  titleArray:(NSArray *)titleArray
            contentViewArray:(NSArray *)contentViewArray
            hideSegmentValue:(BOOL)segHide
             hidePageControl:(BOOL)pageCtrlHide
               scrollEnabled:(BOOL)scroll
                  IndexBlock:(IndexBlock)block{
    if (self = [super initWithFrame:frame]) {
        _titles = titleArray;
        _scrollEnable = scroll;
        [self addSubview:self.bgScrollView];
        if (pageCtrlHide == NO) {
            [self addSubview:self.pageControl];
        }
        if (_scrollEnable) {
            _bgScrollView.scrollEnabled = YES;
            
        }else{
            _bgScrollView.scrollEnabled = NO;
        }
        
        CGFloat segmentHeight = 44;
        if (segHide) {
            segmentHeight = 0;
        }
        
        _segmentToolView=[[ZSegmentView alloc] initWithFrame:CGRectMake(0, 0, MainScreen_W, segmentHeight) titles:titleArray clickBlick:^void(NSInteger index) {
            
            if (_scrollEnable) {
                [UIView animateWithDuration:0.2 animations:^{
                    [_bgScrollView setContentOffset:CGPointMake(MainScreen_W*(index-1), 0)];
                }];
            }else{
                [_bgScrollView setContentOffset:CGPointMake(MainScreen_W*(index-1), 0)];//MainScreen_W*(index-1)
            }
            
            _pageControl.currentPage = index-1;
            if (self.block) {
                self.block(index-1);
            }
        }];
        [self addSubview:_segmentToolView];
//        _segmentToolView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _segmentToolView.layer.borderWidth = 1;
        
        _botLine=[[UIView alloc] initWithFrame:CGRectMake(0, _segmentToolView.bounds.size.height, MainScreen_W, 0)];
        _botLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_botLine];
        
        
        for (int i=0;i<contentViewArray.count; i++ ) {
            
            UIView *contentView = (UIView *)contentViewArray[i];
            contentView.frame = CGRectMake(MainScreen_W * i, _segmentToolView.bounds.size.height, MainScreen_W, _bgScrollView.frame.size.height-_segmentToolView.bounds.size.height);
            [_bgScrollView addSubview:contentView];
        }
        self.block = block;
    }
    
    return self;
}






-(UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, _botLine.frame.size.height, MainScreen_W, self.bounds.size.height-_botLine.bounds.size.height)];
        _bgScrollView.contentSize=CGSizeMake(MainScreen_W*_titles.count, self.bounds.size.height-_segmentToolView.bounds.size.height);
        _bgScrollView.backgroundColor=[UIColor whiteColor];
        _bgScrollView.showsVerticalScrollIndicator=NO;
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        _bgScrollView.delegate=self;
        _bgScrollView.bounces=NO;
        _bgScrollView.pagingEnabled=YES;
    }
    return _bgScrollView;
}

- (UIPageControl *)pageControl{
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, MainScreen_W, 20)];
        _pageControl.numberOfPages = _titles.count;
        _pageControl.currentPageIndicatorTintColor = UIColorGromRGBV(38, 180, 99);
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.enabled = NO;
//        [_pageControl addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventTouchDown];
    }
    
    return _pageControl;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_bgScrollView)
    {
        NSInteger p=_bgScrollView.contentOffset.x/MainScreen_W;
        _segmentToolView.defaultIndex=p+1;
        _pageControl.currentPage = p;
        
        if (self.block) {
            self.block(p);
        }
    }
    
}




- (void)pageClick:(UIPageControl *)pageCtrol{
    NSLog(@"%zd",_pageControl.currentPage);
    if (_scrollEnable) {
        [UIView animateWithDuration:0.2 animations:^{
            [_bgScrollView setContentOffset:CGPointMake(MainScreen_W*(_pageControl.currentPage), 0)];
        }];
    }else{
        [_bgScrollView setContentOffset:CGPointMake(MainScreen_W*(_pageControl.currentPage), 0)];
    }
    
    
}

@end
