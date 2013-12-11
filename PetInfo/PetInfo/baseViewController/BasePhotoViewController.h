//
//  BasePhotoViewController.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-5.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "MBProgressHUD.h"
#import "FullView.h"
#import "BaseViewController.h"
@interface BasePhotoViewController : BaseViewController<EGORefreshTableDelegate,UIScrollViewDelegate,ASIRequest,FullImageViewDelegate>
{
    //EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;
    
    __block MBProgressHUD *_HUD;
    
    DataService *_dataService;
//全屏视图
    FullView *_fullImageView;
//登陆用户id
    NSInteger _user_id;
}

//获取的data数据
@property(nonatomic,retain)  NSMutableArray *data;
//访问路径
@property (nonatomic,retain) NSString *baseURL;
//访问参数
@property (nonatomic,retain) NSMutableDictionary *params;


@end
