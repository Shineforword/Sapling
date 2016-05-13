//
//  SaplingColorDefine.h
//  Sapling
//
//  Created by sport on 16/4/20.
//  Copyright © 2016年 光前. All rights reserved.
//

#ifndef SaplingColorDefine_h
#define SaplingColorDefine_h

#import "UIColor+UIColor.h"

/** 颜色宏*/
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define QYQCOLOR(r,g,b) RGBACOLOR(r,g,b,1)

#define BASE_COLOR RGBACOLOR(30, 30, 30, 1)

#define QYQHEXCOLOR_ALPHA(c, a) [UIColor colorWithHexValue:c alpha:a]

#define QYQHEXCOLOR(c) QYQHEXCOLOR_ALPHA(c,1)

#define BASE_GREEN_COLOR QYQHEXCOLOR_ALPHA(0x33db61, 1)

#define BASE_FONT_COLOR RGBACOLOR(128, 128, 128, 1)

#define BASE_VC_COLOR QYQHEXCOLOR_ALPHA(0xefeef4, 1)

#define BASE_6_COLOR QYQHEXCOLOR(0x666666)

#define BASE_3_COLOR QYQHEXCOLOR(0x333333)

#define BASE_9_COLOR QYQHEXCOLOR(0x999999)

#define BASE_CELL_LINE_COLOR QYQHEXCOLOR(0xdddddd)

#define QYQCOLOR_ALPHA(r, g, b, a)                                             \
[UIColor colorWithRed:(r) / 255.0                                            \
green:(g) / 255.0                                            \
blue:(b) / 255.0                                            \
alpha:a * 1.0]

#define TimeLineCellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]

#endif /* SaplingColorDefine_h */
