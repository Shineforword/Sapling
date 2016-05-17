//
//  LSShowZoneModel.h
//  Sapling
//
//  Created by sport on 16/5/17.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSShowZoneModel : NSObject

/** 发布者头像*/
@property (nonatomic, strong) NSString  * iconImage;
/** 发布者名字*/
@property (nonatomic, strong) NSString  * name;
/** 发布者id*/
@property (nonatomic, strong) NSString  * uid;
/** 时间*/
@property (nonatomic, strong) NSString  * time;
/** 地点*/
@property (nonatomic, strong) NSString  * address;
/** 标签*/
@property (nonatomic, strong) NSArray   * labels;
/** 图片数组*/
@property (nonatomic, strong) NSArray  * photosArray;
/** 文本内容*/
@property (nonatomic, strong) NSString * contentStr;

/** 是否展开*/
@property (nonatomic, assign) BOOL isOpening;
/** 是否展示"展开/收起按钮"*/
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

@end
