//
//  FTRefreshCollectionViewController.m
//  XingSiluSend
//
//  Created by zlc on 16/2/1.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "FTRefreshCollectionViewController.h"
#import "FTBaseRemoteDAO.h"
#import "Reachability.h"
#import "IQUIView+Hierarchy.h"
@interface FTRefreshCollectionViewController ()

@end

@implementation FTRefreshCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];

    [self addMjRefresh];
    if ([[[FTBaseRemoteDAO alloc] init] checkConnectionStatus] == NotReachable) {
        return;
    } else {
        //[self showEmptyContentViewWithText:@"暂无信息！"];
    }
}
- (void)initData {
    _currentPage = 1;
    _dataSource = [NSMutableArray array];
}

#pragma mark -
/**
 *  add pull up/on mjRefresh
 */
- (void)addMjRefresh{
    
    //添加下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataWithMjOffsetY)];
    
    [self.collectionView.mj_footer beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    //添加上拉加载
    //1自动加载
    //    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataWithMjOffsetY)];
    //默认
    //    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
    //        [self loadDataWithMjOffsetY];
    //    }];
    //上拉刷新 自动回弹的上拉
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataWithMjOffsetY)];
    
    // 设置了底部inset
    //    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
}

- (void)loadDataWithMjOffsetY{}
//加载结束
- (void)endRefreshing{
    [self.collectionView reloadData];
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}
//数据已经加载完
- (void)refreshingWithNoMoreData{
    [self.collectionView reloadData];
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}



#pragma mark -
#pragma mark 给子类继承的方法
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UICollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                              forIndexPath:indexPath];
    //    if (!cell) {
    //        cell = [[UICollectionViewCell alloc] init];
    //    }
    return cell;
}

#pragma mark -


#pragma mark -
#pragma mark UIScrollViewDelegate Methods



#pragma mark -
#pragma mark EGORefreshTableDelegate Methods


- (void)showEmptyContentViewWithText:(NSString *)textValue {
    UIView *empty = [[UIView alloc] initWithFrame:_collectionView.frame];
    empty.tag = 8888;
    empty.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.view addSubview:empty];
    [self.view bringSubviewToFront:empty];
    
    UIImageView *no_class_img = [[UIImageView alloc]
                                 initWithFrame:CGRectMake((kFTScreenWidth - 93) / 2,
                                                          (kFTScreenHeight - empty.top - 93 - 50) / 2, 93,
                                                          93)];
    no_class_img.image = [UIImage imageNamed:@"no_content"];
    [empty addSubview:no_class_img];
    
    UILabel *titleLbl = [[UILabel alloc]
                         initWithFrame:CGRectMake(0, no_class_img.top + no_class_img.height + 20,
                                                  kFTScreenWidth, 30)];
    titleLbl.text = textValue;
    titleLbl.font = [UIFont systemFontOfSize:17.0f];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [empty addSubview:titleLbl];
}
#if 1
//我的兑换界面，由于当前View上部分有个人信息视图，会导致self.tableView下沉，当没有数据时，提示内容视图也会下沉，需重写父类-->提示视图方法
- (void)showEmptyExchangeContentViewWithText:(NSString *)textValue {
    UIView *empty = [[UIView alloc] initWithFrame:_collectionView.frame];
    //    empty.center = CGPointMake(kFTScreenWidth/2, kFTScreenHeight/2-300);
    empty.tag = 8888;
    empty.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.view addSubview:empty];
    [self.view bringSubviewToFront:empty];
    
    UIImageView *no_class_img = [[UIImageView alloc]
                                 initWithFrame:CGRectMake((kFTScreenWidth - 93) / 2,
                                                          (kFTScreenHeight - 200) / 2, 93, 93)];
    no_class_img.image = [UIImage imageNamed:@"no_content"];
    [empty addSubview:no_class_img];
    
    UILabel *titleLbl = [[UILabel alloc]
                         initWithFrame:CGRectMake(0, no_class_img.top + no_class_img.height + 20,
                                                  kFTScreenWidth, 30)];
    titleLbl.text = textValue;
    titleLbl.font = [UIFont systemFontOfSize:17.0f];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [empty addSubview:titleLbl];
}
#endif
- (void)removeEmptyView {
    [[self.view viewWithTag:8888] removeFromSuperview];
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)didReceiveProcessedResponse:(id)JSON forRequest:(NSString *)request {
    if ([JSON isKindOfClass:[NSArray class]]) {
        if (((NSArray *)JSON).count == 0) {
            if (_currentPage == 1) {
                [self.dataSource removeAllObjects];
            } else {
                [self showHUDWithText:kFTUserAlertCanNotLoadMoreData];
            }
            [self.collectionView.mj_footer endRefreshing];
        } else {
            [self removeEmptyView];
            if (_currentPage == 1) {
                [self.dataSource removeAllObjects];
            }
            [self.dataSource addObjectsFromArray:((NSArray *)JSON)];
        }
//        [self testRealLoadMoreData];
    } else {
        [self showEmptyContentViewWithText:@"暂无信息！"];
    }
}

@end
