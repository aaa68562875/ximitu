//
//  FTUIBaseInit.h
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#ifndef XingSiluSend_FTUIBaseInit_h
#define XingSiluSend_FTUIBaseInit_h

#define SYSTEMVERSION [[[UIDevice currentDevice] systemVersion] floatValue]


#define FRAME(x,y,width,height) CGRectMake(x,y,width,height)
#define Frame(object,x,y,width,height) object.frame = FRAME(x,y,width,height)
#define ObjectInit(id,objectName) id *objectName = [[id alloc] init]
#define LocalObjectInitWithFrame(id,objectName,x,y,width,height) id *objectName = [[id alloc] initWithFrame:FRAME(x,y,width,height)]
#define GlobalObjectInitWithFrame(id,objectName,x,y,width,height) objectName = [[id alloc] initWithFrame:FRAME(x,y,width,height)]
#define FRAME_SET(VIEW,a,b,c,d)  [VIEW setFrame:FRAME(a,b,c,d)]
#define SIZE_MAKE(X,Y) CGSizeMake(X, Y)
#define POINT_MAKE(view,x,y) [view setCenter:CGPointMake(x, y)]
#define POINT(x,y) CGPointMake(x,y)

#define BUTTON_FRAME_INIT(x,y,width,height) [[UIButton alloc] initWithFrame:CGRectMake(x,y,width,height)]

#define VIEW_FRAME_INIT(x,y,width,height) [[UIView alloc] initWithFrame:CGRectMake(x,y,width,height)]

#define LABEL_FRAME_INIT(x,y,width,height) [[UILabel alloc] initWithFrame:CGRectMake(x,y,width,height)]

#define IMAGEVIEW_FRAME_INIT(x,y,width,height) [[UIImageView alloc] initWithFrame:CGRectMake(x,y,width,height)]

#define IMAGE(imgName) [UIImage imageNamed:imgName]

#define AddSubView(super,suber) [super addSubview:suber]


#define GESTURE_TAP(tapView,SEL) {\
    tapView.userInteractionEnabled = YES;\
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:SEL];\
    [tapView addGestureRecognizer:tap];\
}

#define BUTTON_ACTION(BUTTON,SEL) [BUTTON addTarget: self action:SEL forControlEvents:UIControlEventTouchDown]

#define APPDELEGATE = (AppDelegate *)[UIApplication sharedApplication].delegate;

//float截取前两位小数，不四舍五入
#define Floor(obj) floor(obj*100)/100
/**
 *  手势方向
 */
typedef enum:NSInteger{
    kCameraMoveDirectionNone,
    kCameraMoveDirectionUp,
    kCameraMoveDirectionDown,
    kCameraMoveDirectionRight,
    kCameraMoveDirectionLeft
}CameraMoveDirection;

#endif
