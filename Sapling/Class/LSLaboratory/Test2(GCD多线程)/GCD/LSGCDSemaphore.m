//
//  LSGCDSemaphore.m
//  Sapling
//
//  Created by sport on 16/5/17.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSGCDSemaphore.h"
@interface LSGCDSemaphore ()

@property (strong, readwrite, nonatomic) dispatch_semaphore_t dispatchSemaphore;

@end

@implementation LSGCDSemaphore


- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.dispatchSemaphore = dispatch_semaphore_create(0);
    }
    
    return self;
}

- (instancetype)initWithValue:(long)value {
    
    self = [super init];
    
    if (self) {
        
        self.dispatchSemaphore = dispatch_semaphore_create(value);
    }
    
    return self;
}

- (BOOL)signal {
    
    return dispatch_semaphore_signal(self.dispatchSemaphore) != 0;
}

- (void)wait {
    
    dispatch_semaphore_wait(self.dispatchSemaphore, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta {
    
    return dispatch_semaphore_wait(self.dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}

@end
