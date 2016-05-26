//
//  LSGCDTestController.m
//  Sapling
//
//  Created by sport on 16/5/17.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSGCDTestController.h"
#import "LSGCD.h"
/** 测试线*/
#import "CustomLine.h"

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
    NSArray * dispatchArray = @[@"同步+主队列(子)",
                                @"同步+主队列(主)",
                                @"异步+主队列",
                                @"同步+并发",
                                @"同步+串行",
                                @"异步+串行",
                                @"异步+并发",
                                @"线程之间的通信",
                                @"栅栏",
                                @"队列组"];
    NSMutableArray * buttonArray = [[NSMutableArray alloc]init];
    
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
        [button.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [button addTarget:self action:@selector(dispatchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArray addObject:button];
    }
}
- (void)dispatchButtonClicked:(UIButton *)button{
    
    if (button.tag == 0) {
        //同步函数 + 主队列 (子线程)
        [self syncMain1];
        
    }
    if (button.tag == 1) {
        //同步函数 + 主队列 (主线程)
        [self syncMain2];

    }
    if (button.tag == 2) {
        
        //异步 + 主队列
        [self asyncMain];
        
    }
    if (button.tag == 3) {
        
        //同步 + 并发
        [self syncConcurrent];
        
    }
    if (button.tag == 4) {
        //同步 + 串行
        [self syncSerial];
        
    }
    if (button.tag == 5) {
        //异步 + 串行
        [self asyncSerial];
        
        
    }
    if (button.tag == 6) {
        //异步 + 并发
        [self asyncConcurrent];

        
    }
    if (button.tag == 7) {
        //线程之间的通信
        [self commucationBetweenTwoThread];
        
        
    }
    if (button.tag == 8) {
        //栅栏
        [self barrier];
        
    }
    if (button.tag == 9) {
        //队列组1
        [self useDispatchGroup];
        
    }
    if (button.tag == 10) {
        //队列组2
        [self useDispatchGroup];

    }


    
}

#pragma mark - 同步函数 + 主队列 (子线程)
/** 如果是在子线程中调用 同步函数 +  主队列 ,那没有什么问题*/
- (void)syncMain1{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    dispatch_async(queue, ^{
        
        //block 会在子线程中执行
        
        dispatch_queue_t queue = dispatch_get_main_queue();
        dispatch_sync(queue, ^{
            
            //block 一定会在主线程中执行
            NSLog(@"%@",[NSThread currentThread]);
            
        });
    });
    
}
#pragma mark - 同步函数 + 主队列 (主线程)
/** 
 如果是在主线程中调用同步函数 + 主队列 那么会导致死锁
 导致死锁的原因:
 sync函数是在主线程中队列中执行的,并且会等待block 执行完毕,先调用block是添加到主队列的,也需要在主线程中执行,后调用
 */
- (void)syncMain2{
    
    NSLog(@"%@",[NSThread currentThread]);
    
    /** 主队列*/
    dispatch_queue_t queue = dispatch_get_main_queue();
    /** 如果是调用同步函数,那么会等同步函数中的任务完毕,才会执行后面的代码*/
    
    /** 如果dispatch_sync方法是在主线程中调用的,并且传入的队列是主队列会导致死锁*/
    dispatch_sync(queue, ^{
        
        NSLog(@"%@",[NSThread currentThread]);
        
    });
    
}
#pragma mark - 异步 + 主队列
/** 异步 + 主队列 : 不会创建新的线程, 并且任务是在主线程中执行的*/
- (void)asyncMain{
    //主队列
    //特点:只要将任务添加到主队列中,那么任务一定会在主线程中执行,无论调用的是同步函数还是异步函数
    dispatch_queue_t  queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        
        NSLog(@"%@",[NSThread currentThread]);
    });
    
}

