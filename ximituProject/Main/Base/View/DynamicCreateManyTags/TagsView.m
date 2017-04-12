//
//  TagsView.m
//  TagsDemo
//
//  Created by Administrator on 16/1/21.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "TagsView.h"

@interface TagsView ()
@property (nonatomic,assign) BOOL isMultiSelect;//是否多选
@property (nonatomic,strong) NSMutableArray *selectItemArray;//选择标签的数组
@end

@implementation TagsView
- (instancetype)initWithFrame:(CGRect)frame andMultiSelect:(BOOL)isMultiSelect andHandleBlock:(LabelClickBlcok)block{

    self = [super initWithFrame:frame];
    if (self) {
        self.block = block;
        self.isMultiSelect = isMultiSelect;
        _selectItemArray = [NSMutableArray array];
    }
    return self;
}

- (void)setTagsFrame:(TagsFrame *)tagsFrame{
//    _tagsFrame.a = [NSArray array];
    _tagsFrame = tagsFrame;
    
    for (NSInteger i=0; i<tagsFrame.tagsArray.count; i++) {
        UIButton *tagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tagsBtn.tag = i + 100;
        [tagsBtn setTitle:tagsFrame.tagsArray[i] forState:UIControlStateNormal];
        [tagsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tagsBtn.titleLabel.font = TagsTitleFont;
        tagsBtn.backgroundColor = [UIColor whiteColor];
        tagsBtn.layer.borderWidth = 1;
        tagsBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        tagsBtn.layer.cornerRadius = 4;
        tagsBtn.layer.masksToBounds = YES;
        
        tagsBtn.frame = CGRectFromString(tagsFrame.tagsFrames[i]);
        
        [self addSubview:tagsBtn];
        [tagsBtn addTarget:self action:@selector(labelClickHandler:) forControlEvents:UIControlEventTouchDown];
    }
}
- (void)labelClickHandler:(UIButton *)btn{
    //选中的item
    NSString *selectItem = _tagsFrame.tagsArray[btn.tag - 100];
    
    btn.selected = !btn.selected;
    if (_isMultiSelect) {//多选
        
        if (btn.selected) {
            
            if (_selectItemArray.count < _limitNum) {
                [_selectItemArray addObject:selectItem];
                [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            }else{
                NSLog(@"最多选%zd个",_limitNum);
                btn.selected = NO;
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            

        }else{
            if (_selectItemArray != 0) {
                if ([_selectItemArray containsString:selectItem]) {
                    [_selectItemArray removeObject:selectItem];
                }
            }
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        
    }else{//单选
        [_selectItemArray removeAllObjects];
        if (btn.selected) {
            [_selectItemArray addObject:selectItem];
            [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            for (int i = 0; i<_tagsFrame.tagsArray.count; i++) {
                UIButton *button = [self viewWithTag:i+100];
                if (i != btn.tag - 100) {
                    button.selected = NO;
                    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
            }
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    //处理所选的item回调
    if (_block) {
        self.block(_selectItemArray);
    }
}





@end
