//
//  UILabel+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "UILabel+Common.h"
#import "NSString+Common.h"

@implementation UILabel (Common)
- (void)setText:(NSString *)aText
          font:(CGFloat)aFont
        color1:(UIColor*)aColor1
        color2:(UIColor*)aColor2{
    if ([aText isEmpty]) {
        aText=@"";
    }
    self.text = aText;
    self.font = [UIFont systemFontOfSize:aFont];
    self.textColor = aColor1;
    self.highlightedTextColor = aColor2;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSafeText:(NSString *)text
{
    if ([text isNull]) {
        text=@"";
    }
    else if ([text isKindOfClass:[NSString class]]==NO) {
        text=@"";
    }
    else if ([text isKindOfClass:[NSString class]]) {
        if ([text isEmpty]) {
            text=@"";
        }
        else if ([text isEqualToString:@"<null>"]){
            text=@"";
        }
        else if ([text isEqualToString:@"(null)"]){
            text=@"";
        }
        else if ([text isEqualToString:@"null"]){
            text=@"";
        }
        else{
            
        }
    }
    self.text=text;
    self.backgroundColor=[UIColor clearColor];
}

- (void)setAlignment:(NSTextAlignment)aAlignment{
    
    self.textAlignment = (NSTextAlignment)aAlignment;
    self.contentMode = UIViewContentModeTop;
    self.lineBreakMode = NSLineBreakByWordWrapping;
}
- (UILabel *)resizeHeight{
    //**** 动态设定高度 ****
    [self setNumberOfLines:0];
    CGSize maxSize = self.frame.size;
    maxSize.height = 100000;
    
    CGSize autoResize ;
    if (SYSTEMVERSION >= 7.0) {
        autoResize = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    }
    else{
        autoResize = [self.text sizeWithFont: self.font constrainedToSize: maxSize lineBreakMode: NSLineBreakByWordWrapping];
    }
    
    //	if(autoResize.height>self.height){
    //		[self setHeight:autoResize.height];
    //	}
    [self setHeight:autoResize.height];
    return self;
}
- (void)resizeWidth{
    //**** 一行之内 ****
    [self setNumberOfLines:1];
    CGSize maxSize=self.frame.size;
    CGSize autoResize ;
    if (SYSTEMVERSION >= 7.0) {
        autoResize = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    }
    else{
        autoResize = [self.text sizeWithFont: self.font
                           constrainedToSize: maxSize
                               lineBreakMode: NSLineBreakByWordWrapping];
    }
    if(autoResize.width<self.width){
        [self setWidth:autoResize.width];
    }
}



//_____________________//
//将此文本标签垂直居中
-(void)verticalAlignmentCerter
{
    CGFloat height=[NSString heightForString:self.text Size:CGSizeMake(self.frame.size.width, 333333) Font:self.font Lines:self.numberOfLines].size.height;
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

-(void)verticalAlignmentTop
{
    CGFloat height=[NSString heightForString:self.text Size:CGSizeMake(self.frame.size.width, 333333) Font:self.font Lines:self.numberOfLines].size.height;
    CGRect rect=self.frame;
    if (rect.size.height>height) {
        rect.size.height=height;
    }
    self.frame=rect;
}

-(void)verticalAlignmentBottom
{
    CGFloat height=[NSString heightForString:self.text Size:CGSizeMake(self.frame.size.width, 333333) Font:self.font Lines:self.numberOfLines].size.height;
    CGRect rect=self.frame;
    if (rect.size.height>height) {
        rect.origin.y+=(rect.size.height-height);
        rect.size.height=height;
    }
    self.frame=rect;
}

@end