#pragma mark - 同步 + 并发
/**同步 + 并发:不会开启新的线程 */
- (void)syncConcurrent{
    //创建一个并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    //将任务添加到队列中
    dispatch_sync(queue, ^{
        
        NSLog(@"work - 1 == %@ ",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        
        NSLog(@"work - 2 == %@ ",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"work - 3 == %@ ",[NSThread currentThread]);
    });

}
#pragma mark - 同步 + 串行
/** 同步 + 串行 : 不会开启新的线程*/
/** 注意: 如果是调用 同步函数,那么会等同步函数中的任务执行完毕,才会执行后面的代码*/
- (void)syncSerial{
    //创建一串行队列
    //#define DISPATCH_QUEUE_DEFAULT NULL
    //所以可以直接传NULL
    dispatch_queue_t queue  = dispatch_queue_create("loveCoding", NULL);
    //添加任务
    dispatch_sync(queue, ^{
        
        NSLog(@"work - 1 == %@ ",[NSThread currentThread]);
 
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"work - 2 == %@ ",[NSThread currentThread]);
        
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"work - 3 == %@ ",[NSThread currentThread]);
        
    });

}
#pragma mark - 异步 + 串行
/** 异步 + 串行
 只会开启一个新的线程
 注意:如果调用异步函数,那么不用等到函数中的任务执行完毕,就会执行后面的代码
 */
- (void)asyncSerial{
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("love", DISPATCH_QUEUE_SERIAL);
    /**
     能够创建新的线程;
     我们是使用"异步"函数调用
     只创建一个子线程的原因
     我们的队列是串行队列
     */
    dispatch_async(queue, ^{
        
        NSLog(@"work - 1 == %@ ",[NSThread currentThread]);

    });
    dispatch_async(queue, ^{
        
        NSLog(@"work - 2 == %@ ",[NSThread currentThread]);
        
    });

}
#pragma mark - 异步 + 并发
/** 异步 + 并发 : 会开启新的线程
 如果任务较多就会开启多个线程
 */
- (void)asyncConcurrent{
    /**
     执行任务
     dispatch_async
     dispatch_sync
     */
    
    /**
     第一个参数:队列的名称
     第二个参数:告诉系统需要创建一个并发队列还是串行队列
     DISPATCH_QUEUE_SERIAL:串行
     DISPATCH_QUEUE_CONCURRENT:并发
     */
    //dispatch_queue_t queue = dispatch_queue_create("love",DISPATCH_QUEUE_CONCURRENT);
    
    //系统已经给我们提供一个现成的并发队列
    /*
     
     iOS  8.0 以前的优先级
     - DISPATCH_QUEUE_PRIORITY_HIGH       高优先级 2
     - DISPATCH_QUEUE_PRIORITY_DEFAULT    默认先级 0
     - DISPATCH_QUEUE_PRIORITY_LOW       底先级 -2
     - DISPATCH_QUEUE_PRIORITY_BACKGROUD

     iOS 8.0 以后
     * - QOS_CLASS_USER_INTERACTIVE 0x21 用户交互(用户迫切想执行任务) 
     * - QOS_CLASS_USER_INITIATED 0x19 用户需要 
     * - QOS_CLASS_DEFAULT 0x15 默认 
     * - QOS_CLASS_UTILITY 0x11 工具(低优先级, 苹果推荐将耗时操作放到这种类型的队列中)
     * - QOS_CLASS_BACKGROUND 0x09 后台 * - QOS_CLASS_UNSPECIFIED 0x00 没有设置
     
     第二个参数: 无用
     */
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    /**
     第一个参数:用于存放任务的队列
     第二个参数:任务block
     */
    dispatch_async(queue, ^{
        NSLog(@"任务1  == %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2  == %@", [NSThread currentThread]);
    });

}
#pragma mark - 线程之间的通信
- (void)commucationBetweenTwoThread{
    //1除了主线程之外,随便整一个队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    //2.调用异步函数
    dispatch_async(queue, ^{
        //3.耗时操作
        
        //回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
           
            //刷新UI
        });
        
    });
    
}
#pragma mark - 延时执行
/** 
 1.延时执行,调用NSObject的方法
 [self performSelector:@selector(run) withObject:nil aftreDelay:2.0];
 2.使用GCD 函数
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(3.0 * NSEC_PER_SEC)),dispatch_get_global_queue(0,0),^{
 
     //这里传入全局队列会在子线程中执行block,如果传入主队列就会在主线程中执行block
 
     NSLog(@"3秒后执行%@",[NSThread currentThread]);
 
 });
 3.使用NSTimer
 
 [NSTimer scheduledTimerWithInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:NO];
 
 4.[NSThread sleepForTimerInterval:3];
   延时执行不要使用sleepForTimerInterval 他会卡住线程
 */
