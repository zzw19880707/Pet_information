//
//  BasePhotoViewController.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-5.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "AOWaterView.h"
#import "MBProgressHUD.h"
@interface BasePhotoViewController : UIViewController<EGORefreshTableDelegate,UIScrollViewDelegate,imageDelegate>
{
    //EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;
    
    __block MBProgressHUD *_HUD;
}
@property(nonatomic,strong)  AOWaterView *aoView;
//获取的data数据
//@property(nonatomic,retain) __block NSMutableArray *data;
//访问路径
@property (nonatomic,retain) NSString *baseURL;
//访问参数
@property (nonatomic,retain) NSMutableDictionary *params;


@end
