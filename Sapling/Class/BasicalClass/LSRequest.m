//
//  LSRequest.m
//  Sapling
//
//  Created by sport on 16/4/21.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSRequest.h"
@interface LSRequest ()

@property(nonatomic, strong) NSString *rURl;
@property YTKRequestMethod rMethod;
@property(nonatomic, strong) id rArgument;
@end

@implementation LSRequest
- (instancetype)initWithRUrl:(NSString *)url
                  andRMethod:(YTKRequestMethod)method
                andRArgument:(id)argument {
    if (self = [super init]) {
        self.rURl = url;
        self.rMethod = method;
        self.rArgument = argument;
    }
    return self;
}

#pragma mark--- 重载YTKRequest的一些设置方法

- (NSString *)requestUrl {
    return self.rURl;
}

- (YTKRequestMethod)requestMethod {
    return self.rMethod;
}

- (id)requestArgument {
    
    return self.rArgument;
}



@end
