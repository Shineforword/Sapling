//
//  UniverseView.m
//  Sapling
//
//  Created by sport on 16/5/25.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "UniverseView.h"

@implementation UniverseView

- (void)drawRect:(CGRect)rect{
    
    CGFloat W = rect.size.width;
    CGFloat H = rect.size.height;

    /** 画圆*/
    [[UIColor redColor] setStroke];
    UIBezierPath * cycle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(W/2, H/2)
                                                         radius:H/2
                                                     startAngle:0
                                                       endAngle:M_PI * 2
                                                      clockwise:YES];
    cycle.lineWidth = 0.7;
    
    [cycle stroke];
    
    /** 半圆*/
    [[UIColor whiteColor] setStroke];
    UIBezierPath * cycle1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(W/2, H/4)
                                                           radius:H/4
                                                       startAngle:M_PI_2
                                                         endAngle:M_PI*1.5
                                                        clockwise:YES];
    cycle1.lineWidth = 0.7;
    [cycle1 stroke];
    
    /** 半圆*/
    [[UIColor orangeColor] setStroke];
    UIBezierPath * cycle2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(W/2, H*3/4)
                                                           radius:H/4
                                                       startAngle:M_PI_2
                                                         endAngle:M_PI * 1.5
                                                        clockwise:NO];
    cycle2.lineWidth = 0.7;
    [cycle2 stroke];
    
    /** 小圆*/
    [[UIColor greenColor] setStroke];
    UIBezierPath * cycle3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(W/2, H*3/4)
                                                           radius:H/8
                                                       startAngle:0
                                                         endAngle:M_PI * 2
                                                        clockwise:NO];
    cycle3.lineWidth = 0.7;
    [cycle3 stroke];
    
    /** 小圆*/
    [[UIColor greenColor] setStroke];
    UIBezierPath * cycle4 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(W/2, H/4)
                                                           radius:H/8
                                                       startAngle:0
                                                         endAngle:M_PI * 2
                                                        clockwise:NO];
    cycle4.lineWidth = 0.7;
    [cycle4 stroke];

    
    /** 圆角矩形*/
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, W-40, H-40)
                                                        cornerRadius:10];
    rectPath.lineWidth = 0.7;
    [rectPath stroke];
    /** 部分圆角矩形*/
    UIBezierPath *rectPath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10,W-20,H-20)
                                                    byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomRight)
                                                          cornerRadii:CGSizeMake(10, 0)];
    rectPath1.lineWidth = 0.7;
    [rectPath1 stroke];
}

@end
