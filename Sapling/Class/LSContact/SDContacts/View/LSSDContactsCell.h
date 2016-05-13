//
//  LSSDContactsCell.h
//  Sapling
//
//  Created by sport on 16/5/10.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSSDContactModel;
@interface LSSDContactsCell : UITableViewCell
@property (nonatomic, strong) LSSDContactModel * model;
/** 修饰高度*/
+ (CGFloat)fixedHeight;
@end
