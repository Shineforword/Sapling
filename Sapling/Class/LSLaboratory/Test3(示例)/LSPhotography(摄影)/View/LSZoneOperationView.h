//
//  LSZoneBackTopView.h
//  Sapling
//
//  Created by sport on 16/5/18.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KZoneOperationViewType) {
    KZoneOperationViewTypeTopButton = 1,
    KZoneOperationViewTypeBottomButton,
};

@protocol LSZoneOperationViewDelegate <NSObject>

/** 置顶按钮点击事件*/
- (void)ZoneOperationViewWith:(KZoneOperationViewType)type;

@end

@interface LSZoneOperationView : UIView

@property (nonatomic, weak) id<LSZoneOperationViewDelegate> delegate;

@end
