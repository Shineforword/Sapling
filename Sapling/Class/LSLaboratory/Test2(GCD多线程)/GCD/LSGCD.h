//
//  LSGCD.h
//  Sapling
//
//  Created by sport on 16/5/17.
//  Copyright © 2016年 光前. All rights reserved.
//

#ifndef LSGCD_h
#define LSGCD_h

#import "LSGCDQueue.h"
#import "LSGCDGroup.h"
#import "LSGCDSemaphore.h"
#import "LSGCDTimer.h"

#endif /* LSGCD_h */


/**
 一.
 1.GCD :Grand Central Dispatch  强大的中枢调度
 2.纯C语言,提供了强大的函数
 3.优势:为多核并行运算提出的解决方案
 会自动利用更多的CPU内核
 会自动管理线程的生命周期(创建线程,调度线程,销毁线程).相比NSThread需要手动管理线程生命周期
 只需要告诉GCD想要执行什么任务,不需要编写任何线程管理代码
 4.GCD的核心概念:任务/队列
 任务:执行什么操作
 队列:用来存放任务,对列的类型,并发队列 与串行队列
 将任务添加到队列中,GCD会自动的将队列中的任务取出,放到对应的线程中执行:任何任务的取出,遵循队列的先进先出,后进后出的原则
 */

/**
 二.执行任务:同步 异步 栅栏
 1.同步:dispatch_sync 只能在当前线程中执行任务,不具备开启新线程的能力
 dispatch_sync(dispatch_queue_tqueue,dispatch_block_tblock);
 注意使用sync函数向当前串行队列中添加任务,会卡住当前的串行队列
 
 2.异步:dispatch_asnc:可以在新的线程中执行任务,具备开启新线程的能力
 dispatch_async(dispatch_queue_tqueue,dispatch_block_tblock);
 
 3.栅栏:另外一个执行任务的方法,dispatch_barrier_async 栅栏
 应用场景:在前面的任务执行结束后它才执行,而且他后面的任务等他执行完成后才会执行
 注意:这个队列不能是全局的并发队列
 dispatch_barrier_async(dispatch_queue_tqueue,dispatch_block_tblock);
 */
/**
 
 三.队列:串行,并行
 
 1.使用dispatch_queue_create函数创建队列
 dispatch_queue_t dispatch_queue_create(
 const char * label,//队列的名称
 dispatch_queue_attr_t  attr //队列的类型
 );
 */
/**
 并发队列: ConcurrentDispatch Queue
 1.可以让多个任务并发(同时)执行的(自动开启多个线程同时执行任务)
 注意只有在异步(dispatch_async)函数下才有效,因为异步函数才具备开启新的线程的能力,
 而同步函数只能在当前线程中执行不具备开启线程的能力
 
 2.并发队列的获取
 手动创建并发队列;dispatch_queue_create
 dispatch_queue_t queue = dispatch_queue_create ("队列名称",DISPATCH_QUEUE_CONCUREENT);
 
 GCD默认提供了全局的并发队列,供给整个应用使用,可以无需手动创建,
 使用dispaych_get_global_queue 函数获得全局并发队列
 
 //获得全局并发队列的方法
 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
 */

/**
 串行队列:SerialDispatch Queue
 让任务一个接着一个的执行(一个任务执行完毕,再执行下一个任务)
 注意:使用sync函数向当前串行队列中添加任务,会卡住当前的串行队列
 
 GCD中获得串行有两种途径
 
 使用dispatch_queue_create函数
 //创建串行队列(队列类型传递NULL或者DISPATCH_QUEUE_SERIAL)
 dispatch_queue_tqueue = dispatch_queue_create ("队列名称",NULL);
 
 主队列:是GCD自带的一种特殊的串行队列
 放在主队列中的任务,会放到主线程中执行
 dispatch_queue_tqueue = dispatch_get_main_queue();
 */

/**
 同步/异步/ 与 并发/串行 区分
 1.同步 和 异步 主要影响: 能不呢开启新的线程
 同步: 只是在当前线程中执行任务,不具备开启新线程的能力
 异步: 可以在新的线程中执行任务,具备开启新线程的能力
 2.并发和串行的主要影响:任务的执行方式
 并发:允许多个任务并发同时执行
 串行:一个任务执行完毕后,再执行下一个任务
 */
