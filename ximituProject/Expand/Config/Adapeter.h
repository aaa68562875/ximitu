
//
//  Adapeter.h
//  loc
//
//  Created by rimi on 15/8/12.
//  Copyright (c) 2015年 lili. All rights reserved.
//

#ifndef ____Adapeter_h
#define ____Adapeter_h

#import <UIKit/UIKit.h>

# define DH_INLINE   static inline
# define SCREEN_SIZE [UIScreen mainScreen].bounds.size
# define ORIGIN_HEIGHT  568.f
# define ORIGIN_WIDTH   320.f

DH_INLINE CGFloat DHFlexibleVerticalMutiplier()
{
    return SCREEN_SIZE.height / ORIGIN_HEIGHT;
}

DH_INLINE CGFloat DHFlexibleHorizontalMutiplier()
{
    return SCREEN_SIZE.width / ORIGIN_WIDTH;
}

DH_INLINE CGPoint DHFlexibleCenter(CGPoint center)
{
    return CGPointMake(center.x * DHFlexibleHorizontalMutiplier(), center.y * DHFlexibleVerticalMutiplier());
}

#define ADAPT_IPHONE4

#ifdef ADAPT_IPHONE4
DH_INLINE CGSize DHFlexibleSize(CGSize size, BOOL adjustWidth)
{
    if (adjustWidth) {
        /** < 图片width 不与边界对齐 */
        return CGSizeMake(size.width * DHFlexibleVerticalMutiplier(), size.height*DHFlexibleVerticalMutiplier());
    }
    /** < 图片width 与边界对齐 */
    return CGSizeMake(size.width * DHFlexibleHorizontalMutiplier(), size.height * DHFlexibleVerticalMutiplier());
    
}

DH_INLINE CGRect DHFlexibleFrame(CGRect frame, BOOL adjustWidth)
{
    CGFloat x = frame.origin.x * DHFlexibleHorizontalMutiplier();
    CGFloat y = frame.origin.y * DHFlexibleVerticalMutiplier();
    
    CGRect retFrame ;
    retFrame.origin.x = x;
    retFrame.origin.y = y;
    CGSize size = DHFlexibleSize(frame.size, adjustWidth);
    retFrame.size = size;
    return retFrame;
}

#else
DH_INLINE CGSize DHFlexibleSize(CGSize size)
{
    return CGSizeMake(size.width * DHFlexibleHorizontalMutiplier(), size.height * DHFlexibleVerticalMutiplier());
    
}

DH_INLINE CGRect DHFlexibleFrame(CGRect frame, BOOL adjustWidth)
{
    CGFloat x = frame.origin.x * DHFlexibleHorizontalMutiplier();
    CGFloat y = frame.origin.y * DHFlexibleVerticalMutiplier();
    
    CGRect retFrame ;
    retFrame.origin.x = x;
    retFrame.origin.y = y;
    CGSize size = DHFlexibleSize(frame.size);
    retFrame.size = size;
    return retFrame;
}

#endif



#endif
