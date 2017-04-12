//
//  NSURL+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "NSURL+Common.h"

@implementation NSURL (Common)
- (NSDictionary*)paramDictionary
{
    NSString *paramstr=self.query;
    NSArray *split=[paramstr componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    for (NSString *str in split) {
        if ([str isMatchedByRegex:@".=."]) {
            NSArray *str_split=[str componentsSeparatedByString:@"="];
            if (str_split.count==2) {
                [dic setValue:[str_split objectAtIndex:1] forKey:[str_split objectAtIndex:0]];
            }
        }
    }
    return dic;
}

- (NSString*)valueForParam:(NSString *)param
{
    return [self.paramDictionary valueForKey:param];
}

@end
