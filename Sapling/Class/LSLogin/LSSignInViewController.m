//
//  LSSignInViewController.m
//  Sapling
//
//  Created by sport on 16/4/21.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSSignInViewController.h"
#import "LSSignInView.h"

@interface LSSignInViewController ()

@end

@implementation LSSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    LSSignInView * LSSignIn = [[LSSignInView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:LSSignIn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
