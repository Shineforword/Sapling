//
//  LSZoneBackTopView.m
//  Sapling
//
//  Created by sport on 16/5/18.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSZoneOperationView.h"

@interface LSZoneOperationView ()

@property (nonatomic, strong) UIButton * operationOne;
@property (nonatomic, strong) UIButton * operationTwo;

@end
@implementation LSZoneOperationView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setupView];
    }
    
    return self;
}

- (void)setupView{
   
    _operationOne = [UIButton buttonWithType:UIButtonTypeCustom];
    _operationOne.backgroundColor = QYQHEXCOLOR_ALPHA(0x000000, 0.5);
    _operationOne.clipsToBounds = YES;
    _operationOne.layer.cornerRadius = 16;
    
    _operationTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    _operationTwo.backgroundColor = QYQHEXCOLOR_ALPHA(0x000000, 0.5);
    _operationTwo.layer.cornerRadius = 16;

    NSArray * subViews = @[_operationOne,_operationTwo];
    [self sd_addSubviews:subViews];
    
    
    /** 布局*/
    _operationOne.sd_layout
    .leftSpaceToView(self,13)
    .topSpaceToView(self,10)
    .widthIs(32)
    .heightIs(32);
    
    _operationTwo.sd_layout
    .leftSpaceToView(self,13)
    .topSpaceToView(_operationOne,16)
    .widthIs(32)
    .heightIs(32);
    
    _operationOne.tag = 1;
    _operationTwo.tag = 2;

    [_operationOne addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_operationTwo addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)buttonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(ZoneOperationViewWith:)]) {
        [self.delegate ZoneOperationViewWith:button.tag];
    }
}
@end
