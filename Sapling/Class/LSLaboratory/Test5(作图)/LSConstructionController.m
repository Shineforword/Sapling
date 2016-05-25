
//
//  LSConstructionController.m
//  Sapling
//
//  Created by sport on 16/5/25.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSConstructionController.h"

#import "UniverseView.h"
#import "CustomLine.h"

@interface LSConstructionController ()
{
    CABasicAnimation *pathAnimation;
    BOOL isOver;
    UILabel *nameLabel;
    UILabel *titleLabel;
}



@property (nonatomic, retain) CAShapeLayer *animationLayer;
@property (nonatomic, retain) CAShapeLayer *animationLayer1;
@property (nonatomic, strong) UIButton * btn;

@end

@implementation LSConstructionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"作图";
    /** 基于背景frame大小划线*/
    /** 测试斜线*/
    UIView * backgroundView1 = [[UIView alloc]init];
    backgroundView1.backgroundColor = BASE_9_COLOR;
    [self.view addSubview:backgroundView1];
    
    UIView * backgroundView2 = [[UIView alloc]init];
    backgroundView2.backgroundColor = BASE_9_COLOR;
    [self.view addSubview:backgroundView2];

    
    CustomLine * line = [[CustomLine alloc]init];
    line.backgroundColor = BASE_9_COLOR;
    UILabel * temp = [[UILabel alloc]init];
    temp.text = @"人世间最美好的事情,不是我站在";
    temp.textColor = BASE_GREEN_COLOR;
    temp.font = [UIFont systemFontOfSize:10];
    
    [backgroundView1 addSubview:line];
    [backgroundView1  addSubview:temp];
    
    
    backgroundView1.sd_layout
    .topSpaceToView(self.view,20)
    .leftSpaceToView(self.view ,10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(100);
    
    backgroundView2.sd_layout
    .topSpaceToView(backgroundView1,20)
    .leftSpaceToView(self.view ,10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(100);

    temp.sd_layout
    .topSpaceToView(backgroundView1,10)
    .leftSpaceToView(backgroundView1,10)
    .widthIs(backgroundView1.frame.size.width - 20)
    .heightIs(10);
    line.frame = backgroundView1.frame;
    
    UniverseView * Universe = [[UniverseView alloc]init];
    Universe.backgroundColor = BASE_9_COLOR;
    [backgroundView2 addSubview:Universe];
    Universe.frame = backgroundView2.frame;
    
    /** 画线*/
    _btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setTitle:@"画线" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    _btn.sd_layout
    .topSpaceToView(backgroundView2,20)
    .leftSpaceToView(self.view,10)
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
    
    CGPoint a = CGPointMake(_btn.center.x, _btn.center.y + 100);
    
    CGPoint b = CGPointMake(_btn.center.x - 50, _btn.center.y + 20);
    
    CGPoint c = CGPointMake(_btn.center.x - 110, _btn.center.y + 20);
    
    CGPoint d = CGPointMake(_btn.center.x - 50, _btn.center.y + 180);
    
    CGPoint e = CGPointMake(_btn.center.x - 110, _btn.center.y + 180);
    
    CGPoint f  = CGPointMake(_btn.center.x - 160, _btn.center.y + 100);

    
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
    
    [self.view.layer addSublayer:pathLayer1];
    self.animationLayer1 = pathLayer1;
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor redColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 0.7f;
    pathLayer.lineJoin = kCALineJoinRound;
    
    [self.view.layer addSublayer:pathLayer];
    self.animationLayer = pathLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
