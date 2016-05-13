//
//  LSWelcomeViewController.m
//  Sapling
//
//  Created by sport on 16/4/20.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSWelcomeViewController.h"

@interface LSWelcomeViewController ()<UIScrollViewDelegate>
@property(strong, nonatomic) UIPageControl *pageControl;
@end

@implementation LSWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
    [self createWelcomeView];

    // Do any additional setup after loading the view.
    
}
- (void)createWelcomeView {
    //欢迎页面的滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 4, SCREEN_HEIGHT);
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    // This is the starting point of the ScrollView
    CGPoint scrollPoint = CGPointMake(0, 0);
    [scrollView setContentOffset:scrollPoint animated:YES];
    
    // yes 则发送一个可以touchesCancelled:withEvent:
    // 然后把这个事件当作一次滚动赖实现
    [scrollView setCanCancelContentTouches:YES];
    
    // 当值是NO 立即调用 touchesShouldBegin:withEvent:inContentView 看是否滚动
    // scroll
    [scrollView setDelaysContentTouches:NO];
    
    //循环创建scroller里面的内容
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_home%d", i + 1]];
        [scrollView addSubview:imageView];
        if (i == 3) {
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startButtonAction)];
            [imageView addGestureRecognizer:tap];
        }
        [scrollView addSubview:imageView];
    }
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * .95,
                                                 self.view.frame.size.width,
                                                 10)];
    self.pageControl.pageIndicatorTintColor = QYQHEXCOLOR_ALPHA(0x999999, 0.7);
    self.pageControl.currentPageIndicatorTintColor = QYQCOLOR_ALPHA(33, 198, 200 , 0.7);
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = 4;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGFloat pageFraction = scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
}

- (void)startButtonAction {
    
    NSNotification *notification = [NSNotification notificationWithName:QYQ_RECREATE_ROOT object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
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
