//
//  NSArray+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "NSArray+Common.h"

@implementation NSArray (Common)

- (id)firstObject{
    if (self.count == 0) {
        return nil;
    }else{
        return [self objectAtIndex:0];
    }
}
- (BOOL)containsString:(NSString *)string
{
    if (string == nil||[string isEqualToString:@""]) {
        return NO;
    }
    for (NSString *str in self) {
        if ([str isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

- (NSInteger)indexOfString:(NSString *)string
{
    NSInteger index = NSNotFound;
    
    for (int stringIndex = 0; stringIndex < self.count; stringIndex++) {
        NSString *searchString = [self objectAtIndex:stringIndex];
        
        if ([searchString isEqualToString:string]) {
            index = stringIndex;
            
            break;
        }
    }
    
    return index;
}

- (BOOL)containsObject:(id)anObject usingCompareBlock:(BOOL (^)(id, id))compareBlock
{
    if (anObject == nil) {
        return NO;
    }
    for (id obj in self) {
        if (compareBlock(obj,anObject)) {
            return YES;
        }
    }
    return NO;
}

@end
