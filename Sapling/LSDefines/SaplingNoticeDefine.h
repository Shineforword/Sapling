//
//  SaplingNoticeDefine.h
//  Sapling
//
//  Created by sport on 16/4/20.
//  Copyright © 2016年 光前. All rights reserved.
//

#ifndef SaplingNoticeDefine_h
#define SaplingNoticeDefine_h

/** 引导页结束重新创建window的根视图*/
#define QYQ_RECREATE_ROOT @"RECREATE_ROOT"

/** 登录状态通知*/
#define LOGIN_STATE @"LOGIN_STATE"
/** 刷新角标*/
#define UPDATE_BADGE @"UPDATE_BADGE"
/** 有新消息 */
#define NEW_MESSAGE @"NEW_MESSAGE"
/** 新的系统消息*/
#define NEW_SERVER_MESSAGE @"NEW_SERVER_MESSAGE"
/** 退出是刷新系统消息 */
#define LOGOUT_SERVER_MESSAGE @"LOGOUT_SERVER_MESSAGE"

/** 登入和登出 */
#define LS_LOGIN_IN @"QYQ_LOGIN_IN"
#define LS_LOGIN_OUT @"QYQ_LOGIN_OUT"

//两次铃声提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;

/** 屏幕大小*/
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

/** 弱引用*/
#define LSWeak(var, weakVar) __weak __typeof(&*var) weakVar = var
#define LSWeakSelf LSWeak(self,__weakSelf);
/** iOS系统版本大于等于8.0*/
#define QYQiOSGreaterThanEight                                                 \
([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)


#endif /* SaplingNoticeDefine_h */
