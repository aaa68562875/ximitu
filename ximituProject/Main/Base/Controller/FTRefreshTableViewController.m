//
//  FTRefreshTableViewController.m
//  XingSiluSend
//
//  Created by zlc on 16/1/25.
//  Copyright © 2016年 Flybor. All rights reserved.
//

#import "FTRefreshTableViewController.h"



#import "FTBaseRemoteDAO.h"
#import "Reachability.h"
#import "IQUIView+Hierarchy.h"

@interface FTRefreshTableViewController ()

@end

@implementation FTRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    [self initData];
//    self.view.backgroundColor = WhiteColor;
    
//    [self addMjRefresh];
    
    if ([[[FTBaseRemoteDAO alloc] init] checkConnectionStatus] == NotReachable) {
        return;
    } else {
        //[self showEmptyContentViewWithText:@"暂无信息！"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData {
    _currentPage = 1;
    _dataSource = [NSMutableArray array];
}
/**
 *  add pull up/on mjRefresh
 */
- (void)addMjRefresh{
    
    //添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataWithMjOffsetY)];

    [self.tableView.mj_footer beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //添加上拉加载
    //1自动加载
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataWithMjOffsetY)];
    //默认
//    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
//        [self loadDataWithMjOffsetY];
//    }];
    //上拉刷新 自动回弹的上拉
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataWithMjOffsetY)];
    
    // 设置了底部inset
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
}

- (void)loadDataWithMjOffsetY{}
//加载结束
- (void)endRefreshing{
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
//数据已经加载完
- (void)refreshingWithNoMoreData{
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    
}

#pragma mark -
#pragma mark 给子类继承的方法
#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    
    return cell;
}


- (void)showConnectionError:(NSString *)error {
    [self.delegate showErrorAlertView:error];
}

- (void)showEmptyContentViewWithText:(NSString *)textValue WithImageStr:(NSString *)imageStr{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:FRAME(CGRectGetMidX(self.tableView.frame) - 52/2, 50, 52, 52)];
        if ([self.view viewWithTag:1000]) {
            return;
        }
    imageView.image = IMAGE(@"无内容");
    imageView.tag = 1000;
    
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 50,kFTScreenWidth, 30)];
        if ([self.view viewWithTag:8888]) {
            return;
        }
    titleLbl.tag = 8888;
    titleLbl.font = [UIFont systemFontOfSize:14.0f];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = COLOR_16(@"c0c0c0");
    titleLbl.text = textValue;
    [self.tableView addSubview:titleLbl];
//    [self.tableView addSubview:imageView];
    [self.tableView bringSubviewToFront:titleLbl];

}
- (void)removeEmptyView {
    [[self.tableView viewWithTag:8888] removeFromSuperview];
    [[self.tableView viewWithTag:1000] removeFromSuperview];
}



- (void)didReceiveProcessedResponse:(id)JSON forRequest:(NSString *)request {
    
    if ([JSON isKindOfClass:[NSArray class]]) {
        if (((NSArray *)JSON).count == 0) {
            if (_currentPage == 1) {
                [self.dataSource removeAllObjects];
            } else {
                [self showHUDWithText:kFTUserAlertCanNotLoadMoreData];
            }
            [self.tableView.mj_footer endRefreshing];
        } else {
            [self removeEmptyView];
            if (_currentPage == 1) {
                [self.dataSource removeAllObjects];
            }
            [self.dataSource addObjectsFromArray:((NSArray *)JSON)];
        }
//        [self testRealLoadMoreData];
    } else {
        [self showEmptyContentViewWithText:@"暂无信息" WithImageStr:@"no_content"];
    }
}


@end
