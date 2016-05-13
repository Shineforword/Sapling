//
//  LSLoginView.h
//  Sapling
//
//  Created by sport on 16/4/21.
//  Copyright © 2016年 光前. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 不同按钮的枚举*/
typedef NS_ENUM(NSInteger, KButtonType) {
    KButtonTypeLogin = 1000,
    KButtonTypeSignIn,
    KButtonTypeForget
};

/** 协议*/
@protocol LSLoginViewDelegate <NSObject>
- (void)LSLoginViewButtonClicked:(UIButton * )button;
@end

@interface LSLoginView : UIView
@property (nonatomic, weak) id<LSLoginViewDelegate>delegate;
@end
