//
//  SaplingMainVC.m
//  Sapling
//
//  Created by sport on 16/4/20.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "SaplingMainVC.h"
#import "LSNavgationController.h"

#import "LSDiscoverVC.h"
#import "LSConversationVC.h"
#import "LSMineVC.h"
#import "LSContactVC.h"
#import "LSContactViewController.h"
#import "LSConversationViewController.h"
#import <AudioToolbox/AudioToolbox.h>

/** 发现示例*/
/** 1.SDContactsController*/
#import "LSSDContactsTableViewController.h"

@interface SaplingMainVC ()<EMDEngineMangerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) LSConversationViewController * conversationVC;
@property (nonatomic, strong) LSContactViewController * contactVC ;
@property (nonatomic, strong) LSMineVC * mineVC ;

/** 如果是删除好友的通知,则无铃声提示*/
@property (nonatomic, assign) BOOL isDeleteNoti;

@property(strong, nonatomic) NSDate *lastPlaySoundDate;


@end

@implementation SaplingMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildViewControllers];
    [self configObserver];
    // Do any additional setup after loading the view.
}
#pragma mark - make UI
/** 添加子控制器*/
- (void)addAllChildViewControllers{
 
    _contactVC = [[LSContactViewController alloc]init];
    _conversationVC = [[LSConversationViewController alloc]init];
    _mineVC = [[LSMineVC alloc]init];
    
    //
//    LSDiscoverVC * discover = [[LSDiscoverVC alloc]init];
    //SD的通讯录(可靠快速的通讯录排序)
    LSSDContactsTableViewController * discover = [[LSSDContactsTableViewController alloc]init];
    //SDContactsController
    
    [self addOneChlildVc:_conversationVC
                   title:@"Message"
               imageName:@"tabbar_mainframe"
       selectedImageName:@"tabbar_mainframeHL"];
    
    [self addOneChlildVc:_contactVC
                   title:@"Contact"
               imageName:@"tabbar_contacts"
       selectedImageName:@"tabbar_contactsHL"];
    
    [self addOneChlildVc:_mineVC
                   title:@"Mine"
               imageName:@"tabbar_me"
       selectedImageName:@"tabbar_meHL"];
    
    [self addOneChlildVc:discover
                   title:@"Discover"
               imageName:@"tabbar_discover"
       selectedImageName:@"tabbar_discoverHL"];

}
/** 添加视图控制器*/
- (void)addOneChlildVc:(UIViewController *)childVc
                 title:(NSString *)title
             imageName:(NSString *)imageName
     selectedImageName:(NSString *)selectedImageName {
    childVc.tabBarItem.title = title;
    childVc.navigationItem.title = title;
    
    [childVc.tabBarItem setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName : BASE_GREEN_COLOR
                                                 } forState:UIControlStateSelected];
    
    [childVc.tabBarItem setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName : BASE_FONT_COLOR
                                                 } forState:UIControlStateNormal];
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    self.mainBarNav = [[LSNavgationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:self.mainBarNav];

    
}
#pragma mark -- Add Observer
/** 处理消息的各种通知*/
- (void)configObserver{
    
    EMDEngineManger * engine = [EMDEngineManger sharedInstance];
    engine.delegate = self;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateTabbarBadge)
     name:UPDATE_BADGE
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(userLogin:)
     name:LS_LOGIN_IN
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(userLoginOut:)
     name:LS_LOGIN_OUT
     object:nil];
}

#pragma mark -- Message Services
#pragma mark -- Message Delegate
/** 接受一条消息并响铃*/
- (void)didReceivedMessage:(EMsgMessage *)msg {
    [self storeSingleMessage:msg];
    [self playSoundAndVibration:nil];
}

- (void)didReceivedOfflineMessageArray:(NSArray *)array {
    for (EMsgMessage *msg in array) {
        [self storeSingleMessage:msg];
    }
}

- (void)didKilledByServer{
    //将登陆状态置成为登陆
    [ZXCommens putLoginState:NO];
    [ZXCommens deleteUserInfo];
    UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的账号已经在别处登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [al show];
}

- (void)playSoundAndVibration:(NSString *)soundName {
    NSTimeInterval timeInterval =
    [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval || _isDeleteNoti) {
        _isDeleteNoti = NO;
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        return;
    }
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    [self reciveMessageSound:soundName];
}

