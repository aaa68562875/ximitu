//
//  FTRefreshTableViewController.h
//  XingSiluSend
//
//  Created by zlc on 16/1/25.
//  Copyright © 2016年 Flybor. All rights reserved.
//
/**
 *  MJRefresh tableView
 */

#import "FTBaseViewController.h"

#import "MJRefresh.h"
#import "UIView+MJExtension.h"

@protocol FTRefreshTableViewControllerDelegate <NSObject>

- (void)didSelect:(id)obj;

- (void)showErrorAlertView:(NSString *)error;

- (void)showHUDWithText:(NSString *)text;

@end

@interface FTRefreshTableViewController : FTBaseViewController<UITableViewDelegate,
UITableViewDataSource>
{
    int _currentPage;
}
//@property(nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic, weak) id<FTRefreshTableViewControllerDelegate> delegate;
@property(nonatomic, strong) NSMutableArray *dataSource;

- (void)addMjRefresh;
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
- (void)showEmptyContentViewWithText:(NSString *)textValue WithImageStr:(NSString *)imageStr;
- (void)removeEmptyView;
- (void)didReceiveProcessedResponse:(id)JSON forRequest:(NSString *)request;

@end
