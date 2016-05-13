//
//  LSBaseTableViewController.m
//  Sapling
//
//  Created by sport on 16/5/10.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSBaseTableViewController.h"

@interface LSBaseTableViewController ()

@end
@implementation LSBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


@end
