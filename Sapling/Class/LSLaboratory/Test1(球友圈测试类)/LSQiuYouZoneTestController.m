//
//  LSQiuYouZoneTestController.m
//  Sapling
//
//  Created by sport on 16/5/12.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSQiuYouZoneTestController.h"
#import "ZoneTableViewHeader.h"
#import "LSQiuYouZoneTestCell.h"
#import "LSQiuYouZoneModel.h"
#define LSQiuYouZoneTestCellID @"LSQiuYouZoneTestCell"
@interface LSQiuYouZoneTestController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * publicArray;
@end

@implementation LSQiuYouZoneTestController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.navigationItem.title = @"小乘佛法";
    [self loadData];
}
#pragma mark - 重写父类的方法
- (void)setUpUI{
    [super setUpUI];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
     self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49);
    ZoneTableViewHeader * zoneHeader = [[ZoneTableViewHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.tableView.tableHeaderView = zoneHeader;
    /** tableview的实际显示位置*/
    self.tableView.contentOffset = CGPointMake(0, 40);
    /** 注册单元格*/
    [self.tableView registerClass:[LSQiuYouZoneTestCell class] forCellReuseIdentifier:LSQiuYouZoneTestCellID];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
- (void)loadData{
    NSArray * temp = [self creatModelsWithCount:10];
    _publicArray = [[NSMutableArray alloc]initWithArray:temp];
    [self.tableView reloadData];
    [self endRefreshAnimation];
}

- (void)loadMoreData{
   NSArray * temp = [self creatModelsWithCount:10];
    [_publicArray addObjectsFromArray:temp];
    [self.tableView reloadData];
    [self endRefreshAnimation];

    
}
/** 伪造数据*/
- (NSArray *)creatModelsWithCount:(NSInteger)count{
    /** 名字*/
    NSMutableArray * names = [[NSMutableArray alloc]init];
    NSArray * familys = @[@"王",@"钱",@"孙",@"李"];
    NSArray * middles = @[@"天",@"仲",@"玄",@"候"];
    NSArray * lasts = @[@"飒",@"山",@"韩",@"楚"];
    for (int i = 0 ; i < 5; i ++ ) {
        int r = arc4random_uniform(3);
        int g  = arc4random_uniform(3);
        int b = arc4random_uniform(3);
        NSString * nameStr = [NSString stringWithFormat:@"%@%@%@",familys[r],middles[g],lasts[b]];
        [names addObject:nameStr];
    }
  
    NSMutableArray * contentsArray = [[NSMutableArray alloc]init];
    NSArray * contentFalses = @[@"蜀道难,难于上青天",
                                @"蜀道难,难于上青天,蚕丛及鱼凫开国何茫然,尔来四万八千岁,不与秦塞通人烟,西当太白有鸟道,可以横绝峨眉巅.蜀道难,难于上青天,蚕丛及鱼凫开国何茫然,尔来四万八千岁,不与秦塞通人烟,西当太白有鸟道,可以横绝峨眉巅.蜀道难,难于上青天,蚕丛及鱼凫开国何茫然,尔来四万八千岁,不与秦塞通人烟,西当太白有鸟道,可以横绝峨眉巅.",
                                @"归去来兮,田园将芜胡不归",
                                @"将进酒,杯莫停",
                                @"",
                                ];
    for (int i = 0 ; i < 5; i++) {
        int r = arc4random_uniform(4);
        [contentsArray addObject:contentFalses[r]];
    }

    /** 最终数组*/
    NSMutableArray * resultArray = [[NSMutableArray alloc]init];
    for (int i  = 0 ; i < count ;  i ++ ) {
        int r = arc4random_uniform(4);
        NSMutableDictionary * per = [[NSMutableDictionary alloc]init];
        per[@"name"] = names[r];
        per[@"contentStr"] = contentsArray[r];
        [resultArray addObject:per];
    }
    /** 转化模型*/
    NSArray * res = [LSQiuYouZoneModel mj_objectArrayWithKeyValuesArray:resultArray];
    return res;
}
#pragma mark - UITableView的delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    /** 注意keyPath设置*/
    id model = self.publicArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath
                                            model:model
                                          keyPath:@"model"
                                        cellClass:[LSQiuYouZoneTestCell class]
                                 contentViewWidth:[self cellContentViewWith]];}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSQiuYouZoneTestCell *cell = [tableView dequeueReusableCellWithIdentifier:LSQiuYouZoneTestCellID];
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            LSQiuYouZoneModel *model = weakSelf.publicArray[indexPath.row];
            model.isOpening = !model.isOpening;
            //刷新单一cell的方法
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    /** 流畅*/
    cell.sd_tableView = tableView;
    cell.sd_indexPath = indexPath;
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

@end
