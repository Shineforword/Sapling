//
//  LSGCDSemaphore.h
//  Sapling
//
//  Created by sport on 16/5/17.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSGCDSemaphore : NSObject

@property (strong, readonly, nonatomic) dispatch_semaphore_t dispatchSemaphore;

#pragma 初始化
- (instancetype)init;
- (instancetype)initWithValue:(long)value;

#pragma mark - 用法
- (BOOL)signal;
- (void)wait;
- (BOOL)wait:(int64_t)delta;


@end
