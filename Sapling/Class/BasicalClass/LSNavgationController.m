//
//  LSNavgationController.m
//  Sapling
//
//  Created by sport on 16/4/20.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSNavgationController.h"

@interface LSNavgationController ()

@end

@implementation LSNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *bar = [UINavigationBar appearance];
    // 2.设置导航栏的背景颜色
    bar.barTintColor = [UIColor colorWithHexValue:0xffffff alpha:1];
    //3.设置导航栏文字的主题:
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName : [UIColor blackColor],
                                  NSFontAttributeName : [UIFont systemFontOfSize:15]
                                  }];
    //4.设置导航不透明  6.0及以前，会设置自动设置为不透明
    if (QYQiOSGreaterThanEight) {
        bar.translucent = NO;
    }
    [self.navigationBar setTranslucent:NO];
    // 5.设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;

    // Do any additional setup after loading the view.
}
/** 自身*/
-(void)popself
{
    [self popViewControllerAnimated:YES];
    
}

/** 定制返回按钮*/
-(UIBarButtonItem*) createBackButton
{
    UIImage* image= [UIImage imageNamed:@"nav_back"];
    CGRect backframe= CGRectMake(0, 0, 12, 24);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的 UIBarButtonItem
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    return someBarButtonItem;
}
/** 重写*/
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        //调整位置(设置占位,使返回按钮距离左边为20像素)
        UIBarButtonItem *nagativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        nagativeSpacer.width = -10;
        viewController.navigationItem.leftBarButtonItems = @[nagativeSpacer, [self createBackButton]];
    }
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
