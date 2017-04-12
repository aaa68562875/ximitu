//
//  FTMyDropDownMenuView.m
//  XingSiluSend
//
//  Created by zlc on 15/9/7.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTMyDropDownMenuView.h"
#import "FTMyContentCell.h"


@interface FTMyDropDownMenuView ()
/**
 *  用来获取选中的对象值
 */
@property(nonatomic, strong) NSString *getMessage;

@end

@implementation FTMyDropDownMenuView

- (id)initWithFrame:(CGRect)frame andHandlerBlock:(sendSelectItemBlock) block{

  self = [super initWithFrame:frame];
  if (self) {
      self.block = block;
      [self initTableView];
  }

  return self;
}
- (void)initTableView {

  _getMessage = @"";
    self.hidden = YES;
  _contentTableView = [[UITableView alloc]
      initWithFrame:FRAME(0, 0, self.frame.size.width, self.frame.size.height)
              style:UITableViewStylePlain];
  _contentTableView.delegate = self;
  _contentTableView.dataSource = self;
    _contentTableView.bounces = NO;
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;


  [self addSubview:_contentTableView];
  //注册
  [self.contentTableView registerNib:[UINib nibWithNibName:@"FTMyContentCell"
                                                    bundle:nil]
              forCellReuseIdentifier:@"mydropdownCell"];
}

- (void)showSelf{
    
    [UIView animateWithDuration:0.1 animations:^{
        self.hidden = NO;
        [_contentTableView reloadData];
    }];
}
- (void)hideSelf{
    [UIView animateWithDuration:0.1 animations:^{
        self.hidden = YES;
    }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

    
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  FTMyContentCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"mydropdownCell"
                                      forIndexPath:indexPath];
    cell.itemLab.text = _dataSource[indexPath.row];
    
    if (_currentIndex_sel == indexPath.row) {
        [cell.itemLab setTextColor:[[UIColor alloc] colorWithHexString:@"#f0c357"]];
        cell.selectImg.hidden = NO;
    }else{
        [cell.itemLab setTextColor:[[UIColor alloc] colorWithHexString:@"#333333"]];
        cell.selectImg.hidden = YES;
    }
    

  
  return cell;
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {

  return 45 ;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _getMessage = _dataSource[indexPath.row];
    if (self.block) {
        self.block(_getMessage);
    }
  
}
@end
