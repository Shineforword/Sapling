//
//  LSPhotographyCollectionHeaderView.m
//  Sapling
//
//  Created by sport on 16/5/18.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSPhotographyCollectionHeaderView.h"
@interface LSPhotographyCollectionHeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView * cycleView;

@end
@implementation LSPhotographyCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setupUI];
    }
    
    return self;
}
- (void)setupUI{
   
    _cycleView = [[SDCycleScrollView alloc]init];
    _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _cycleView.backgroundColor = [UIColor whiteColor];

    [self addSubview:_cycleView];
    _cycleView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
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
