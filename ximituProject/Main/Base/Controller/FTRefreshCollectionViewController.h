//
//  FTRefreshCollectionViewController.h
//  XingSiluSend
//
//  Created by zlc on 16/2/1.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//
/**
 *  MJRefresh collectionview
 */
#import "FTBaseViewController.h"
#import "MJRefresh.h"
#import "UIView+MJExtension.h"

@protocol FTRefreshCollectionViewControllerDelegate <NSObject>

- (void)didSelect:(id)obj;

- (void)showErrorAlertView:(NSString *)error;

- (void)showHUDWithText:(NSString *)text;

@end

@interface FTRefreshCollectionViewController : FTBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

{

    int _currentPage;
}

@property(weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic, weak)
id<FTRefreshCollectionViewControllerDelegate> delegate;
@property(nonatomic, strong) NSMutableArray *dataSource;


/**
 *  上拉、下拉加载数据，可根据mj_offsetY的正负判断上下拉
 */
- (void)loadDataWithMjOffsetY;

//加载结束
- (void)endRefreshing;
//数据已经加载完
- (void)refreshingWithNoMoreData;


/**
 *  显示、隐藏空视图
 */
- (void)showEmptyContentViewWithText:(NSString *)textValue;
- (void)showEmptyExchangeContentViewWithText:(NSString *)textValue;
- (void)removeEmptyView;
- (void)didReceiveProcessedResponse:(id)JSON forRequest:(NSString *)request;

@end