#pragma mark - 一次性代码
/**
 使用dispatch_once 函数可以保证某段代码在程序运行的过程中,只被执行一次,只执行一次的代码这里面是安全的
 需要注意的是:千万不能将至执行一次的代码当做懒加载使用
 static dispatch_once_t onceToken;
 dispatch_once(&oceToken,^{
    NSLog(@"一次性代码");
 })
 */
#pragma mark - 快速迭代
/**
 第一个参数:需要遍历多少次
 第二个参数:决定第三个参数的block在哪个线程中执行
 第三个参数:回调
 dispatch_apply(10,队列queue,^(size_tindex){
      
      //执行代码10次,index顺序不定
 
 });
 
 */
/**
 实例: 
 NSString *sourcePath = @"/Users/cjp/Desktop/原始文件";
 NSString *destPath = @"/Users/cjp/Desktop/目标文件";
 
 // 2.取出原始文件夹中所有的文件
 NSFileManager *manager = [NSFileManager defaultManager];
 NSArray *files = [manager subpathsAtPath:sourcePath];
 //    NSLog(@"%@", files);
 
 // 3.开始拷贝文件
 for (NSString *fileName in files) {
 
 // 3.1生产原始文件的绝对路径
 NSString *sourceFilePath = [sourcePath stringByAppendingPathComponent:fileName];

 // 3.2生产目标文件的绝对路径
 NSString *destFilePath = [destPath stringByAppendingPathComponent:fileName];
 //        NSLog(@"%@", sourceFilePath);
 //        NSLog(@"%@", destFilePath);
 
 // 3.3利用NSFileManager拷贝文件
 [manager moveItemAtPath:sourceFilePath toPath:destFilePath error:nil];
 }
 
 dispatch_apply(files.count, dispatch_get_global_queue(0, 0), ^(size_t index) {
    NSString *fileName = files[index];
    // 3.1生产原始文件的绝对路径
    NSString *sourceFilePath = [sourcePath stringByAppendingPathComponent:fileName];
    // 3.2生产目标文件的绝对路径
    NSString *destFilePath = [destPath stringByAppendingPathComponent:fileName];
    //        NSLog(@"%@", sourceFilePath);
    //        NSLog(@"%@", destFilePath);
    // 3.3利用NSFileManager拷贝文件
    [manager moveItemAtPath:sourceFilePath toPath:destFilePath error:nil];
});
 */
#pragma mark - dispatch_barrier_async 栅栏

/**
 功能:拦截前面的任务,只有先添加到队列中的任务 = 执行完毕 ,才会执行栅栏中添加的任务
 如果栅栏之后还有还有其他任务,那么必须等到栅栏任务执行完成完成之后会执行其他任务
 注意: 若想使用栅栏,那么就不能使用全局并发队列
      若想使用栅栏,那么所有任务必须添加到同一个队列中
 应用:实例：合并两种图片，
 异步函数并发队列多线程下载图片，多个线程同时下载图片，当两种图片下载完毕
 -> 开启栅栏功能子线程中进行合并图片，合成图片结束后，再会到主线程更新UI，
 */
