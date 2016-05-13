//
//  LSConversationViewController.h
//  Sapling
//
//  Created by sport on 16/4/22.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSBaseUIViewController.h"

@interface LSConversationViewController : LSBaseUIViewController

/** 删除表格的代理方法*/
- (void)removeTableViewDelegate;

/** 刷新表格的代理方法*/
- (void)reloadChatListDataSource;

@end
