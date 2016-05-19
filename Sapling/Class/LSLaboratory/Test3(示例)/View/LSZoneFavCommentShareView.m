//
//  LSZoneFavCommentShareView.m
//  Sapling
//
//  Created by sport on 16/5/19.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSZoneFavCommentShareView.h"

@interface LSZoneFavCommentShareView()

@property (nonatomic, strong) NSMutableArray * buttonArray;

@end
@implementation LSZoneFavCommentShareView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
     
        [self setupView];
        
    }
    
    return self;
}
- (void)setupView{
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_9_COLOR;
    [self addSubview:line];
    line.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(0.7);
    CGFloat buttonWidth = SCREEN_WIDTH/3;
    for (int i = 0;  i < 3; i ++ ) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        button.sd_layout
        .topSpaceToView(line,0)
        .leftSpaceToView(self,(0 + i) * buttonWidth)
        .widthIs(buttonWidth)
        .heightIs(30);
        [self.buttonArray addObject:button];
    }
}
- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [_titleArray enumerateObjectsUsingBlock:^(NSString *  str , NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * tagBtn = self.buttonArray[idx];
        [tagBtn setTitle:str forState:UIControlStateNormal];
        [tagBtn setTitleColor:BASE_6_COLOR forState:UIControlStateNormal];
        [tagBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }];
}
@end
