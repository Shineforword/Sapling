
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

@end

@implementation LSConstructionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
