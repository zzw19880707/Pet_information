//
//  MainViewController.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MainViewController : UITabBarController <CLLocationManagerDelegate,ASIRequest>{
    UIView *_tabbarView;//tabbar
    UIImageView *_sliderView;//滑动器
    float _longitude;
    float _latitude;
//  加载时大图
    UIImageView *_backgroundView;
    ASIHTTPRequest *request;
    //初始化home数据
    NSArray *_data;
    NSArray *_celldata;
    
    //用于判断是否 移除并初始化过
    BOOL _isRemove;
}

@end
