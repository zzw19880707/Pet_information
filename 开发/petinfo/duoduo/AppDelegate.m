//
//  AppDelegate.m
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate
#pragma mark method
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // 注册通知（声音、标记、弹出窗口）
    if(!application.enabledRemoteNotificationTypes){
        NSLog(@"Initiating remoteNoticationssAreActive1");
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
    }

    [application  registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
//    if (launchOptions !=nil) {
//        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//        NSString *alertString = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
//        NSString *newsId = [userInfo objectForKey:@"newsId"];
//        if (newsId) {
//            NSDictionary *dic = @{@"newsId":newsId,
//                                  @"title": alertString,
//                                  @"newsAbstract":[userInfo objectForKey:@"newsAbstract"],
//                                  @"type":[userInfo objectForKey:@"type"],
//                                  @"img":[userInfo objectForKey:@"img"]==nil?@"":[userInfo objectForKey:@"img"]
//                                  };
//            NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
//            [userdefaults setObject:dic forKey: kServletPush_Model ];
//            [userdefaults synchronize];
//            [self performSelector:@selector(pushmodel) withObject:nil afterDelay:6];
//        }
//        
//    }

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MainViewController alloc]init];
    [self.window makeKeyAndVisible];
    
    //设置百度推送代理
    [BPush setupChannel:launchOptions];
    [BPush setDelegate:self];
    //设置角标为0
    [application setApplicationIconBadgeNumber:0];
    
//    //已经使用过的用户
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:kbundleVersion]) {
//        
//        //设置文件初始化
//        NSString *settingPath = [[FileUrl getDocumentsFile] stringByAppendingPathComponent: kSetting_file_name];
//        [[NSFileManager defaultManager] createFileAtPath: settingPath contents: nil attributes: nil];
//        //设置文件信息
//        NSMutableDictionary *settingDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys: [NSNumber numberWithInt: 1], kFont_Size, [NSNumber numberWithBool: YES], KNews_Push, nil];
//        [settingDic writeToFile: settingPath atomically: YES];
//    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}


//注册token
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [BPush registerDeviceToken: deviceToken];
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:BPushappid] ==nil||[[[NSUserDefaults standardUserDefaults]objectForKey:BPushappid]isEqualToString:@""]) {
//        //绑定
//        [BPush bindChannel];
//    }
}

//后台激活后 移除推送信息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //    NSLog(@"Receive Notify: %@", [userInfo JSONString]);
//    NSString *alertString = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
//    if (application.applicationState == UIApplicationStateActive) {
//        NSString *newsId = [userInfo objectForKey:@"newsId"];
//        if (newsId) {
//            // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送新闻:"
//                                                                message:[NSString stringWithFormat:@"%@", alertString]
//                                                               delegate:self
//                                                      cancelButtonTitle:@"好的"
//                                                      otherButtonTitles:@"查看",nil];
//            ColumnModel *model = [[ColumnModel alloc]init];
//            model.newsId = newsId;
//            model.title = alertString;
//            model.newsAbstract = [userInfo objectForKey:@"newsAbstract"];
//            model.type = [userInfo objectForKey:@"type"];
//            model.img = [userInfo objectForKey:@"img"];
//            model.isselected = NO;
//            _pushModel = model;
//            [alertView show];
//        }else{
//            // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送新闻:"
//                                                                message:[NSString stringWithFormat:@"%@", alertString]
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles:nil];
//            [alertView show];
//            
//        }
//    }else if (application.applicationState == UIApplicationStateInactive){//进入激活状态  默认查看新闻
//        NSString *newsId = [userInfo objectForKey:@"newsId"];
//        if (newsId) {
//            ColumnModel *model = [[ColumnModel alloc]init];
//            model.newsId = newsId;
//            model.title = alertString;
//            model.newsAbstract = [userInfo objectForKey:@"newsAbstract"];
//            model.type = [userInfo objectForKey:@"type"];
//            model.img = [userInfo objectForKey:@"img"];
//            model.isselected = NO;
//            _pushModel = model;
//            [[NSNotificationCenter defaultCenter]postNotificationName:kPushNewsNotification object:_pushModel];
//        }
//        
//    }
//    [application setApplicationIconBadgeNumber:0];
//    [BPush handleNotification:userInfo];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}


#pragma mark pushdelegate  回调函数
- (void) onMethod:(NSString*)method response:(NSDictionary*)data {
//    NSLog(@"On method:%@", method);
//    NSLog(@"data:%@", [data description]);
//    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
//    if ([BPushRequestMethod_Bind isEqualToString:method]) {//绑定
//        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
//        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
//        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
//        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
//        if (returnCode == BPushErrorCode_Success) {
//            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//            [user setValue:appid forKey:BPushappid];
//            [user setValue:userid forKey:BPushuserid];
//            [user setValue:channelid forKey:BPushchannelid];
//            //同步
//            [user synchronize];
//            
//        }
//    } else if ([BPushRequestMethod_Unbind isEqualToString:method]) {//解除绑定
//        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
//        if (returnCode == BPushErrorCode_Success) {
//            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//            [user removeObjectForKey:BPushchannelid];
//            [user removeObjectForKey:BPushuserid];
//            [user removeObjectForKey:BPushappid];
//            //同步
//            [user synchronize];
//        }
//    }
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //设置角标为0
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
