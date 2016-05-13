//
//  LSQiuYouZoneTestCell.h
//  Sapling
//
//  Created by sport on 16/5/12.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSQiuYouZoneModel;

@interface LSQiuYouZoneTestCell : UITableViewCell
@property (nonatomic, strong) LSQiuYouZoneModel * model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@end
