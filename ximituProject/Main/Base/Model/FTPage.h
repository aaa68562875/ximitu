//
//  FTPage.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTEntity.h"

@interface FTPage : FTEntity

@property (nonatomic,assign)int pageSize;
@property (nonatomic,assign)int pageNumber;
- (FTPage *)initWithPageSize:(int)size pageNumber:(int)number;
+ (FTPage *)pageWithPageSize:(int)size pageNumber:(int)number;

@end
