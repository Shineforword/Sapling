//
//  LSAnimationlineView.m
//  Sapling
//
//  Created by sport on 16/5/26.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSAnimationlineView.h"

@interface LSAnimationlineView()
{
    CABasicAnimation *pathAnimation;
}



@property (nonatomic, retain) CAShapeLayer *animationLayer;
@property (nonatomic, retain) CAShapeLayer *animationLayer1;

@property (nonatomic, strong) UIButton * btn;

@end
@implementation LSAnimationlineView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
      
        [self setupView];
    }
    
    return self;
}
- (void)setupView{
    
    /** 画线*/
    _btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setTitle:@"画线" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
    _btn.sd_layout
    .topSpaceToView(self,20)
    .leftSpaceToView(self,10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(20);
    
}
- (void)buttonClicked{
    
    
    [self line];
    
    [self.animationLayer removeAllAnimations];
    [self.animationLayer1 removeAllAnimations];
    
    pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.delegate = self;
    pathAnimation.duration = 5.0;
    pathAnimation.fromValue = @0;
    pathAnimation.toValue = @1;
    
    [self.animationLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    [self.animationLayer1 addAnimation:pathAnimation forKey:@"strokeEnd"];
    
}
- (void)line{
    [self.animationLayer removeFromSuperlayer];
    self.animationLayer = nil;
    
    [self.animationLayer1 removeFromSuperlayer];
    self.animationLayer1 = nil;
    
    CGPoint a = CGPointMake(_btn.center.x, _btn.center.y + 50);
    
    CGPoint b = CGPointMake(_btn.center.x - 50, _btn.center.y + 20);
    
    CGPoint c = CGPointMake(_btn.center.x - 110, _btn.center.y + 20);
    
    CGPoint d = CGPointMake(_btn.center.x - 50, _btn.center.y + 80);
    
    CGPoint e = CGPointMake(_btn.center.x - 110, _btn.center.y + 80);
    
    CGPoint f  = CGPointMake(_btn.center.x - 160, _btn.center.y + 50);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:a];
    [path addLineToPoint:b];
    [path addLineToPoint:c];
    [path addLineToPoint:f];
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:a];
    [path1 addLineToPoint:d];
    [path1 addLineToPoint:e];
    [path1 addLineToPoint:f];
    
    
    
    
    CAShapeLayer *pathLayer1 = [CAShapeLayer layer];
    pathLayer1.path = path1.CGPath;
    pathLayer1.strokeColor = [[UIColor redColor] CGColor];
    pathLayer1.fillColor = nil;
    pathLayer1.lineWidth = 0.7f;
    pathLayer1.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:pathLayer1];
    self.animationLayer1 = pathLayer1;
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor redColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 0.7f;
    pathLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:pathLayer];
    self.animationLayer = pathLayer;
}

@end