- (void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("cjp", DISPATCH_QUEUE_CONCURRENT);
    //    dispatch_queue_t queue2 = dispatch_queue_create("cjp", DISPATCH_QUEUE_CONCURRENT);
    //    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    __block UIImage *image1 = nil;
    __block UIImage *image2 = nil;
    // 1.开启一个新的线程下载第一张图片
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://img.alicdn.com/tps/i1/TB1AE.sFVXXXXaCXFXXwu0bFXXX.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        image1 = image;
        NSLog(@"图片1下载完毕");
    });
    // 2.开启一个新的线程下载第二张图片
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/img/bd_logo1.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        image2 = image;
        NSLog(@"图片2下载完毕");
    });
    
    // 3.开启一个新的线程, 合成图片
    // 栅栏
    dispatch_barrier_async(queue, ^{
        // 图片下载完毕
        NSLog(@"%@ %@", image1, image2);
        
        // 1.开启图片上下文
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        // 2.将第一张图片画上去
        [image1 drawInRect:CGRectMake(0, 0, 100, 200)];
        // 3.将第二张图片画上去
        [image2 drawInRect:CGRectMake(100, 0, 100, 200)];
        // 4.从上下文中获取绘制好的图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        // 5.关闭上下文
        UIGraphicsEndImageContext();
        
        // 4.回到主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.image = newImage;
            // 将合并后的图片写到本地桌面：
            [UIImagePNGRepresentation(newImage) writeToFile:@"/Users/cjp/Desktop/123.png" atomically:YES];
        });
        
        NSLog(@"栅栏执行完毕了");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---------");
    });
    dispatch_async(queue, ^{
        NSLog(@"---------");
    });
    dispatch_async(queue, ^{
        NSLog(@"---------");
    });
}
#pragma mark - 队列组
/**
 应用场景:分别异步执行两个耗时的操作,要等到2个异步操作都完成时,在回到主线程执行操作
 注意:该场景也可以使用面的栅栏解决

 */
- (void)useDispatchGroup{
    
    dispatch_group_t group =  dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
        //执行1个耗时的异步操作
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
        //执行1个耗时的异步操作
    });
    dispatch_group_notify(group, dispatch_get_main_queue(),^{
        //等前面的异步操作都执行完毕后，回到主线程...
    });
}
- (void)useDispatchGroup1{
    dispatch_queue_t queue = dispatch_queue_create("cjp", DISPATCH_QUEUE_CONCURRENT);
    
    __block UIImage *image1 = nil;
    __block UIImage *image2 = nil;
    
    dispatch_group_t group = dispatch_group_create();
    
    // 1.开启一个新的线程下载第一张图片
    dispatch_group_async(group, queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://img.alicdn.com/tps/i1/TB1AE.sFVXXXXaCXFXXwu0bFXXX.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        image1 = image;
        NSLog(@"图片1下载完毕");
    });
    
    // 2.开启一个新的线程下载第二张图片
    dispatch_group_async(group, queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/img/bd_logo1.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        image2 = image;
        NSLog(@"图片2下载完毕");
    });
    
    // 3.开启一个新的线程, 合成图片
    // 只要将队列放到group中, 队列中的任务执行完毕, group就会发出一个通知
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"%@ %@", image1, image2);
        // 1.开启图片上下文
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        // 2.将第一张图片画上去
        [image1 drawInRect:CGRectMake(0, 0, 100, 200)];
        // 3.将第二张图片画上去
        [image2 drawInRect:CGRectMake(100, 0, 100, 200)];
        // 4.从上下文中获取绘制好的图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        // 5.关闭上下文
        UIGraphicsEndImageContext();
        
        // 4.回到主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.image = newImage;
            [UIImagePNGRepresentation(newImage) writeToFile:@"/Users/cjp/Desktop/123.png" atomically:YES];
        });
    });

}

#pragma mark - GCD 自定义的一些使用方法
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
