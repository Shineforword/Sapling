//
//  LSSDContactsTableViewController.m
//  Sapling
//
//  Created by sport on 16/5/10.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSSDContactsTableViewController.h"

#import "LSSDContactModel.h"
#import "LSSDAnalogDataGenerator.h"
#import "LSSDContactsCell.h"

#import "LSSDContactsSearchResultController.h"

/** 测试用*/
#import "LSQiuYouZoneTestController.h"
#import "LSGCDTestController.h"

@interface LSSDContactsTableViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic,strong) NSMutableArray *sectionArray;

@property (nonatomic, strong) NSMutableArray *sectionTitlesArray;

@end

@implementation LSSDContactsTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:[LSSDContactsSearchResultController new]];
    self.searchController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
    
    UISearchBar *bar = self.searchController.searchBar;
    bar.barStyle = UIBarStyleDefault;
    bar.translucent = YES;
    bar.barTintColor = QYQCOLOR(248, 248, 248);
    bar.tintColor = BASE_COLOR;
    UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
    view.layer.borderColor = QYQCOLOR(248, 248, 248).CGColor;
    view.layer.borderWidth = 1;
    bar.layer.borderColor = [UIColor redColor].CGColor;
    
    bar.showsBookmarkButton = YES;
    [bar setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    bar.delegate = self;
    CGRect rect = bar.frame;
    rect.size.height = 44;
    bar.frame = rect;
    
    self.tableView.tableHeaderView = bar;
    self.tableView.rowHeight = [LSSDContactsCell fixedHeight];
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self genDataWithCount:30];
    
    self.tableView.sectionHeaderHeight = 25;
}

- (void)genDataWithCount:(NSInteger)count
{
    
    NSArray *xings = @[@"赵",@"钱",@"孙",@"李",@"周",@"吴",@"郑",@"王",@"冯",@"%",@"楚",@"卫",@"蒋",@"沈",@"#",@"杨"];
    NSArray *ming1 = @[@"大",@"美",@"帅",@"应",@"超",@"海",@"江",@"湖",@"春",@"夏",@"秋",@"冬",@"上",@"左",@"有",@"纯"];
    NSArray *ming2 = @[@"强",@"好",@"领",@"亮",@"超",@"华",@"奎",@"海",@"工",@"青",@"红",@"潮",@"兵",@"垂",@"刚",@"山"];
    
    for (int i = 0; i < count; i++) {
        NSString *name = xings[arc4random_uniform((int)xings.count)];
        NSString *ming = ming1[arc4random_uniform((int)ming1.count)];
        name = [name stringByAppendingString:ming];
        if (arc4random_uniform(10) > 3) {
            NSString *ming = ming2[arc4random_uniform((int)ming2.count)];
            name = [name stringByAppendingString:ming];
        }
        LSSDContactModel *model = [LSSDContactModel new];
        model.name = name;
        model.imageName = [LSSDAnalogDataGenerator randomIconImageName];
        [self.dataArray addObject:model];
    }
    
    
    
    [self setUpTableSection];
}

- (void) setUpTableSection {
    /**该方法是使用UILocalizedIndexedCollation来进行本地化下按首字母分组排序的，
     是建立在对对象的操作上的。
     不同于以前的那些比如把汉字转成拼音再排序的方法了，效率不高，同时很费内存。
     但该方法有一个缺点就是不能区分姓氏中的多音字，
     比如“曾”会被分到"C"组去*/
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    //create a temp sectionArray
    
    /** 得出collation索引的数量，这里是27个（26个字母和1个#）*/
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    /**初始化一个数组newSectionsArray用来存放最终的数据，
     我们最终要得到的数据模型应该形如
     @[
     @[以A开头的数据数组],
     @[以B开头的数据数组],
     @[以C开头的数据数组], ... 
     @[以#(其它)开头的数据数组]
     ]*/
    /**初始化27个空数组加入newSectionsArray*/
    NSMutableArray *newSectionArray =  [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index<numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc]init]];
    }
    // insert Persons info into newSectionArray
    /** 将每个名字分到某个section下*/
    for (LSSDContactModel *model in self.dataArray) {
        //获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(name)];
        //把name为“林丹”的p加入newSectionsArray中的第11个数组中去
        [newSectionArray[sectionIndex] addObject:model];
    }
    
    //sort the person of each section
    //对每个section中的数组按照name属性排序
    for (NSUInteger index=0; index<numberOfSections; index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(name)];
        newSectionArray[index] = sortedPersonsForSection;
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    self.sectionTitlesArray = [NSMutableArray new];
    
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {
            [temp addObject:arr];
        } else {
            [self.sectionTitlesArray addObject:[collation sectionTitles][idx]];
        }
    }];
    
    [newSectionArray removeObjectsInArray:temp];
    
    NSMutableArray *operrationModels = [NSMutableArray new];
    NSArray *dicts = @[@{@"name" : @"新的朋友(测试用入口 + GSD朋友圈)", @"imageName" : @"plugins_FriendNotify"},
                       @{@"name" : @"群聊(GCD测试用入口)", @"imageName" : @"add_friend_icon_addgroup"},
                       @{@"name" : @"标签", @"imageName" : @"Contact_icon_ContactTag"},
                       @{@"name" : @"公众号", @"imageName" : @"add_friend_icon_offical"}];
    for (NSDictionary *dict in dicts) {
        LSSDContactModel *model = [LSSDContactModel new];
        model.name = dict[@"name"];
        model.imageName = dict[@"imageName"];
        [operrationModels addObject:model];
    }
    
    [newSectionArray insertObject:operrationModels atIndex:0];
    [self.sectionTitlesArray insertObject:@"" atIndex:0];
    
    self.sectionArray = newSectionArray;
    
}

#pragma mark - tableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"LSSDContactsCell";
    LSSDContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSSDContactsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    LSSDContactModel *model = self.sectionArray[section][row];
    cell.model = model;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionTitlesArray objectAtIndex:section];
}


- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionTitlesArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        LSQiuYouZoneTestController * zoneVC = [[LSQiuYouZoneTestController alloc]init];
        zoneVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:zoneVC animated:YES];

    }
    if(indexPath.section == 0 && indexPath.row == 1){
        LSGCDTestController * gcdTestVC = [[LSGCDTestController alloc]init];
        gcdTestVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:gcdTestVC animated:YES];
    }
}




#pragma mark - UISearchBarDelegate

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    
}



@end
