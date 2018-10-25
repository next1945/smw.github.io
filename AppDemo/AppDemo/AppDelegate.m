//
//  AppDelegate.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/runtime.h>
#import "NYSTabViewController.h"
#import "NYSLoginViewController.h"
#import "NYSNewFeatureViewController.h"
#import "QMHCommitView.h"
#import "NYSChatDataSource.h"

#import <UIImageView+WebCache.h>
#import <RongIMKit/RongIMKit.h>
#import <JPUSHService.h>
#import <AdSupport/AdSupport.h>
#import <UserNotifications/UserNotifications.h>
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UMCommonLog/UMCommonLogManager.h>
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
   
    // 0、友盟分享
    [UMCommonLogManager setUpUMCommonLogManager];
    [UMConfigure setLogEnabled:YES]; // 设置打开日志
    [UMConfigure initWithAppkey:UMAPPKEY channel:@"App Store"];
    // 配置WeiChat/QQ的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAPPID appSecret:APPSECRET redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAPPID appSecret:QQAPPKEY redirectURL:nil];
    
    // 1、初始化融云 SDK
    [[RCIM sharedRCIM] initWithAppKey:RCAPPKEY];
    // 2、连接融云服务器
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    [[RCIM sharedRCIM] connectWithToken:[userdefaults objectForKey:@"rongyunToken"] success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        RCUserInfo *currentUserInfo = [[RCUserInfo alloc] init];
        currentUserInfo.name = [userdefaults objectForKey:@"nickName"];
        currentUserInfo.portraitUri = [userdefaults objectForKey:@"imgAddress"];
        currentUserInfo.userId = [userdefaults objectForKey:@"account"];
        
        // 2.1.设置当前登录的用户的用户信息
        [[RCIM sharedRCIM] setCurrentUserInfo:currentUserInfo];
        
        // 2.2.设置用户信息源和群组信息源
        [RCIM sharedRCIM].userInfoDataSource = [NYSChatDataSource shareInstance];
        [RCIM sharedRCIM].groupInfoDataSource = [NYSChatDataSource shareInstance];
        
        // 2.3.离线历史消息（1天）
        [[RCIMClient sharedRCIMClient] setOfflineMessageDuration:1 success:^{
            
        } failure:^(RCErrorCode nErrorCode) {
            
        }];
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", status);
    } tokenIncorrect:^{
        // token过期或者不正确。
        // 如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        // 如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    
    /**
     * 3、融云推送处理1
     */
    // 注册推送, 用于iOS8以及iOS8之后的系统
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    [RCIM sharedRCIM].disableMessageNotificaiton = NO;
    
    /**
     * 4、极光推送处理1
     */
    // 4.1注册
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // 4.2获取IDFA
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    /**
     * 5、极光推送处理2
     */
    // 5.1初始化
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_APPKEY
                          channel:JPUSH_CHANNEl
                 apsForProduction:isProdution
            advertisingIdentifier:advertisingId];
    
    // 6、判断是否存储账号信息
    [NTKChooseRootController ChooseRootController:^{
        [UIApplication sharedApplication].keyWindow.rootViewController = [[NYSLoginViewController alloc] init];
    } OrtabBarVC:^{
        [UIApplication sharedApplication].keyWindow.rootViewController = [[NYSTabViewController alloc] init];
    } OrNewfeatureVC:^{
        [UIApplication sharedApplication].keyWindow.rootViewController = [[NYSNewFeatureViewController alloc] init];
    } withAccountKey:@"account" andTokenKey:@"token"];
//    [UIApplication sharedApplication].keyWindow.rootViewController = [[NYSTabViewController alloc] init];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // 友盟分享回调
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    // 支付结果回调（微信&支付宝）
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        WS(weakSelf);
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [weakSelf popPayStatusWithResultDic:resultDic];
        }];
        return YES;
    }
    
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// NOTE: 9.0以后使用新回调API接口
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 90000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付结果回调（微信&支付宝）
        WS(weakSelf);
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [weakSelf popPayStatusWithResultDic:resultDic];
        }];
        return YES;
    }
    
    return result;
}
#endif

/**
 支付结果状态弹框
 */
- (void)popPayStatusWithResultDic:(NSDictionary *)resultDic {
    NSString *payMsg = [NSString stringWithFormat:@"%@", resultDic[@"memo"]];
    QMHCommitView *popUP = [[[NSBundle mainBundle] loadNibNamed:@"QMHCommitView" owner:nil options:nil] lastObject];
    if ([resultDic[@"resultStatus"] isEqual:@"9000"]) {
        [popUP setTitleString:@"支付结果" SubtitleString:@"支付成功！" popMessagesString:payMsg statusImageNamed:@"成功"];
    } else {
        [popUP setTitleString:@"支付结果" SubtitleString:@"支付失败！" popMessagesString:payMsg statusImageNamed:@"失败"];
    }
    popUP.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:popUP];
}

/**
 * 融云推送处理2
 */
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // 注册用户通知设置
    [application registerForRemoteNotifications];
}

