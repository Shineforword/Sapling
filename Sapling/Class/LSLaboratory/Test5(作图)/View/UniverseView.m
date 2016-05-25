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
    
    /** 画圆*/
    [[UIColor redColor] setStroke];
    UIBezierPath * cycle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                         radius:self.frame.size.height/2
                                                     startAngle:0
                                                       endAngle:M_PI * 2
                                                      clockwise:YES];
    cycle.lineWidth = 0.7;
    
    [cycle stroke];
    
    UIBezierPath * cycle1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/4)
                                                           radius:self.frame.size.height/4
                                                       startAngle:M_PI_2
                                                         endAngle:M_PI*1.5
                                                        clockwise:YES];
    cycle1.lineWidth = 0.7;
    
    [cycle1 stroke];
    
    UIBezierPath * cycle2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height*3/4)
                                                           radius:self.frame.size.height/4
                                                       startAngle:M_PI_2
                                                         endAngle:M_PI * 1.5
                                                        clockwise:NO];
    cycle2.lineWidth = 0.7;
    
    [cycle2 stroke];
    
    
    UIBezierPath * cycle3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height*3/4)
                                                           radius:self.frame.size.height/8
                                                       startAngle:0
                                                         endAngle:M_PI * 2
                                                        clockwise:NO];
    cycle3.lineWidth = 0.7;
    
    [cycle3 stroke];
    
    UIBezierPath * cycle4 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/4)
                                                           radius:self.frame.size.height/8
                                                       startAngle:0
                                                         endAngle:M_PI * 2
                                                        clockwise:NO];
    cycle4.lineWidth = 0.7;
    
    [cycle4 stroke];

    
    
  
    
    
}

@end
