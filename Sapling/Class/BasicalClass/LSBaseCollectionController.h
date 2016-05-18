//
//  LSBaseCollectionController.h
//  Sapling
//
//  Created by sport on 16/5/18.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSBaseUIViewController.h"

@interface LSBaseCollectionController : LSBaseUIViewController
/** 集合视图*/
@property (nonatomic, strong) UICollectionView * collectionView;

/** 载入数据*/
- (void)loadData;
/** 加载更多数据*/
- (void)loadMoreData;

/** 建立集合视图UI*/
- (void)setupUI;
/** 开始刷新*/
- (void)beginRefreshAnimation;
/* 结束刷新*/
- (void)endRefreshAnimation;

@end
