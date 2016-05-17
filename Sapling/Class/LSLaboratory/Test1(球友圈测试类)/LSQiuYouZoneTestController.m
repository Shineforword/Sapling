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
#import "YMReplyInputView.h"

#import "MLLinkLabel.h"
#import "LSSDTimeLineTableViewController.h"

#define LSQiuYouZoneTestCellID @"LSQiuYouZoneTestCell"
@interface LSQiuYouZoneTestController()<UITableViewDelegate,UITableViewDataSource,RePlayInputViewDelegate,ZoneTableViewHeaderDelegate>
@property (nonatomic, strong) NSMutableArray * publicArray;
@property (nonatomic, strong) YMReplyInputView * replyView;

@end

@implementation LSQiuYouZoneTestController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.navigationItem.title = @"哈哈哈哈";
    [self loadData];
}
#pragma mark - 重写父类的方法
- (void)setUpUI{
    [super setUpUI];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
     self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49);
    ZoneTableViewHeader * zoneHeader = [[ZoneTableViewHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    zoneHeader.delegate = self;
    self.tableView.tableHeaderView = zoneHeader;
    /** tableview的实际显示位置*/
    self.tableView.contentOffset = CGPointMake(0, 40);
    /** 注册单元格*/
    [self.tableView registerClass:[LSQiuYouZoneTestCell class] forCellReuseIdentifier:LSQiuYouZoneTestCellID];

}
- (void)buttonClickedWith:(KHeaderButtonType)type{
    
    if (type == KHeaderButtonTypeEditing) {
        
        LSSDTimeLineTableViewController * LST = [[LSSDTimeLineTableViewController alloc]init];
        [self.navigationController pushViewController:LST animated:YES];
        
    }else if(type == KHeaderButtonTypePhoto){
        
    }
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
    NSArray * familys = @[@"王",@"封",@"曹",@"汾"];
    NSArray * middles = @[@"公",@"伯",@"子",@"男"];
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
                                @"      别思     \n十里平湖霜满天,\n寸寸青丝愁华年.\n对月形单望相护,\n只羡鸳鸯不羡仙.",
                                @"God!",
                                ];
    for (int i = 0 ; i < 5; i++) {
        int r = arc4random_uniform(4);
        [contentsArray addObject:contentFalses[r]];
    }
    
    /** 用户评论内容数组*/
    NSArray *commentsArray = @[@"鹅,鹅,鹅！👌👌👌👌",
                               @"曲项向天歌。。。",
                               @"白毛浮绿水",
                               @"红掌拨清波",
                               @"楼观沧海日？",
                               @"门对浙江潮？？？！！！",
                               @"无间地狱,受命无间者,永生不死,寿长乃此间大劫",
                               @"神说,要有光,于是就有了光",
                               @"曾经有一份真挚的爱情,放在我面前,我没有好好珍惜",
                               @"别以为你长得帅,我就不打你",
                               @"人生若只如初见,何事秋风悲画扇",
                               @"人世间最痛苦的事,不是我站在你面前,你不知道我爱你,而是我...",
                               @"生如夏花之绚烂,死如秋叶之静美💢💢💢",
                               @""];

    /** 最终数组*/
    NSMutableArray * resultArray = [[NSMutableArray alloc]init];
    for (int i  = 0 ; i < count ;  i ++ ) {
        int r = arc4random_uniform(4);
        NSMutableDictionary * per = [[NSMutableDictionary alloc]init];
        per[@"name"] = names[r];
        per[@"contentStr"] = contentsArray[r];
        
        /** 伪图片数组*/
        int photos = arc4random_uniform(9);
        NSMutableArray * photosArray = [[NSMutableArray alloc]init];
        for (int i = 0 ; i < photos; i ++ ) {
            CGFloat r = arc4random_uniform(255);
            CGFloat g  = arc4random_uniform(255);
            CGFloat b = arc4random_uniform(255);
            UIImage * image = [UIImage imageWithColor:QYQCOLOR(r, g, b)];
            [photosArray addObject:image];
        }
        per[@"picNamesArray"] = photosArray;
        
        /** 赞数组*/
        NSArray * tempLikeNames = @[@"魑",@"魅",@"魍",@"魉",@"琴",@"瑟",@"琵",@"琶"];
        int likeRandom = arc4random_uniform(7);
        NSMutableArray * tempLikes = [[NSMutableArray alloc]init];
        for (int i = 0 ;  i < likeRandom ; i ++ ) {
            LSZoneLikeItemModel * likeItemModel = [[LSZoneLikeItemModel alloc]init];
            int index = arc4random_uniform((int)tempLikeNames.count);
            likeItemModel.userName = tempLikeNames[index];
            likeItemModel.userId = @"666";
            [tempLikes addObject:likeItemModel];
        }
        per[@"likeItemsArray"] = [tempLikes copy];
        
        /** 评论随机数组*/
        int commentRandom = arc4random_uniform(3);
        NSMutableArray *tempComments = [NSMutableArray new];
        for (int i = 0; i < commentRandom; i++) {
            LSZoneCommentItemModel *commentItemModel = [[LSZoneCommentItemModel alloc]init];
            int index = arc4random_uniform((int)names.count);
            commentItemModel.firstUserName = names[index];
            commentItemModel.firstUserId = @"666";
            if (arc4random_uniform(10) < 5) {
                commentItemModel.secondUserName = names[arc4random_uniform((int)names.count)];
                commentItemModel.secondUserId = @"888";
            }
            commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
            [tempComments addObject:commentItemModel];
        }
        
        per[@"commentItemsArray"] = [tempComments copy];

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
    /** 展示全文*/
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            LSQiuYouZoneModel *model = weakSelf.publicArray[indexPath.row];
            model.isOpening = !model.isOpening;
            //刷新单一cell的方法
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    /** 更多操作*/
    if (!cell.operationButtonClickedBlock) {
        [cell setOperationButtonClickedBlock:^(NSIndexPath *indexPath) {
            LSQiuYouZoneModel *model = weakSelf.publicArray[indexPath.row];
            model.isOpening = !model.isOpening;
            //刷新单一cell的方法
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    /** 回复*/
    if (!cell.replaySomeBodyBlock) {
        [cell setReplaySomeBodyBlock:^(NSIndexPath *indexPath,LSZoneCommentItemModel * model,NSString * name) {
           
            if (_replyView) {
                return;
            }
            _replyView = [[YMReplyInputView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44 - 64, SCREEN_WIDTH, 44)
                                                    andAboveView:self.view];
            _replyView.delegate = self;
            
            _replyView.indexPath = indexPath;
            _replyView.textViewPlaceHolder.text = [NSString stringWithFormat:@"回复%@:",name];
            _replyView.replayName = name;
            
            [self.view addSubview:_replyView];
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

#pragma mark - RePlayInputViewDelegate - 评论

/** 回复评论:replyText 文本  inputTag:插入位置*/
- (void)YMReplyInputWithReply:(NSString *)replyText appendIndexPath:(NSIndexPath * )inputIndexPath andName:(NSString *)name{
   
    LSZoneCommentItemModel *model = [[LSZoneCommentItemModel alloc]init];
    
    /** 用户*/
    model.firstUserName = @"光前";
    model.firstUserId = @"i love you";
    /** 回复内容*/
    model.commentString = replyText;
    
    /** 被回复者*/
    model.secondUserName = name;
    model.secondUserId = @"i love you";
    
    /** 更新model*/
    LSQiuYouZoneModel * zoneModel = self.publicArray[inputIndexPath.row];
    NSMutableArray * tempArray = [NSMutableArray arrayWithArray:zoneModel.commentItemsArray];
    [tempArray addObject:model];
    zoneModel.commentItemsArray = tempArray;
    
    /** 刷新表*/
    [self.tableView reloadRowsAtIndexPaths:@[inputIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)destoryInputView{
    
    [_replyView removeFromSuperview];
    _replyView = nil;
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
