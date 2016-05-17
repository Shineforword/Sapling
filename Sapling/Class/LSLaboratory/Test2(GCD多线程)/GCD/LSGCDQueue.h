//
//  LSGCDQueue.h
//  Sapling
//
//  Created by sport on 16/5/17.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSGCDGroup;

@interface LSGCDQueue : NSObject
/** 线程队列*/
@property (nonatomic, strong,readonly)dispatch_queue_t dispatchQueue;

/** 主线程队列*/
+ (LSGCDQueue *)mainQueue;

/** 全部线程队列*/
+ (LSGCDQueue *)globalQueue;

/** 优先级*/
+ (LSGCDQueue *)highPriorityGlobalQueue;
+ (LSGCDQueue *)lowPriorityGlobalQueue;
+ (LSGCDQueue *)backgroundPriorityGlobalQueue;


/**  便利构造方法*/
+ (void)executeInMainQueue:(dispatch_block_t)block;

+ (void)executeInGlobalQueue:(dispatch_block_t)block;

+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block;

+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block;

+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block;


+ (void)executeInMainQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;

+ (void)executeInGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;

+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;

+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;

+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;


/** 初始化*/
- (instancetype)init;

/** serial 连续的*/
- (instancetype)initSerial;

- (instancetype)initSerialWithLabel:(NSString *)label;

- (instancetype)initConcurrent;

- (instancetype)initConcurrentWithLabel:(NSString *)label;

/** 使用方法*/

/** 执行*/
- (void)execute:(dispatch_block_t)block;

/** 延迟delta后执行*/
- (void)execute:(dispatch_block_t)block afterDelay:(int64_t)delta;

/** 延迟delta后执行*/
- (void)execute:(dispatch_block_t)block afterDelaySecs:(float)delta;

/** 等待执行*/
- (void)waitExecute:(dispatch_block_t)block;

/** 阻塞执行*/
- (void)barrierExecute:(dispatch_block_t)block;

/** 等待阻塞执行*/
- (void)waitBarrierExecute:(dispatch_block_t)block;

/** 暂停*/
- (void)suspend;

/** 重新开始*/
- (void)resume;

/** 与LSGCDGroup相关*/
- (void)execute:(dispatch_block_t)block inGroup:(LSGCDGroup *)group;

- (void)notify:(dispatch_block_t)block inGroup:(LSGCDGroup *)group;
@end
