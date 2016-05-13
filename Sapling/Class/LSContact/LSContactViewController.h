//
//  LSContactViewController.h
//  Sapling
//
//  Created by sport on 16/4/21.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSBaseUIViewController.h"

@interface LSContactViewController : LSBaseUIViewController

/** 显示未读消息*/
@property (nonatomic, strong) UIView * noReadServerMessageLabel;

/** public*/
- (void)apiRequestContactList;

@end
