//
//  kPetInfo.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#ifndef PetInfo_kPetInfo_h
#define PetInfo_kPetInfo_h

#pragma mark NSNotificationCenter
//首页加载时,定位完成的通知
#define isEndLocation @"isEndLocation"
#define isLoadHomeData @"isLoadHomeData"

#pragma mark UserDefaults
//判断是否是第一次登陆
#define isFirstLogin @"isFirstLogin"
//百度推送绑定信息
#define BPushchannelid @"BPushchannelid"
#define BPushappid @"BPushappid"
#define BPushuserid @"BPushuserid"
//经纬度
#define user_longitude @"longitude"
#define user_latitude @"latitude"
//判断进入程序后是否定位
#define isLocation @"isLocation"
//用户登陆后返回的id
#define user_id @"user_id"

#pragma mark Pet_Color
#define PetTextColor COLOR(88, 195, 241)
#define PetBackgroundColor COLOR(247, 247, 247)
#endif
