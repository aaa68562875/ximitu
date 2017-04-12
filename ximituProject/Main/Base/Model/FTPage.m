//
//  FTPage.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTPage.h"

@implementation FTPage

- (FTPage *)initWithPageSize:(int)size pageNumber:(int)number
{
    if (self=[super init]) {
        self.pageNumber = number;
        self.pageSize = size;
    }
    return self;
}

+ (FTPage *)pageWithPageSize:(int)size pageNumber:(int)number
{
    id page = [[FTPage alloc] initWithPageSize:size pageNumber:number];
    //设置obj的成员值
    return page;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.pageNumber forKey:@"FTPage_pageNumber"];
    [aCoder encodeInteger:self.pageSize forKey:@"FTPage_pageSize"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    _pageNumber=[aDecoder decodeIntForKey:@"FTPage_pageNumber"];
    _pageSize=[aDecoder decodeIntForKey:@"FTPage_pageSize"];
    return self;
}


@end
