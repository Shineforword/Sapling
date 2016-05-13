//
//  LSListViewController.h
//  Sapling
//
//  Created by sport on 16/5/12.
//  Copyright © 2016年 光前. All rights reserved.
//
#import "LSBaseUIViewController.h"

/** 刷新表格类*/
@interface LSListViewController : LSBaseUIViewController
/** 表*/
@property (nonatomic ,strong) UITableView  *tableView;

/** 载入数据*/
- (void)loadData;
/** 加载更多数据*/
- (void)loadMoreData;

/** 建立表格UI*/
- (void)setUpUI;
/** 开始刷新*/
- (void)beginRefreshAnimation;
/* 结束刷新*/
- (void)endRefreshAnimation;

@end
