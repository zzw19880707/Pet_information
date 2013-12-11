//
//  BaseViewController.h
//  tabbartest
//
//  Created by 佐筱猪 on 13-10-15.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import <CoreLocation/CoreLocation.h>

@class MBProgressHUD;
@interface BaseViewController : UIViewController <UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,CLLocationManagerDelegate>{
    UIWindow *_tipWindow;
    //经纬度
    float _longitude;
    float _latitude;
    
}
@property(nonatomic,retain)MBProgressHUD *hud;
//@property(nonatomic,assign)BOOL isBackButton; //navigation 返回

@property (nonatomic,assign)BOOL isCancelButton;//取消按钮
-(AppDelegate *)appDelegate;

//显示加载提示
- (void)showHUD:(NSString *)title isDim:(BOOL)isDim;
//显示加载完成提示
- (void)showHUDComplete:(NSString *)title;
//隐藏加载提示
- (void)hideHUD;
-(void)showStaticTip:(BOOL)show title:(NSString *)title;//设置状态栏提示
//提示登录对话框
-(void)alertLoginView;
@property (nonatomic,retain) ASIHTTPRequest *request;
@end
