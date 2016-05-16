//
//  LSHttpRequestManager.h
//  Sapling
//
//  Created by sport on 16/5/16.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZXRequest.h"

typedef void (^LSHttpRequestBlock)(YTKBaseRequest *request);

@interface LSHttpRequestManager : NSObject

/** 示例*/
+ (void)deleteOneFriend:(NSDictionary *)rArgument responseResult:(LSHttpRequestBlock)resultBlock;

@end
