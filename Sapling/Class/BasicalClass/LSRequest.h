//
//  LSRequest.h
//  Sapling
//
//  Created by sport on 16/4/21.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTKRequest.h"
@interface LSRequest : YTKRequest

- (instancetype)initWithRUrl:(NSString *)url
                  andRMethod:(YTKRequestMethod)method
                andRArgument:(id)argument;

@end
