//
//  ZRatingBar.m
//  CustomRatingBar
//
//  Created by Wanrongtong on 16/6/21.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "ZRatingBar.h"
@interface ZRatingBar (){
    float starRating;
    float lastRating;
    
    float height;
    float width;
    
    UIImage *unSelectedImage;
    UIImage *halfSelectedImage;
    UIImage *fullSelectedImage;
}
@property (nonatomic,strong) UIImageView *s1;
@property (nonatomic,strong) UIImageView *s2;
@property (nonatomic,strong) UIImageView *s3;
@property (nonatomic,strong) UIImageView *s4;
@property (nonatomic,strong) UIImageView *s5;
@end

@implementation ZRatingBar
-(void)setImageDeselected:(NSString *)deselectedName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName  andHandlerBlock:(starClickBlock)block{
    self.block = block;
    
    unSelectedImage = [UIImage imageNamed:deselectedName];
    
    halfSelectedImage = halfSelectedName == nil ? unSelectedImage : [UIImage imageNamed:halfSelectedName];
    
    fullSelectedImage = [UIImage imageNamed:fullSelectedName];
    
    height = 0.0,width = 0.0;
    
    if (height < [fullSelectedImage size].height) {
        height = [fullSelectedImage size].height;
    }
    if (height < [halfSelectedImage size].height) {
        height = [halfSelectedImage size].height;
    }
    if (height < [unSelectedImage size].height) {
        height = [unSelectedImage size].height;
    }
    if (width < [fullSelectedImage size].width) {
        width = [fullSelectedImage size].width;
    }
    if (width < [halfSelectedImage size].width) {
        width = [halfSelectedImage size].width;
    }
    if (width < [unSelectedImage size].width) {
        width = [unSelectedImage size].width;
    }
        width = 25;
        height = 25;
    //    NSLog(@"%f",width);
    //控件宽度适配
    CGRect frame = [self frame];
    
    CGFloat viewWidth = width * 5;
    if (frame.size.width > viewWidth) {
        viewWidth = frame.size.width;
    }
    frame.size.width = viewWidth;
    frame.size.height = height;
    [self setFrame:frame];
    
    starRating = 0.0;
    lastRating = 0.0;
    
    _s1 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s2 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s3 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s4 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s5 = [[UIImageView alloc] initWithImage:unSelectedImage];
    
    
    //星星图片之间的间距
    CGFloat space = (CGFloat)(viewWidth - width*5)/4;
    
    CGFloat startX = 0;
    [_s1 setFrame:CGRectMake(startX, 0, width, height)];
    startX += width + space;
    [_s2 setFrame:CGRectMake(startX, 0, width, height)];
    startX += width + space;
    [_s3 setFrame:CGRectMake(startX, 0, width, height)];
    startX += width + space;
    [_s4 setFrame:CGRectMake(startX, 0, width, height)];
    startX += width + space;
    [_s5 setFrame:CGRectMake(startX, 0, width, height)];
    
    [_s1 setUserInteractionEnabled:NO];
    [_s2 setUserInteractionEnabled:NO];
    [_s3 setUserInteractionEnabled:NO];
    [_s4 setUserInteractionEnabled:NO];
    [_s5 setUserInteractionEnabled:NO];
    
    [self addSubview:_s1];
    [self addSubview:_s2];
    [self addSubview:_s3];
    [self addSubview:_s4];
    [self addSubview:_s5];
    
    [self displayRating:self.defaultStar];
}



/**
 *  设置评分值
 *
 *  @param rating 评分值
 */
-(void)displayRating:(float)rating{
    NSInteger star = 0;
    
    [_s1 setImage:unSelectedImage];
    [_s2 setImage:unSelectedImage];
    [_s3 setImage:unSelectedImage];
    [_s4 setImage:unSelectedImage];
    [_s5 setImage:unSelectedImage];
    
    
    if (rating >= 1 && rating >= 0.5) {
        [_s1 setImage:fullSelectedImage];
        star = 1;
    }
    
    if (rating >= 2 && rating >= 1.5) {
        [_s2 setImage:fullSelectedImage];
        star = 2;
    }
    
    if (rating >= 3 && rating >= 2.5) {
        [_s3 setImage:fullSelectedImage];
        star = 3;
    }
    
    if (rating >= 4 && rating >= 3.5) {
        [_s4 setImage:fullSelectedImage];
        star = 4;
    }
    
    if (rating >= 5 && rating >= 4.5) {
        [_s5 setImage:fullSelectedImage];
        star = 5;
    }
    
    starRating = rating;
    lastRating = rating;
    if (self.block) {
        self.block(star);
    }
}

/**
 *  获取当前的评分值
 *
 *  @return 评分值
 */
-(float)rating{
    return starRating;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesRating:touches];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesRating:touches];
}

//触发
- (void)touchesRating:(NSSet *)touches{
    if (self.isIndicator) {
        return;
    }
    
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //星星图片之间的间距
    CGFloat space = (CGFloat)(self.frame.size.width - width*5)/4;
    
    float newRating = 0;
    
    if (point.x >= 0 && point.x <= self.frame.size.width) {
        
        if (point.x >= 0 && point.x <= width) {
            newRating = 1.0;
        }
        
        if (point.x >=space+width && point.x <= space+width*2){
            newRating = 2.0;
        }
        if (point.x >= space*2+width*2 && point.x <= 2*space+3*width){
            newRating = 3.0;
        }
        if (point.x >= space*3+width*3 && point.x <= 3*space+4*width){
            newRating = 4.0;
        }
        if (point.x >= space*4+width*4 && point.x <= 4*space+5*width){
            newRating = 5.0;
        }
//        NSLog(@"%f %f %f",space,width,point.x);
    }
    
    if (newRating != lastRating){
        [self displayRating:newRating];
    }
}
@end
