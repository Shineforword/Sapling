//
//  LSShowZoneCell.h
//  Sapling
//
//  Created by sport on 16/5/17.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSShowZoneModel;

@interface LSShowZoneCell : UITableViewCell

/** 传入indexPath*/
@property (nonatomic, strong) NSIndexPath * indexPath;

/** 传入模型*/
@property (nonatomic, strong) LSShowZoneModel * model;

/** 是否展开*/
@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

/** 更多操作*/
@property (nonatomic, copy) void (^operationButtonClickedBlock)(NSIndexPath *indexPath);

@end
