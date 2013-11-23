//
//  AppDelegate.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-16.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"


@implementation AppDelegate
#pragma mark 内存管理
- (void)dealloc
{
    [_window release];
    [super dealloc];
}
#pragma mark 入口
//程序入口
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //初始化MainViewController
    MainViewController *main=[[MainViewController alloc]init];
    self.window.rootViewController=main;
    [main release];
    //设置百度推送代理
    [BPush setupChannel:launchOptions];
    [BPush setDelegate:self];
    //设置角标为0
    [application setApplicationIconBadgeNumber:0];
    // 注册通知（声音、标记、弹出窗口）
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeAlert
     | UIRemoteNotificationTypeBadge
     | UIRemoteNotificationTypeSound];
    
    
    [self.window makeKeyAndVisible];

    return YES;
}
//注册token
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [BPush registerDeviceToken: deviceToken];
    _po(deviceToken);
#warning <#message#>
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Receive Notify: %@", [userInfo JSONString]);
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (application.applicationState == UIApplicationStateActive) {
        // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Did receive a Remote Notification"
                                                            message:[NSString stringWithFormat:@"The application received this remote notification while it was running:\n%@", alert]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    [application setApplicationIconBadgeNumber:0];
    
    [BPush handleNotification:userInfo];
    
//    self.viewController.textView.text = [self.viewController.textView.text stringByAppendingFormat:@"Receive notification:\n%@", [userInfo JSONString]];
}
- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
//    self.viewController.appidText.text = self.appId;
//    self.viewController.useridText.text = self.userId;
//    self.viewController.channelidText.text = self.channelId;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //设置角标为0
    [application setApplicationIconBadgeNumber:0];
//    self.viewController.appidText.text = [BPush getAppId];
//    self.viewController.useridText.text = [BPush getUserId];
//    self.viewController.channelidText.text = [BPush getChannelId];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

#pragma mark pushdelegate  回调函数
- (void) onMethod:(NSString*)method response:(NSDictionary*)data {
    NSLog(@"On method:%@", method);
    NSLog(@"data:%@", [data description]);
    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
    if ([BPushRequestMethod_Bind isEqualToString:method]) {
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        
        if (returnCode == BPushErrorCode_Success) {
//            self.viewController.appidText.text = appid;
//            self.viewController.useridText.text = userid;
//            self.viewController.channelidText.text = channelid;
            
            // 在内存中备份，以便短时间内进入可以看到这些值，而不需要重新bind
//            self.appId = appid;
//            self.channelId = channelid;
//            self.userId = userid;
        }
    } else if ([BPushRequestMethod_Unbind isEqualToString:method]) {
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
//            self.viewController.appidText.text = nil;
//            self.viewController.useridText.text = nil;
//            self.viewController.channelidText.text = nil;
        }
    }
//    self.viewController.textView.text = [[NSString alloc] initWithFormat: @"%@ return: \n%@", method, [data description]];
}
@end
