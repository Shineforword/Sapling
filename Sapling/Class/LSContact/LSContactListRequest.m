//
//  LSContactListRequest.m
//  Sapling
//
//  Created by sport on 16/4/21.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSContactListRequest.h"

@implementation LSContactListRequest
- (NSInteger)cacheTimeInSeconds {
    //3分钟的缓存时间,3分钟内不重复发出请求
    return 1;
}
@end
