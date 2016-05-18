//
//  LSBaseCollectionController.m
//  Sapling
//
//  Created by sport on 16/5/18.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSBaseCollectionController.h"
@interface LSBaseCollectionController()
@end

@implementation LSBaseCollectionController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self endRefreshAnimation];
}
- (void)setupUI{
    
    [self.view addSubview:self.collectionView];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
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
    
    [((MJRefreshGifHeader *)self.collectionView.mj_header) setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [((MJRefreshGifHeader *)self.collectionView.mj_header) setImages:pullingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [((MJRefreshGifHeader *)self.collectionView.mj_header) setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    //hide time
    ((MJRefreshStateHeader *)self.collectionView.mj_header).lastUpdatedTimeLabel.hidden = YES;
    
    //马上进入刷新状态
    [self.collectionView.mj_header beginRefreshing];
    
    [self.collectionView reloadData];

}

#pragma mark - Custom Func - (子类中重写调用)
- (void)loadData{
    
}

- (void)loadMoreData{
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                collectionViewLayout:layout];
        self.collectionView.backgroundColor = BASE_VC_COLOR;
    }
    return _collectionView;
}

- (void)endRefreshAnimation{
    
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

- (void)beginRefreshAnimation{
    
    [self.collectionView.mj_header beginRefreshing];
}

/** 销毁时候调用*/
- (void)dealloc
{
    
}

@end
