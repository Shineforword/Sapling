//
//  LSPhotographyController.m
//  Sapling
//
//  Created by sport on 16/5/18.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSPhotographyController.h"
#import "LSPotographyCell.h"
#import "LSPhotographyCollectionHeaderView.h"


#import "LSZoneOperationView.h"

#define LSPotographyCellID @"LSPotographyCellID"

@interface LSPhotographyController()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
LSZoneOperationViewDelegate>

@property (nonatomic, strong) NSMutableArray * publicArray;
@property (nonatomic, strong) LSZoneOperationView * operationView;


@end

@implementation LSPhotographyController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"摄影大赛";
    
    [self loadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.collectionView) {
        
    }
}

- (void)setupUI{
    
    [super setupUI];
    self.collectionView.backgroundColor = QYQHEXCOLOR(0xf5f5f5);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[LSPotographyCell class] forCellWithReuseIdentifier:LSPotographyCellID];
    [self.collectionView registerClass:[LSPhotographyCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header_ID"];
    /** 不再初始化,直接设置frame*/
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    [self.collectionView reloadData];
    
    _operationView =  [[LSZoneOperationView alloc]init];
    _operationView.delegate = self;
    [self.view addSubview:_operationView];
    [self.view bringSubviewToFront:_operationView];
    _operationView.sd_layout
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.view,10)
    .widthIs(45)
    .heightIs(100);
    
}
#pragma mark - LSZoneBackTopViewDelegate 

/** (scrollsToTop 默认为YES，用户可以单击状态栏滚动至顶部(呵呵)*/
- (void)ZoneOperationViewWith:(KZoneOperationViewType)type{
    
    if (type == KZoneOperationViewTypeBottomButton) {
     
        self.collectionView.contentSize = CGSizeMake(0,0);
    }
}
- (void)loadData{
    
    NSArray * tempArray = [self makeFalseDataSourceWithCount:10];
    self.publicArray = [[NSMutableArray alloc]initWithArray:tempArray];
    [self.collectionView reloadData];
    [self endRefreshAnimation];
}

- (void)loadMoreData{
    NSArray * tempArray = [self makeFalseDataSourceWithCount:10];
    [self.publicArray addObjectsFromArray:tempArray];
    [self.collectionView reloadData];
    [self endRefreshAnimation];
}
- (NSArray *)makeFalseDataSourceWithCount:(NSInteger)count{
    
    /** 伪图片数组*/
    NSMutableArray * photosArray = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < count; i ++ ) {
        CGFloat r = arc4random_uniform(255);
        CGFloat g  = arc4random_uniform(255);
        CGFloat b = arc4random_uniform(255);
        UIImage * image = [UIImage imageWithColor:QYQCOLOR(r, g, b)];
        [photosArray addObject:image];
    }
    return photosArray;
}
#pragma mark - 设置头视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 100);
}
/** 获取Header,自定义须要继承自UICollectionReusableView*/
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = @"header_ID";
    LSPhotographyCollectionHeaderView *cell = (LSPhotographyCollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;
}
#pragma mark - UICollectionViewDataSoure
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - 3*10)/2, 125);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 5, 10);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LSPotographyCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LSPotographyCellID forIndexPath:indexPath];
    cell.image = self.publicArray[indexPath.row];
    return cell;
}

@end
