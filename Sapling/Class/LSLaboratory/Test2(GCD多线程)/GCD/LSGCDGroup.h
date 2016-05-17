//
//  LSGCDGrop.h
//  Sapling
//
//  Created by sport on 16/5/17.
//  Copyright © 2016年 光前. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface LSGCDGroup : NSObject

/** dispatch_group_t dispatch组*/
@property (nonatomic, strong, readonly)dispatch_group_t  dispatchGroup;

/** 初始化*/
- (instancetype)init;

/** 进入*/
- (void)enter;

/** 离开*/
- (void)leave;

/** 等待*/
- (void)wait;

/** 等待时间*/
- (BOOL)wait:(int64_t)delta;
@end
