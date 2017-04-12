//
//  DropDownMenu.m
//  XingsiluOwner
//
//  Created by Wanrongtong on 16/6/17.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "DropDownMenu.h"
#import "ItemCell.h"

@interface DropDownMenu ()
{
    NSMutableArray *_btnArr;
    int _selectedView;
    NSArray *_tableViewDataArr;
    NSInteger _count;
    NSArray *_titleArr;
    NSArray *_dataArr;
    CGFloat _selfHeight;
    
    NSMutableArray *_cellArr;
    NSMutableArray *_titleLabArr;
    
    NSMutableArray *_completionArr;
}

@end

@implementation DropDownMenu
- (void)drawRect:(CGRect)rect
{
    _selfHeight = self.frame.size.height;
}
- (id)initWithCount:(NSInteger)count withTitleArr:(NSArray *)titleArr withDataArr:(NSArray *)dataArr withBackView:(UIView *)backView withHandlerBlock:(HandlerBlock)block
{
    self = [super init];
    if (self) {
        self.block = block;
        self.backView = backView;
        _count = count;
        _titleArr = titleArr;
        _dataArr = dataArr;
        self.backgroundColor = [UIColor colorWithRed:233/255.0 green:234/255.0 blue:235/255.0 alpha:1];
        
        _btnArr = [NSMutableArray array];
        _tableViewDataArr = [NSArray array];
        _cellArr = [NSMutableArray array];
        _titleLabArr = [NSMutableArray array];
        _completionArr = [NSMutableArray array];
        
        [self creatView];
        [self creatTableView];
        
        GESTURE_TAP(_backView, @selector(tapBackView:));
    }
    return self;
}
#pragma mark - 创建tableview
- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self addSubview:_tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.titleLab.text = _tableViewDataArr[indexPath.row];
    cell.isSelected = NO;
    UILabel *lab = _titleLabArr[_selectedView];
    if ([cell.titleLab.text isEqualToString:lab.text]) {
        cell.isSelected = YES;
    }
    [_cellArr addObject:cell];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (ItemCell *cell in _cellArr) {
        cell.isSelected = NO;
    }
    
    ItemCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = YES;
    
    UILabel *lab = _titleLabArr[_selectedView];
    lab.text = cell.titleLab.text;
    
    for (int i = 0; i<_titleArr.count; i++) {
        UILabel *title = _titleLabArr[i];
        [_completionArr addObject:title.text];
        
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = _selectedView;
    [self btnClick:btn];
    
    [self.delegate completionArr:_completionArr];
    if (self.block) {
        self.block(indexPath.row,_tableViewDataArr[indexPath.row]);
    }
    
}
#pragma mark - 创建View
- (void)creatView
{
    float btnWidth = kFTScreenWidth/3;
    for (int i = 0; i<_count; i++) {
        CustomView *bgView = [[CustomView alloc]initWithFrame:CGRectMake(btnWidth*i, 0, btnWidth-1, 43)];
        bgView.tag = i;
        bgView.backgroundColor = [UIColor colorWithRed:233/255.0 green:234/255.0 blue:235/255.0 alpha:1];
        [self addSubview:bgView];
        
        NSString *title = _titleArr[i];
        UILabel *titleLab = [UILabel new];
        //        titleLab.adjustsFontSizeToFitWidth = YES;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.tag = i+10;
        titleLab.text = title;
        titleLab.font = [UIFont systemFontOfSize:14];
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18]}];
        CGFloat floutX = (btnWidth-size.width-13-10)/2.0;
        titleLab.frame = CGRectMake(floutX, 0, size.width, 43);
        [_titleLabArr addObject:titleLab];
        [bgView addSubview:titleLab];
        
        UIImageView *angleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(floutX+size.width+10, 18, 13, 7)];
        angleImgView.tag = i+100;
        angleImgView.image = [UIImage imageNamed:@"menu_xl.png"];
        [bgView addSubview:angleImgView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, btnWidth-1, 43);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
        [_btnArr addObject:btn];
        
    }
    
    
}
- (void)tapBackView:(UITapGestureRecognizer *)tap{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = _selectedView;
    [self btnClick:btn];
}

- (void)btnClick:(UIButton *)sender
{
    [_cellArr removeAllObjects];
    for (UIButton *btn in _btnArr) {
        CustomView *bgView = (CustomView *)[btn superview];
        if (btn == sender) {
            bgView.isUnfold = !bgView.isUnfold;
            _selectedView = (int)bgView.tag;
        }else{
            bgView.isUnfold = NO;
        }
    }
    
    CustomView *bgView = (CustomView *)[sender superview];
    if (bgView.isUnfold) {
        _tableViewDataArr = _dataArr[_selectedView];
        _backView.alpha = 0.5;
        
        CGRect rect = self.frame;
        rect.size.height = _selfHeight + 44*_tableViewDataArr.count;
        self.frame = rect;
        _tableView.frame = CGRectMake(0, 44, kFTScreenWidth, _tableViewDataArr.count*44);
        
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
        [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    }else
    {
        _backView.alpha = 0;
        CGRect rect = self.frame;
        rect.size.height = _selfHeight;
        self.frame = rect;
        _tableView.frame = CGRectZero;
        
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
        [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    }
    
}


@end



@implementation CustomView
- (void)setIsUnfold:(BOOL)isUnfold
{
    _isUnfold = isUnfold;
    UILabel *titleLab = [self viewWithTag:self.tag+10];
    UIImageView *angleImgView = [self viewWithTag:self.tag+100];
    
    if (isUnfold) {
        titleLab.textColor = [UIColor redColor];
        angleImgView.transform = CGAffineTransformMakeRotation(M_PI);
        
    }else
    {
        titleLab.textColor = [UIColor blackColor];
        angleImgView.transform = CGAffineTransformMakeRotation(0);
    }
}

@end

