//
//  FTWarningView.m
//  XingSiluSend
//
//  Created by zlc on 16/1/28.
//  Copyright © 2016年 Flybor. All rights reserved.
//

#import "FTWarningView.h"

@interface FTWarningView ()
{
    
    UIView *backView;
    
}
@end

@implementation FTWarningView



- (id)initWithSuperView:(UIView *)view withContent:(NSString *)content handleOperateWithBlock:(HandleBlock)handle{
    
    self = [[NSBundle mainBundle] loadNibNamed:@"FTWarningView" owner:nil options:nil].lastObject;
        if ( self) {
        block = handle;
        
        _contentLab.text = content;
        [_topView setBackgroundColor:[[UIColor alloc] colorWithHexString:@"#EEEEEE"]];
        [self setCornerRadius:10 andBorderColor:nil andBorderWidth:0];
        [self frameResetWithContent:content];
       
        backView = [[UIView alloc] initWithFrame:view.frame];
        [backView setBackgroundColor:BlackColor];
        backView.alpha = 0.2;
        [view addSubview:backView];
        GESTURE_TAP(backView, @selector(tabBack));
    }
    
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)cancellClick:(id)sender {
    
    [self hideSelf];
    if (block != nil) {
        block(NO);
    }
}

- (IBAction)ensureClick:(id)sender {
    [self hideSelf];
    
    if (block != nil) {
        block(YES);
    }
}

#pragma mark -

- (void)frameResetWithContent:(NSString *)content{
    self.alpha = 0;
    self.frame = FRAME(20, 0, kFTScreenWidth - 40, 0);
    
    CGFloat width = [content calculateWidthWithFont:SYSTEM_FONT_SIZE(17.0)];
    CGFloat height = [content calculateHeight:SYSTEM_FONT_SIZE(17.0) :self.frame.size.width - 20];
    width>self.frame.size.width-20 ? _contentLab.textAlignment = NSTextAlignmentLeft:NSTextAlignmentCenter;
    _contentLab.numberOfLines = 0;
    _contentLab.frame = FRAME(10, CGRectGetMaxY(_topView.frame)+20, self.frame.size.width - 20, height + 10);
    
    
    Frame(_cancellBtn, 0, 1, self.frame.size.width/2, 47);
    Frame(_ensureBtn, self.frame.size.width/2, 1, self.frame.size.width/2, 47);
    [_cancellBtn setCornerRadius:0 andBorderColor:UIColorGromRGBV(237, 237, 239) andBorderWidth:0.5];
    [_ensureBtn setCornerRadius:0 andBorderColor:UIColorGromRGBV(237, 237, 239) andBorderWidth:0.5];
    
    _bottomView.frame = FRAME(0, CGRectGetMaxY(_contentLab.frame)+20, self.frame.size.width, 48);
    
    self.frame = FRAME(0, 0, kFTScreenWidth - 40, CGRectGetMaxY(_contentLab.frame)+20+48);
    self.center = CGPointMake(kFTScreenWidth/2, kFTScreenHeight/2);

}

- (void)tabBack{
    [self hideSelf];
}

- (void)showSelf{
    
    
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    self.alpha = 0;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)hideSelf{
    [UIView animateWithDuration:0.2 animations:^{
//        self.transform = CGAffineTransformMakeScale(2.f, 2.f);//放大
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeSelf];
    }];
}
- (void)removeSelf{
    [self removeAllSubViews];
    [self removeFromSuperview];
    backView.alpha = 0;
    [backView removeFromSuperview];
}
@end
