//
//  LSQiuYouZoneTestCell.h
//  Sapling
//
//  Created by sport on 16/5/12.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSQiuYouZoneModel;
@class LSZoneCommentItemModel;
@interface LSQiuYouZoneTestCell : UITableViewCell

@property (nonatomic, strong) LSQiuYouZoneModel * model;

@property (nonatomic, strong) NSIndexPath *indexPath;

/** 是否展开*/
@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

/** 更多操作*/
@property (nonatomic, copy) void (^operationButtonClickedBlock)(NSIndexPath *indexPath);

/** 回复*/
@property (nonatomic, copy) void (^replaySomeBodyBlock)(NSIndexPath *indexPath,LSZoneCommentItemModel * model,NSString * name);

@end
