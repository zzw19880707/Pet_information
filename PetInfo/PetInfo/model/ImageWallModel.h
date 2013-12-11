//
//  ImageWallModel.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-5.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseModel.h"

@interface ImageWallModel : BaseModel
@property (nonatomic,retain) NSNumber *albumId;//相册id
@property (nonatomic,retain) NSNumber *imageId;//图片id
@property (nonatomic,retain) NSNumber *userId;//用户id
@property (nonatomic,copy) NSString *path;//大图路径
@property (nonatomic,copy) NSString *pathMin;//小图路径
@property (nonatomic,copy) NSString *author;//作者
@property (nonatomic,retain) NSNumber *good;//赞数
@property (nonatomic,retain) NSNumber *bad;//鄙视数
@property (nonatomic,copy) NSString *photoDate;//上传日期
@property (nonatomic,copy) NSString *des;//内容
@property (nonatomic,retain) NSNumber *pageView;//浏览数
@property (nonatomic,retain) NSNumber *weekChampion;//周冠军标记
@property (nonatomic,retain) NSNumber *monthChampion;//月冠军标记
@property (nonatomic,retain) NSNumber *longitude;//经度
@property (nonatomic,retain) NSNumber *latitude;//纬度
@property (nonatomic,retain) NSNumber * goodFlag;//点赞标识
@property (nonatomic,retain) NSNumber * badFlag;//点鄙视标识


@end