/**
 * 融云 + 极光 推送处理3 获取deviceToken
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 融云 注册DeviceToken
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
    // 极光 注册DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // 注册APNs失败
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    [SVProgressHUD showInfoWithStatus:@"通知监听方法1"];
    [SVProgressHUD dismissWithDelay:2.f];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [SVProgressHUD showInfoWithStatus:@"通知监听方法2"];
    [SVProgressHUD dismissWithDelay:2.f];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [SVProgressHUD showInfoWithStatus:@"本地通知监听方法"];
    [SVProgressHUD dismissWithDelay:2.f];
}

#pragma mark- JPUSHRegisterDelegate 极光
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // iOS 10 Support 前台监听收到通知
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // iOS 10 Support 通知点击响应
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        // 取得APNs标准信息内容
        NSDictionary *aps = [userInfo valueForKey:@"aps"];
        NSString *content = [aps valueForKey:@"alert"]; // 推送显示的内容
        NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; // badge数量
        NSString *sound = [aps valueForKey:@"sound"]; // 播放的声音
        // 非空 取得Extras字段内容
        if (![[userInfo valueForKey:@"extras"] isKindOfClass:[NSNull class]]) {
            NSString *type = [userInfo valueForKey:@"type"]; // 任务单type 单子类型:1投诉单;2报修单;3预约单;4房屋审核单
            NSString *requestId = [userInfo valueForKey:@"requestId"]; // 任务单ID
            NSLog(@"content =[%@], badge=[%ld], sound=[%@], type=[%@], requestId=[%@]", content, badge, sound, type, requestId);
            // 跳转控制器
            switch ([type integerValue]) {
                case 1: { // 1投诉单
                    
                }
                    break;
                    
                case 2: { // 2报修单
                    
                }
                    break;
                    
                case 3: { // 3预约单
                    
                }
                    break;
                    
                case 4: { // 4审核单
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
        // 处理通知
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    completionHandler();
}

#pragma mark- RCIMReceiveMessageDelegate 融云
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    }];
}

#pragma mark- AppDelegate 系统
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 角标处理
    int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                         @(ConversationType_PRIVATE),
                                                                         @(ConversationType_DISCUSSION),
                                                                         @(ConversationType_PUBLICSERVICE),
                                                                         @(ConversationType_PUBLICSERVICE),
                                                                         @(ConversationType_GROUP)
                                                                         ]];
    application.applicationIconBadgeNumber = unreadMsgCount;
    [JPUSHService setBadge:application.applicationIconBadgeNumber];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // 在应用程序终止之前保存应用程序的管理对象上下文的更改
    [self saveContext];
}

#pragma mark - 添加应用图标3Dtouch
- (void)add3DTouchItems:(UIApplication *)application{
    // 移动巡检
    UIApplicationShortcutIcon *iconMobileInspection = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeConfirmation];
    UIMutableApplicationShortcutItem *itemMobileInspection = [[UIMutableApplicationShortcutItem alloc] initWithType:@"1" localizedTitle:@"移动巡检"];
    itemMobileInspection.icon = iconMobileInspection;
    
    // 健康指数
    UIApplicationShortcutIcon *iconHealthIndex = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeDate];
    UIMutableApplicationShortcutItem *itemHealthIndex = [[UIMutableApplicationShortcutItem alloc] initWithType:@"2" localizedTitle:@"健康指数"];
    itemHealthIndex.icon = iconHealthIndex;
    
    // 发布大小事
    UIApplicationShortcutIcon *iconPosting = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    UIMutableApplicationShortcutItem *itemPosting = [[UIMutableApplicationShortcutItem alloc] initWithType:@"3" localizedTitle:@"发布大小事"];
    itemPosting.icon = iconPosting;
    
    //绑定到App icon
    application.shortcutItems = @[itemMobileInspection,itemHealthIndex,itemPosting];
    
}

// UIApplicationDelegate 在这里处理点击的item
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    NSLog(@"UIApplicationShortcutItem == %@",shortcutItem);
    switch (shortcutItem.type.integerValue) {
        case 1:
//            [self.window.rootViewController presentViewController:[[QMHBarCodeViewController alloc] init] animated:YES completion:nil];
            break;
            
        case 2: {
//            QMHHealthIndexViewController *HealthIndexVC = [[QMHHealthIndexViewController alloc] init];
//            UIView *rightContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 22)];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:HealthIndexVC];
//            UIButton *rbtn = [[UIButton alloc] initWithFrame:rightContentView.bounds];
//            [rbtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//            objc_setAssociatedObject(rbtn, @"customVC", HealthIndexVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            [rbtn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
//            [rightContentView addSubview:rbtn];
//            HealthIndexVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightContentView];
//            HealthIndexVC.title = @"健康指数";
//            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        }
            break;
            
        case 3: {
//            QMHPublishSomethingViewController *HealthIndexVC = [[QMHPublishSomethingViewController alloc] init];
//            UIView *rightContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 22)];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:HealthIndexVC];
//            UIButton *rbtn = [[UIButton alloc] initWithFrame:rightContentView.bounds];
//            [rbtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//            objc_setAssociatedObject(rbtn, @"customVC", HealthIndexVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            [rbtn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
//            [rightContentView addSubview:rbtn];
//            HealthIndexVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightContentView];
//            HealthIndexVC.title = @"发布大小事";
//            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

- (void)dismiss:(UIButton *)sender {
    [objc_getAssociatedObject(sender, @"customVC") dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"AppDemo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
