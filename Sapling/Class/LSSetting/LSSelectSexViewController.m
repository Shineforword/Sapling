//
//  LSSelectSexViewController.m
//  Sapling
//
//  Created by sport on 16/4/21.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSSelectSexViewController.h"
#import "LSBaseTableViewCell.h"

@interface LSSelectSexViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *  _menuTableView;
    BOOL isSelect;
}


@end

@implementation LSSelectSexViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = @"性别";
    
    self.view.backgroundColor = BASE_VC_COLOR;
    
    //初始化性别选选
    ZXUser * user = [ZXCommens fetchUser];
    
    isSelect = [user.gender isEqualToString:@"女"] ? 1 : 0;
    
    self.view.backgroundColor = BASE_VC_COLOR;
    
    _menuTableView = [[UITableView alloc]
                      initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT)
                      style:UITableViewStylePlain];
    _menuTableView.backgroundColor = BASE_VC_COLOR;
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_menuTableView];
    _menuTableView.tableFooterView = [UIView new];
    
    [self setNav];
}

#pragma mark tableView delegate


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    LSBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[LSBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = indexPath.row == 0 ? @"女" : @"男";
    //标记
    if (isSelect == YES) {
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            
        }
    }
    else{
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        isSelect = 1;
    }
    else{
        isSelect = 0;
    }
    [_menuTableView reloadData];
}

- (void)setNav{
    CGRect backframe= CGRectMake(0, 0, 40, 22);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setTitleColor:BASE_GREEN_COLOR forState:UIControlStateNormal];
    [backButton setTitle:@"保存" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [backButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的 UIBarButtonItem
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = someBarButtonItem;
    
}

- (void)confirm{
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    dic = [ZXCommens factionaryParams:@{@"gender":isSelect == YES ? @"女" : @"男"} WithServerAndMethod:@{@"service":@"user",@"method":@"update_user_info"}];
    
    [self showHudInView:self.view hint:@"提交中"];
    
    ZXRequest *request = [[ZXRequest alloc] initWithRUrl:Host_Server
                                              andRMethod:YTKRequestMethodPost
                                            andRArgument:dic];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self hideHud];
        if ([request.responseJSONObject[@"success"] integerValue] == 1) {
            ZXUser * user = [ZXCommens fetchUser];
            user.gender = isSelect == YES ? @"女" : @"男";
            [ZXCommens putUserInfo:user];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHint:request.responseJSONObject[@"entity"][@"reason"]];
        }
    } failure:^(YTKBaseRequest *request) {
        [self showHint:@"请求失败"];
    }];
    
}


@end
