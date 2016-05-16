//
//  LSHttpRequestManager.m
//  Sapling
//
//  Created by sport on 16/5/16.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSHttpRequestManager.h"

@implementation LSHttpRequestManager

/** 示例*/
+ (void)deleteOneFriend:(NSDictionary *)rArgument responseResult:(LSHttpRequestBlock)resultBlock{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
   
    dic[@"service"] = @"statium";
    dic[@"method"] = @"spaceList";
    
    dic[@"params"] = rArgument;
    
    NSData *jsonData =
    [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *myString =
    [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *pDic =
    [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    ZXRequest *request = [[ZXRequest alloc] initWithRUrl:Host_Server
                                                andRMethod:YTKRequestMethodPost
                                              andRArgument:pDic];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];

}
@end
