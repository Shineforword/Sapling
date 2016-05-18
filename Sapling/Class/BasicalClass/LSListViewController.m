//
//  LSListViewController.m
//  Sapling
//
//  Created by sport on 16/5/12.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSListViewController.h"

@implementation LSListViewController

#pragma mark - Controller - Basical - Method
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self setUpUI];
}
#pragma mark - Super - Method
- (void)setUpUI{
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    //下拉刷新动画设置
    NSArray * idleImages = @[[UIImage imageNamed:@"ah_0"]];
    
    NSArray * pullingImages = @[[UIImage imageNamed:@"ah_0"]];
    
    NSMutableArray * refreshingImages = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < 8; i ++ ) {
      
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"ah_%d",i]];
    
        [refreshingImages addObject:image];
    }
    
    [((MJRefreshGifHeader *)self.tableView.mj_header) setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [((MJRefreshGifHeader *)self.tableView.mj_header) setImages:pullingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [((MJRefreshGifHeader *)self.tableView.mj_header) setImages:refreshingImages forState:MJRefreshStateRefreshing];
   
    //hide time
    ((MJRefreshStateHeader *)self.tableView.mj_header).lastUpdatedTimeLabel.hidden = YES;
    
    //马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    [self.tableView reloadData];

}
#pragma mark - Custom Func - (子类中重写调用)
- (void)loadData{
    
}

- (void)loadMoreData{
    
}
#pragma mark - Accessor

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   CGRectGetWidth(self.view.frame),
                                                                   CGRectGetHeight(self.view.frame))
                                                  style:UITableViewStylePlain];
        /** 防止没有数据时显示表的一些线*/
        [_tableView setTableFooterView:[UIView new]];
    }
    return _tableView;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self endRefreshAnimation];
}

- (void)endRefreshAnimation{
   
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)beginRefreshAnimation{
    
    [self.tableView.mj_header beginRefreshing];
}
/** 销毁时候调用*/
- (void)dealloc
{
    
}
@end