- (void)reciveMessageSound:(NSString *)soundname {
    static SystemSoundID soundIDTest = 0;
    
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/sms-received1.caf"];
    if (path) {
        
        AudioServicesCreateSystemSoundID(
                                         (__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest);
    }
    
    AudioServicesPlaySystemSound(soundIDTest);
}
#pragma mark -- Store Message
/** 存储单条消息*/
- (void)storeSingleMessage:(EMsgMessage *)storeMessage{
    ZXUser * userInfo = [ZXCommens fetchUser];
    if (userInfo.token) {
        
        NSString * chatterId = [ZXCommens subQiuYouNo:storeMessage.envelope.from];
        storeMessage = [self factionaryMessage:storeMessage];
        //如果是删除好友的消息不显示,直接删除
        if (storeMessage == nil) {
            return;
        }
        if ([storeMessage.envelope.type intValue] >= 100) {
            storeMessage.unReadCountStr = @"1";
            BOOL isInsertResult = [[FMDBManger shareInstance] insertOneChatList:storeMessage withChatter:chatterId];
            //如果插入数据失败(主键冲突)不进行人和操作
            if (!isInsertResult) {
                return;
            }
            [self updateTabbarBadge];
            //通知刷新刷新消息
            NSNotification *notification =
            [NSNotification notificationWithName:NEW_SERVER_MESSAGE
                                          object:nil
                                        userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            return;
        }
        //如果不是系统消息，执行下面的操作
        //如果是是群组消息重写chatterId,group+群组id拼接
        if ([storeMessage.envelope.type isEqualToString:@"2"]) {
            chatterId = [NSString stringWithFormat:@"group%@",storeMessage.envelope.gid];
            storeMessage.envelope.from = [NSString stringWithFormat:@"group%@@",storeMessage.envelope.gid];
            storeMessage.payload.attrs.messageFromNickName = storeMessage.payload.attrs.messageGroupName;
        }
        
        NSMutableArray * resultArray = [[NSMutableArray alloc] init];
        
        resultArray = [[FMDBManger shareInstance] fetchAllSelReslult];
        
        //判断临时会话列表数据表中是否有这条数据
        BOOL isExitInChatList = NO;
        //存在的消息，更新
        EMsgMessage * sameMsg = nil;
        for (EMsgMessage * msg in resultArray) {
            if ([msg.chatId isEqualToString:[NSString stringWithFormat:@"%@%@",userInfo.uid,chatterId]]) {
                sameMsg = msg;
                isExitInChatList = YES;
                break;
            }
        }
        //如果数据库查询不到，说明也是首次
        if (resultArray.count == 0) {
            isExitInChatList = NO;
        }
        //如果存在，在消息数据表里插入一条数据
        if (isExitInChatList) {
            //先在消息数据表里插入一条数据
            storeMessage.isReaded = @"no";
            storeMessage.isSendFail = NO;
            BOOL isResult =  [[FMDBManger shareInstance] insertOneMessage:storeMessage withChatter:chatterId];
            //如果插入数据失败(主键冲突),就不更新状态也不做其他的处理
            if (!isResult) {
                return ;
            }
            //同时更新原消息的未读内容和数量
            
            NSInteger  sameMsgUnCount = [sameMsg.unReadCountStr integerValue];
            storeMessage.unReadCountStr = [NSString stringWithFormat:@"%ld",sameMsgUnCount + 1];
            [[FMDBManger shareInstance] updateOneChatListMessageWithChatter:chatterId andMessage:storeMessage];
        }
        //如果不存在
        else{
            //先在消息数据表里插入一条数据
            storeMessage.isReaded = @"no";
            storeMessage.isSendFail = NO;
            storeMessage.chatId = [NSString stringWithFormat:@"%@%@",userInfo.uid,chatterId];
            [[FMDBManger shareInstance] insertOneMessage:storeMessage withChatter:chatterId];
            //同时在临时会话列表里插入一条数据
            storeMessage.unReadCountStr = @"1";
            [[FMDBManger shareInstance] insertOneChatList:storeMessage withChatter:chatterId];
        }
        //刷新角标
        [self updateTabbarBadge];
        //通知刷新刷新消息
        NSNotification *notification =
        [NSNotification notificationWithName:NEW_MESSAGE
                                      object:nil
                                    userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}



- (EMsgMessage *)factionaryMessage:(EMsgMessage *)message{
    if ([message.payload.attrs.message_type isEqualToString:@"contact"]) {
        if ([message.payload.attrs.action isEqualToString:@"add"]) {
            message.envelope.type = @"100";
        }
        if ([message.payload.attrs.action isEqualToString:@"reject"]) {
            message.envelope.type = @"101";
        }
        if ([message.payload.attrs.action isEqualToString:@"accept"]) {
            message.envelope.type = @"102";
        }
        if ([message.payload.attrs.action isEqualToString:@"delete"]) {
            _isDeleteNoti = YES;
            //刷新好友
            [_contactVC apiRequestContactList];
            [[FMDBManger shareInstance] delOneChatIdAllMessage:message.payload.attrs.contact_id];
            [[FMDBManger shareInstance] deleteOneChatAllMessageWithChatter:message.payload.attrs.contact_id];
            //通知chatlist
            NSNotification *notification =
            [NSNotification notificationWithName:NEW_MESSAGE
                                          object:nil
                                        userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            //通知刷新tabbar刷新消息
            NSNotification *notification1 =
            [NSNotification notificationWithName:UPDATE_BADGE
                                          object:nil
                                        userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification1];
            message = nil;
            
        }
    }
    return message;
}
#pragma mark -- actions

/** 刷新角标*/
- (void)updateTabbarBadge{
    [[FMDBManger shareInstance] fetchAllNoReadMessage:^(NSInteger noCount) {
        
        
    } andChatterCount:^(NSInteger noChatterCount) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (noChatterCount > 0) {
                _conversationVC.tabBarItem.badgeValue =
                [NSString stringWithFormat:@"%lu", (long)noChatterCount];
            } else {
                _conversationVC.tabBarItem.badgeValue = nil;
            }
        });
        
    } andServerCount:^(NSInteger noServerCount) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (noServerCount > 0) {
                _contactVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu", (long)noServerCount];
                _contactVC.noReadServerMessageLabel.hidden = NO;
                
            }
            else{
                _contactVC.tabBarItem.badgeValue = nil;
                _contactVC.noReadServerMessageLabel.hidden = YES;
            }
        });
        
    }];
    
}

- (void)userLogin:(NSNotification *)noti{
    
}

- (void)userLoginOut:(NSNotification *)noti{
}

#pragma mark --

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_STATE object:@NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
