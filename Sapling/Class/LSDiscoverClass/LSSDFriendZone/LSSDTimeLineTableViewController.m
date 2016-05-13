//
//  LSSDTimeLineTableViewController.m
//  Sapling
//
//  Created by sport on 16/5/10.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSSDTimeLineTableViewController.h"
#import "SDRefresh.h"

#import "SDTimeLineRefreshHeader.h"
#import "SDTimeLineRefreshFooter.h"

#import "SDTimeLineTableHeaderView.h"
#import "SDTimeLineCell.h"
#import "SDTimeLineCellModel.h"


#define kTimeLineTableViewCellId @"SDTimeLineCell"

@implementation LSSDTimeLineTableViewController

{
    SDTimeLineRefreshFooter *_refreshFooter;
    SDTimeLineRefreshHeader *_refreshHeader;
    CGFloat _lastScrollViewOffsetY;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //简单点说就是automaticallyAdjustsScrollViewInsets
    //根据按所在界面的status bar，navigationbar，与tabbar的高度，自动调整scrollview的 inset,设置为no，
    //不让viewController调整，我们自己修改布局即可~
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //edgesForExtendedLayout是一个类型为UIExtendedEdge的属性，指定边缘要延伸的方向。
    //因为iOS7鼓励全屏布局，它的默认值很自然地是UIRectEdgeAll，四周边缘均延伸，就是说，
    //如果即使视图中上有navigationBar，下有tabBar，那么视图仍会延伸覆盖到四周的区域。
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    [self.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
    
    __weak typeof(self) weakSelf = self;
    // 上拉加载
    _refreshFooter = [SDTimeLineRefreshFooter refreshFooterWithRefreshingText:@"正在加载数据..."];
    __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
    [_refreshFooter addToScrollView:self.tableView refreshOpration:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.dataArray addObjectsFromArray:[weakSelf creatModelsWithCount:10]];
            [weakSelf.tableView reloadData];
            [weakRefreshFooter endRefreshing];
        });
    }];
    
    SDTimeLineTableHeaderView *headerView = [SDTimeLineTableHeaderView new];
    headerView.frame = CGRectMake(0, 0, 0, 260);
    self.tableView.tableHeaderView = headerView;
    
    /** 注册单元格*/
    [self.tableView registerClass:[SDTimeLineCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!_refreshHeader.superview) {
        
        _refreshHeader = [SDTimeLineRefreshHeader refreshHeaderWithCenter:CGPointMake(40, 45)];
        _refreshHeader.scrollView = self.tableView;
        __weak typeof(_refreshHeader) weakHeader = _refreshHeader;
        __weak typeof(self) weakSelf = self;
        [_refreshHeader setRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.dataArray = [[weakSelf creatModelsWithCount:10] mutableCopy];
                [weakHeader endRefreshing];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            });
        }];
        [self.tableView.superview addSubview:_refreshHeader];
    }
}

/** 对象销毁的时候调用(移除一些内容)*/
- (void)dealloc
{
    [_refreshHeader removeFromSuperview];
    [_refreshFooter removeFromSuperview];
}

- (NSArray *)creatModelsWithCount:(NSInteger)count
{
    /** 用户头像数组*/
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    /** 用户姓名数组*/
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    /** 用户发布内容数组*/
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，https://github.com/gsdios/SDAutoLayout大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    /** 用户评论内容数组*/
    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                               @"正宗好凉茶，正宗好声音。。。",
                               @"你好，我好，大家好才是真的好",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                               @"人艰不拆",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你💢💢💢"];
    
    /** 发布的图片资源内容*/
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg",
                                     @"pic7.jpg",
                                     @"pic8.jpg"
                                     ];
    /** 合成整体伪数组*/
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        /** 头像,姓名,内容随机数生成*/
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        /** 生成随机用户内容模型*/
        SDTimeLineCellModel *model = [SDTimeLineCellModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        
        
        /** “随机图片”生成数组*/
        int random = arc4random_uniform(6);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        /** 评论随机数组*/
        int commentRandom = arc4random_uniform(3);
        NSMutableArray *tempComments = [NSMutableArray new];
        for (int i = 0; i < commentRandom; i++) {
            /** 评论模型*/
            SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
           
            /** 小于用户数目的随机数*/
            int index = arc4random_uniform((int)namesArray.count);
            commentItemModel.firstUserName = namesArray[index];
            commentItemModel.firstUserId = @"666";
            /** 随机生成10以内<5的才有评论*/
            if (arc4random_uniform(10) < 5) {
                commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
                commentItemModel.secondUserId = @"888";
            }
            /** 随机评论内容*/
            commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
            [tempComments addObject:commentItemModel];
        }
        
        /** 评论内容模型数组*/
        model.commentItemsArray = [tempComments copy];
        /** 喜欢模型数组*/
//        SDTimeLineCellLikeItemModel * likeItemModel = [[SDTimeLineCellLikeItemModel alloc]init];
//        likeItemModel.userName = @"wang";
//        likeItemModel.userId = @"1000";
//        model.likeItemsArray = @[likeItemModel];
        /** 整体数组*/
        [resArr addObject:model];
    }
    return [resArr copy];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            SDTimeLineCellModel *model = weakSelf.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            //刷新单一cell的方法
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////

    cell.sd_tableView = tableView;
    cell.sd_indexPath = indexPath;
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
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
