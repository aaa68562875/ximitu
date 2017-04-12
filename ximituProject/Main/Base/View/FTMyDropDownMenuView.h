//
//  FTMyDropDownMenuView.h
//  XingSiluSend
//
//  Created by zlc on 15/9/7.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

/**
 *  单级下拉列表
 */
#import <UIKit/UIKit.h>

typedef void(^sendSelectItemBlock)(NSString *message);

@protocol FTMyDropDownMenuViewDelegate;

@interface FTMyDropDownMenuView
    : UIView <UITableViewDataSource, UITableViewDelegate>


- (id)initWithFrame:(CGRect)frame andHandlerBlock:(sendSelectItemBlock) block;

@property (nonatomic,copy) sendSelectItemBlock block;
//数据源
@property(nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) NSInteger currentIndex_sel;//当前选中的cell

@property(nonatomic, strong) UITableView *contentTableView;




- (void)showSelf;
- (void)hideSelf;

@end

@protocol FTMyDropDownMenuViewDelegate <NSObject>

- (void)sendMessage:(NSString *)message
            andNoId:(BOOL)noId
          andObject:(id)data
        andIndexSel:(NSInteger)index;

@end