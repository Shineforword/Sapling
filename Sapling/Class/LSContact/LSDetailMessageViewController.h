//
//  LSDetailMessageViewController.h
//  Sapling
//
//  Created by sport on 16/4/21.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSBaseUIViewController.h"

@interface LSDetailMessageViewController : LSBaseUIViewController

@property (nonatomic,strong)ZXUser *kUser;

@property (nonatomic,assign)BOOL  isFromChatVC;

@property (nonatomic,assign)BOOL isFromContact;

@end
