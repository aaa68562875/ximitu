//
//  FTFontConstants.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#ifndef MyFrame_FTFontConstants_h
#define MyFrame_FTFontConstants_h

/*
 自带字体
 
 Font FamiFT: American Typewriter
 Font: AmericanTypewriter
 Font: AmericanTypewriter-Bold
 
 Font Family: AppleGothic
 Font: AppleGothic
 
 Font Family: Arial
 Font: ArialMT
 Font: Arial-BoldMT
 Font: Arial-BoldItalicMT
 Font: Arial-ItalicMT
 
 Font Family: Arial Rounded MT Bold
 Font: ArialRoundedMTBold
 
 Font Family: Arial Unicode MS
 Font: ArialUnicodeMS
 
 Font Family: Courier
 Font: Courier
 Font: Courier-BoldOblique
 Font: Courier-Oblique
 Font: Courier-Bold
 
 Font Family: Courier New
 Font: CourierNewPS-BoldMT
 Font: CourierNewPS-ItalicMT
 Font: CourierNewPS-BoldItalicMT
 Font: CourierNewPSMT
 
 Font Family: DB LCD Temp
 Font: DBLCDTempBlack
 
 Font Family: Georgia
 Font: Georgia-Bold
 Font: Georgia
 Font: Georgia-BoldItalic
 Font: Georgia-Italic
 
 Font Family: Helvetica
 Font: Helvetica-Oblique
 Font: Helvetica-BoldOblique
 Font: Helvetica
 Font: Helvetica-Bold
 
 Font Family: Helvetica Neue
 Font: HelveticaNeue
 Font: HelveticaNeue-Bold
 
 Font Family: Hiragino Kaku Gothic **** W3
 Font: HiraKakuProN-W3
 
 Font Family: Hiragino Kaku Gothic **** W6
 Font: HiraKakuProN-W6
 
 Font Family: Marker Felt
 Font: MarkerFelt-Thin
 
 Font Family: STHeiti J
 Font: STHeitiJ-Medium
 Font: STHeitiJ-Light
 
 Font Family: STHeiti K
 Font: STHeitiK-Medium
 Font: STHeitiK-Light
 
 Font Family: STHeiti SC
 Font: STHeitiSC-Medium
 Font: STHeitiSC-Light
 
 Font Family: STHeiti TC
 Font: STHeitiTC-Light
 Font: STHeitiTC-Medium
 
 Font Family: Times New Roman
 Font: TimesNewRomanPSMT
 Font: TimesNewRomanPS-BoldMT
 Font: TimesNewRomanPS-BoldItalicMT
 Font: TimesNewRomanPS-ItalicMT
 
 Font Family: Trebuchet MS
 Font: TrebuchetMS-Italic
 Font: TrebuchetMS
 Font: Trebuchet-BoldItalic
 Font: TrebuchetMS-Bold
 
 Font Family: Verdana
 Font: Verdana-Bold
 Font: Verdana-BoldItalic
 Font: Verdana
 Font: Verdana-Italic
 
 Font Family: Zapfino
 Font: Zapfino
 */
#pragma mark - 菜单栏

#pragma mark - 系统font方法
#define SYSTEM_FONT_SIZE(_size)  [UIFont systemFontOfSize:_size]

#define HELVETICA_FONT_SIZE(_size) [UIFont fontWithName:@"HelveticaNeue" size:_size]


#pragma mark - 预定义font

#pragma mark - Cells

#define kFTFontCellTitleLabel [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0]
#define kFTFontCellSubTitleLabel [UIFont fontWithName:@"HelveticaNeue" size:10.0]


#pragma mark - NavigationBar

#define kFTFontNavigationBarTitle [UIFont fontWithName:@"HelveticaNeue-Bold" size:24]
#define kFTFontNavigationBarSubtitle [UIFont fontWithName:@"HelveticaNeue-Light" size:14]
#define kFTFontNavigationBarButtonItemTitle [UIFont fontWithName:@"HelveticaNeue-Light" size:14]

#pragma mark - PopOutBox

#define kJBFontInformationTitle [UIFont fontWithName:@"HelveticaNeue" size:20]
#define kJBFontInformationValue [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:100]
#define kJBFontInformationUnit [UIFont fontWithName:@"HelveticaNeue" size:60]
#endif
