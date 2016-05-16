//
//  ZoneTableViewHeader.h
//  Sapling
//
//  Created by sport on 16/5/12.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KHeaderButtonType) {
    KHeaderButtonTypeEditing = 1,
    KHeaderButtonTypePhoto,
};
@protocol ZoneTableViewHeaderDelegate <NSObject>
/** 选中按钮*/
- (void)buttonClickedWith:(KHeaderButtonType)type;

@end

@interface ZoneTableViewHeader : UIView

@property (nonatomic, weak) id<ZoneTableViewHeaderDelegate>delegate;

@end
