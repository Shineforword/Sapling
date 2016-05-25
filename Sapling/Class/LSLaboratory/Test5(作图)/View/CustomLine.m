//
//  CustomLine.m
//  Sapling
//
//  Created by sport on 16/5/25.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "CustomLine.h"

@implementation CustomLine

- (void)drawRect:(CGRect)rect{
    
    /** 线条1:左->右,对角线*/
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 0.7);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 70.0 / 255.0, 241.0 / 255.0, 241.0 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);  //起点坐标
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);   //终点坐标
    CGContextStrokePath(context);
#pragma mark - 一阶
    /** 线条2:右->左,对角线*/
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(0,self.frame.size.height)];
    [path2 addLineToPoint:CGPointMake(self.frame.size.width,0)];
    [path2 stroke];
    
    /** 线条3:下中->上中,对角线*/
    [BASE_GREEN_COLOR setStroke];
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    path3.lineWidth = 0.7;
    
    /** 设置线头两端为圆角*/
    path3.lineCapStyle = kCGLineCapRound;
    [path3 moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height)];
    [path3 addLineToPoint:CGPointMake(self.frame.size.width/2, 0)];
    [path3 stroke];
    
#pragma mark - 二阶
    
    /** 线条4:左上->左下,抛物线(小)*/
    [[UIColor redColor] setStroke];
    UIBezierPath * path4 = [UIBezierPath bezierPath];
    path4.lineWidth = 0.7;
    [path4 moveToPoint:CGPointMake(0, 0)];
    /** CurveToPoint 结束点*/
    /** controlPoint 控制点*/
    [path4 addQuadCurveToPoint:CGPointMake(0, self.frame.size.height)
                  controlPoint:CGPointMake(self.frame.size.width/2,self.frame.size.height/2)];
    [path4 stroke];
    
    /** 线条5:左上->左下,抛物线(大)*/
    [[UIColor redColor] setStroke];
    UIBezierPath * path5 = [UIBezierPath bezierPath];
    path5.lineWidth = 0.7;
    [path5 moveToPoint:CGPointMake(0, 0)];
    /** CurveToPoint 结束点*/
    /** controlPoint 控制点:(x/2)*/
    [path5 addQuadCurveToPoint:CGPointMake(0, self.frame.size.height)
                  controlPoint:CGPointMake(self.frame.size.width,self.frame.size.height/2)];
    [path5 stroke];

    
#pragma mark - 三阶
    /** 线条6:上中->右下,曲线(大)*/
    [[UIColor redColor] setStroke];
    UIBezierPath *path6 = [UIBezierPath bezierPath];
    path6.lineWidth = 0.7;
    [path6 moveToPoint:CGPointMake(self.frame.size.width/2, 0)];
    
    [path6 addCurveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)
             controlPoint1:CGPointMake(self.frame.size.width *3/4,self.frame.size.height/4)
             controlPoint2:CGPointMake(self.frame.size.width *3/4,self.frame.size.height*3/4)];
    
    [path6 stroke];
    
    
#pragma mark - 画圆
    [[UIColor redColor] setStroke];
    UIBezierPath *cycle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                         radius:self.frame.size.height/2
                                                     startAngle:0
                                                       endAngle:M_PI * 2
                                                      clockwise:YES];
    cycle.lineWidth = 0.7;
    
    [cycle stroke];
    
    [[UIColor redColor] setStroke];
    
    UIBezierPath * cycle1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/4)
                                                         radius:self.frame.size.height/4
                                                     startAngle:M_PI_2
                                                       endAngle:M_PI*1.5
                                                      clockwise:YES];
    cycle1.lineWidth = 0.7;
    
    [cycle1 stroke];
    
    [[UIColor redColor] setStroke];
    
    UIBezierPath * cycle2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height*3/4)
                                                           radius:self.frame.size.height/4
                                                       startAngle:M_PI_2
                                                         endAngle:M_PI * 1.5
                                                        clockwise:NO];
    cycle2.lineWidth = 0.7;
    
    [cycle2 stroke];
}

@end
