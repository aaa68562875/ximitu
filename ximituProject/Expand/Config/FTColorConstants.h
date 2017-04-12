//
//  FTColorConstants.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#ifndef MyFrame_FTColorConstants_h
#define MyFrame_FTColorConstants_h

/*
 *从16位色值获取颜色
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/*
 *从RGB值获取颜色
 */
#define UIColorGromRGBV(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0]

#define navigationBarColor   UIColorFromRGB(0x02bd88)

/**
 *  iOS UIColor
 */
#define WhiteColor [UIColor whiteColor]
#define ClearColor [UIColor clearColor]
#define BrownColor [UIColor brownColor]
#define PurpleColor [UIColor purpleColor]
#define OrangeColor [UIColor orangeColor]
#define MagentaColor [UIColor magentaColor]
#define CyanColor [UIColor cyanColor]
#define BlueColor [UIColor blueColor]
#define GreenColor [UIColor greenColor]
#define RedColor [UIColor redColor]
#define GrayColor [UIColor grayColor]
#define LightGrayColor [UIColor lightGrayColor]
#define DarkGrayColor [UIColor darkGrayColor]
#define BlackColor [UIColor blackColor]
#define YellowColor [UIColor yellowColor]


#endif
