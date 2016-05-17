//
//  LSGCDTestController.m
//  Sapling
//
//  Created by sport on 16/5/17.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSGCDTestController.h"
#import "LSGCD.h"

@interface LSGCDTestController()

@property (nonatomic, strong) LSGCDTimer *timer;

@property (nonatomic, strong) UILabel * dispatchLabel;

@end
@implementation LSGCDTestController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    /** UI*/
    _dispatchLabel = [[UILabel alloc]init];
    [self.view addSubview:_dispatchLabel];
    
    _dispatchLabel.sd_layout
    .topSpaceToView(self.view,10)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .heightIs(20);
    _dispatchLabel.textColor = BASE_GREEN_COLOR;
    _dispatchLabel.textAlignment = NSTextAlignmentCenter;
    
    _dispatchLabel.text = @"主线程中执行...";
    
    
    CGFloat Gap = 10;
    CGFloat btnW = (SCREEN_WIDTH - 5 * Gap)/4;
    CGFloat btnH = 30;
    NSArray * dispatchArray = @[@"多线程1",@"多线程2",@"多线程3",@"多线程4",@"多线程5",@"多线程6",@"多线程7",@"多线程8",];
    for (int i = 0 ;  i < dispatchArray.count ; i ++ ) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:dispatchArray[i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:BASE_GREEN_COLOR] forState:UIControlStateNormal];
        [self.view addSubview:button];
        
        button.sd_layout
        .topSpaceToView(_dispatchLabel, Gap + (i / 4) * (btnH + Gap))
        .leftSpaceToView(self.view ,Gap + (i % 4) * (btnW + Gap))
        .widthIs(btnW)
        .heightIs(btnH);
        button.tag = i;
        [button addTarget:self action:@selector(dispatchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)dispatchButtonClicked:(UIButton *)button{
    
    if (button.tag == 0) {
        
        [self simulateDownloadDataSource];
    }
    if (button.tag == 1) {
        
        [self simulateGCDGroup];
    }
    if (button.tag == 2) {
        
        [self simulateGCDTimer];
    }
    if (button.tag == 3) {
        
        [self simulateGCDSemaphore];
    }
    
}
- (void)simulateGCDSemaphore{
    // init semaphore
    LSGCDSemaphore *semaphore = [LSGCDSemaphore new];
    
    // wait
    [LSGCDQueue executeInGlobalQueue:^{
        
        [semaphore wait];
        
        // todo sth else
    }];
    
    // signal
    [LSGCDQueue executeInGlobalQueue:^{
        
        // do sth
        [semaphore signal];
    }];

}
- (void)simulateGCDTimer{
    // init timer
    self.timer = [[LSGCDTimer alloc] initInQueue:[LSGCDQueue mainQueue]];
    
    // timer event
    [self.timer event:^{
        
        // task
        
    } timeInterval:NSEC_PER_SEC * 3 delay:NSEC_PER_SEC * 3];
    
    // start timer
    [self.timer start];
    
}
- (void)simulateGCDGroup{
    // init group
    LSGCDGroup *group = [LSGCDGroup new];
    
    // add to group
    [[LSGCDQueue globalQueue] execute:^{
        
        [self taskOne];
        
    } inGroup:group];
    
    // add to group
    [[LSGCDQueue globalQueue] execute:^{
      
        [self taskTwo];
        
    } inGroup:group];
    
    // notify in mainQueue
    [[LSGCDQueue mainQueue] notify:^{
        
        [self taskThree];
        
    } inGroup:group];
}
/** 模仿数据下载后更新UI*/
- (void)simulateDownloadDataSource{
    
    [LSGCDQueue executeInGlobalQueue:^{
        
        // download task, etc
        [self downLoadDataSource];
        
        [LSGCDQueue executeInMainQueue:^{
            
            // update UI
            [self upDateUI];
        }];
    }];

}
#pragma mark - private methods
/** 耗时操作*/
- (void)downLoadDataSource{
    NSLog(@"耗时5s");
    [LSGCDQueue executeInMainQueue:^{
        _dispatchLabel.text = @"模仿下载...5s";
    }];
    sleep(5);
}
/** 更新UI*/
- (void)upDateUI{
    
    _dispatchLabel.text = @"下载完成更新视图...";
    NSLog(@"更新UI");

}
- (void)taskOne{
    NSLog(@"耗时1s");
    _dispatchLabel.text = @"耗时1s...";
    sleep(1);
}
- (void)taskTwo{
    NSLog(@"耗时2s");
    _dispatchLabel.text = @"耗时2s...";
    sleep(2);
}
- (void)taskThree{
    NSLog(@"耗时3s");
    _dispatchLabel.text = @"耗时3s...";
    sleep(3);
}
- (void)timerTask{
    NSLog(@"timerTask耗时3s");
    _dispatchLabel.text = @"耗时3s...";
    sleep(3);
}
@end
