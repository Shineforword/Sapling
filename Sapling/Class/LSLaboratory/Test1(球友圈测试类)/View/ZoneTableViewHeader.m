//
//  ZoneTableViewHeader.m
//  Sapling
//
//  Created by sport on 16/5/12.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "ZoneTableViewHeader.h"

@interface ZoneTableViewHeader ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIButton * editButton;
@property (nonatomic, strong) UIButton * photoButton;
@property (nonatomic, strong) SDCycleScrollView * cycleView;
@end

@implementation ZoneTableViewHeader

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}

- (void)setUpUI{
    
    self.backgroundColor = BASE_VC_COLOR;
    
    _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editButton setBackgroundColor:BASE_GREEN_COLOR];
    
    _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_photoButton setBackgroundColor:BASE_GREEN_COLOR];
    
    _cycleView = [[SDCycleScrollView alloc]init];
    _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _cycleView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_editButton];
    [self addSubview:_photoButton];
    [self addSubview:_cycleView];
    
    CGFloat margin = 5;
    
    _editButton.sd_layout
    .leftSpaceToView(self,margin*2)
    .topSpaceToView(self,margin)
    .widthIs((SCREEN_WIDTH-margin*4)/2)
    .heightIs(30);
    
    _photoButton.sd_layout
    .leftSpaceToView(_editButton,margin)
    .topSpaceToView(self,margin)
    .widthIs((SCREEN_WIDTH-margin*5)/2)
    .heightIs(30);
    
    _cycleView.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(_editButton,margin)
    .widthIs(SCREEN_WIDTH)
    .heightIs(160);
    
    
    [_editButton setTitle:@"状态" forState:UIControlStateNormal];
    [_photoButton setTitle:@"照片" forState:UIControlStateNormal];
//    NSArray * cycleArray = [[NSArray alloc]initWithObjects:@"",@"", nil];
//    /** 网络url数组*/
//    _cycleView.imageURLStringsGroup = cycleArray;
    NSMutableArray * locationImages = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < 5 ; i ++ ) {
        int r  = arc4random_uniform(255);
        int g   = arc4random_uniform(255);
        int b  = arc4random_uniform(255);
        UIImage * image =   [UIImage imageWithColor:QYQCOLOR(r, g, b)];
        [locationImages addObject:image];
    }
    _cycleView.localizationImageNamesGroup = locationImages;
    _cycleView.currentPageDotColor = BASE_GREEN_COLOR;
    
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}
@end
