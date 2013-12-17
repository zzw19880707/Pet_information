//
//  BaseURL+Implements.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#ifndef PetInfo_BaseURL_Implements_h
#define PetInfo_BaseURL_Implements_h

#define BASE_URL @"http://192.168.1.145:8080/petInfo/"
//#define BASE_URL @"http://192.168.1.102:8080/petInfo/"

#pragma mark HomeViewController

//首页获取滚动条接口  和每日一泡数据接口
/*
params :
用户id:user_id(可为空)
 */
#define GetAOImg @"AoServlet"

//登陆过的用户，提交登陆时间及位置的接口
/*
params :
用户id:user_id
经度:longitude
纬度:latitude
 */
#define HomeLogin @"HomeLogin"

//分享图片 接口
/*
params :
用户id:user_id
经度:longitude
纬度:latitude
图片:null
 */
#define UploadServlet @"UploadServlet"

//点赞/鄙视接口
/*
params :
用户id:user_id
图片id:image_id
投票类型:key(good/bad)
投票操作:value(add/sub)
 */
#define VoteServlet @"VoteServlet"

//每日一泡，更多按钮的接口数据
/*
 params :
 获取个数:count(空为默认10个)
 最后一个排名:lastid（空为前10个）
 */
#define EveryServlet @"EveryServlet"

//照片墙数据接口
/*
 params :
 获取个数:count(空为默认10个)
 最后一个排名:lastid（空为前10个）
 */
#define PhotoWallServlet @"PhotoWallServlet"

//药品列表
/*
 params:
 类别:category
 获取个数:count(空为默认10个)
 最后一个排名:lastid（空为前10个）
 */
#define MedicineServlet @"MedicineServlet"

//药品详细列表
/*
 */
#define MedicineDetailServlet @"MedicineServlet"
//药品详细信息
#define MedicineDetailOneServlet @"MedicineDetailServlet"

//附近列表
/*
 */
#define NearServlet @"NearServlet"

//附近详细列表
/*
 */
#define NearDetailServlet @"NearServlet"

//常见病列表
/*
 */
#define DiseaseServlet @"DiseaseServlet"

//常见详细病列表
/*
 */
#define DiseaseDetailServlet @"DiseaseServlet"
//常见病单独详细信息
#define DiseaseDetailOneServlet @"DiseaseDetailServlet"

#pragma mark MoreViewController

//用户登陆接口
#define LoginServlet @"LoginServlet"
//用户注册接口
#define RegistServlet @"RegistServlet"
#endif
