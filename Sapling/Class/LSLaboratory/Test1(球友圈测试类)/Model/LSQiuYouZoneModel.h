//
//  LSQiuYouZoneModel.h
//  Sapling
//
//  Created by sport on 16/5/12.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSQiuYouZoneModel : NSObject

/** 头像*/
@property (nonatomic, strong) NSString * iconImage;
/** 名字*/
@property (nonatomic, strong) NSString * name;
/** 发布时间*/
@property (nonatomic, strong) NSString * publishTime;
/** 发布内容*/
@property (nonatomic, strong) NSString * contentStr;
/** 是否展开*/
@property (nonatomic, assign) BOOL isOpening;

/** 是否展示"展开/收起按钮"*/
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

/** 发布的图片数组*/
@property (nonatomic, strong) NSArray *picNamesArray;

@end
