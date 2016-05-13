//
//  AppDelegate.m
//  Sapling
//
//  Created by sport on 16/4/20.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "AppDelegate.h"
#import "SaplingMainVC.h"
#import "LSWelcomeViewController.h"
#import "LSLoginViewController.h"
#import "LSNavgationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    /** 注册推送*/
    [self registerRemoteNotification];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self showVC];

    
    [self.window makeKeyAndVisible];
    
    /** 接收通知*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:LOGIN_STATE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:QYQ_RECREATE_ROOT object:nil];
    
    return YES;
}
#pragma mark - 确定显示控制器
- (void)showVC{
    
    NSString *key = @"CFBundleShortVersionString";
    //先去沙盒中取出上次使用的版本号
    NSString *lastVerionCode = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //加载程序中info.plist文件（获取当前软件的版本号）
    NSString *currentVerionCode = [NSBundle mainBundle].infoDictionary[key];
    
    if ([lastVerionCode isEqualToString:currentVerionCode]) {
        //非第一次使用
        [self loginStateChange:nil];
        
    } else {
        //保存当前软件版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVerionCode forKey:key];
        //持久保存
        [[NSUserDefaults standardUserDefaults] synchronize];
        LSWelcomeViewController *appStartController = [[LSWelcomeViewController alloc] init];
        self.window.rootViewController = appStartController;
    }

    
}
/** 根据登陆状态改变*/
- (void)loginStateChange:(NSNotification *)notification{
    
    if (notification == nil) {
        
        if ([ZXCommens isLogin]) {
            self.window.rootViewController = [[SaplingMainVC alloc] init];
        }
        else{
            self.window.rootViewController = [[LSNavgationController alloc] initWithRootViewController:[[LSLoginViewController alloc] init]];
        }
        return ;
    }
    BOOL isState = [notification.object boolValue];
    [ZXCommens putLoginState:isState];
   
    if (isState) {
        
        self.window.rootViewController = [[SaplingMainVC alloc] init];
    }
    else{
        self.window.rootViewController = [[LSNavgationController alloc] initWithRootViewController:[[LSLoginViewController alloc] init]];
    }
}

#pragma mark - 注册APNS
- (void)registerRemoteNotification {
#if !TARGET_IPHONE_SIMULATOR
    UIApplication * application = [UIApplication sharedApplication];
    /** iOS8 注册APNS*/
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        
        [application registerForRemoteNotifications];
        
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        UIUserNotificationSettings *settings =[UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        
        [application registerUserNotificationSettings:settings];
        
    } else {
        
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
        
        [[UIApplication sharedApplication]registerForRemoteNotificationTypes:notificationTypes];
    }
#endif
    
}
/** 如果注册APNS成功，此代理方法则会返回DeviceToken*/
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /** 获取device，放在本地*/
    NSString *token = [[[[deviceToken description]
                         stringByReplacingOccurrencesOfString:@"<" withString:@""]
                        stringByReplacingOccurrencesOfString:@">"
                        withString:@""]
                       stringByReplacingOccurrencesOfString:@" "
                       withString:@""];
    
    [ZXCommens putDeviceToken:token];
}
/** 注册deviceToken失败，一般是环境配置或者证书配置有误*/
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    UIAlertView * alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@"apns.failToRegisterApns",Fail to register apns)
                          message: error.description
                          delegate: nil
                          cancelButtonTitle: NSLocalizedString(@"ok", @"OK")
                          otherButtonTitles: nil];
    [alert show];
}
#pragma mark - 当APP活跃的时候调用 - 登陆服务器
/** 当App程序活跃的时候调用*/
- (void)autoLoginMsgCilent {
    
    ZXUser *userInfoModel = [ZXCommens fetchUser];
    
    if (userInfoModel.token) {
        //异步登陆账号
        EMDEngineManger * engine = [EMDEngineManger sharedInstance];
        if (![engine isAuthed]) {
            NSString *username =[NSString stringWithFormat:@"%@@%@/%@", userInfoModel.uid,userInfoModel.domain,userInfoModel.uid];
            BOOL successed =
            [engine auth:username
            withPassword:userInfoModel.token
                withHost:userInfoModel.host
                withPort:[userInfoModel.port integerValue]];
            if (successed) //连接成功
            {
                
            } else { //连接失败
                [engine autoReconnect];
            }
        }
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
#pragma mark - APP 变成活跃的
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [self autoLoginMsgCilent];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
