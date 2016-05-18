//
//  LSPhotographyController.m
//  Sapling
//
//  Created by sport on 16/5/18.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSPhotographyController.h"
#import "LSPotographyCell.h"

#define LSPotographyCellID @"LSPotographyCellID"

@interface LSPhotographyController()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray * publicArray;

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

- (void)setupUI{
    
    [super setupUI];
   
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[LSPotographyCell class] forCellWithReuseIdentifier:LSPotographyCellID];
    
    /** 不再初始化,直接设置frame*/
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    [self.collectionView reloadData];
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

#pragma mark - UICollectionViewDataSoure
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - 3*10)/2, 100);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2.5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LSPotographyCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LSPotographyCellID forIndexPath:indexPath];
    cell.image = self.publicArray[indexPath.row];
    return cell;
}

@end
