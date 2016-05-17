//
//  LSGCDGrop.m
//  Sapling
//
//  Created by sport on 16/5/17.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSGCDGroup.h"
@interface LSGCDGroup()

@property (nonatomic, strong,readwrite) dispatch_group_t dispatchGroup;

@end

@implementation LSGCDGroup

/** 初始化 */
- (instancetype)init{
    
    self = [super init];
    if(self){
        
        /**  创建*/
        self.dispatchGroup = dispatch_group_create();
   
    }
    return self;
}

- (void)enter{
    
    dispatch_group_enter(self.dispatchGroup);
    
}

- (void)leave{
   
    dispatch_group_leave(self.dispatchGroup);
    
}

- (void)wait{
    
    dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
    
}

- (BOOL)wait:(int64_t)delta{
    
    return dispatch_group_wait(self.dispatchGroup, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}
@end
