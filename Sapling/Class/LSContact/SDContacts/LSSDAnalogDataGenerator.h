//
//  LSSDAnalogDataGenerator.h
//  Sapling
//
//  Created by sport on 16/5/10.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 数据模拟器*/
@interface LSSDAnalogDataGenerator : NSObject

/** 随机名字*/
+ (NSString *)randomName;
/** 随机头像*/
+ (NSString *)randomIconImageName;
/** 随机消息*/
+ (NSString *)randomMessage;

@end
