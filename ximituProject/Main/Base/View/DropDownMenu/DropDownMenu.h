//
//  DropDownMenu.h
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/6/17.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HandlerBlock)(NSInteger row,NSString *selectStr);
@interface DropDownMenu : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) id delegate;

@property (nonatomic,copy) HandlerBlock block;
@property (nonatomic,retain)UITableView *tableView;

@property (nonatomic,strong) UIView *backView;

- (id)initWithCount:(NSInteger)count withTitleArr:(NSArray *)titleArr withDataArr:(NSArray *)dataArr withBackView:(UIView *)backView withHandlerBlock:(HandlerBlock)block;

@end
@protocol FiltrateViewDelegate <NSObject>

- (void)completionArr:(NSArray *)dataArr;

@end

@interface CustomView : UIView
@property (nonatomic,assign) BOOL isUnfold;

@end