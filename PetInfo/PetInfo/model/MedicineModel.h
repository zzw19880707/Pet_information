//
//  MedicineModel.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-10.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseModel.h"

@interface MedicineModel : BaseModel
//药品id	id	int	20	主键 AUTO_INCREMENT 自动增长
//药品名称	name	varchar	20
//药品图片	pic	varchar	50
//药品图片(小)	pic_min	varchar	50
//原产国	country	varchar	20
//化学名称	chemical_name	varchar	20
//主要成分	base	varchar	100
//适用范围	scope	varchar	100
//使用说明	des	varchar	500
//价格	price	varchar	10
//规格	standard	varchar	100
//药品类别	category	int	20
//剂型	type	varchar	100
//批号	marker	varchar	20
//注意事项	notice	varchar	500
//厂商	address	varchar	20
//商家id	shop_id	int	20	与商家表(shop)id建立外键

@property (nonatomic,retain) NSNumber *medicine_id;//药品id
@property (nonatomic,copy) NSString *name;//药品名称
@property (nonatomic,copy) NSString *pic;//药品图片
@property (nonatomic,copy) NSString *pic_min;//药品图片(小)
@property (nonatomic,copy) NSString *country;//原产国
@property (nonatomic,copy) NSString *chemical_name;//化学名称
@property (nonatomic,copy) NSString *base;//主要成分
@property (nonatomic,copy) NSString *scope;//适用范围
@property (nonatomic,copy) NSString *des;//使用说明
@property (nonatomic,copy) NSString *price;//价格
@property (nonatomic,copy) NSString *standard;//规格
@property (nonatomic,retain) NSNumber *category;//药品类别
@property (nonatomic,copy) NSString *type;//剂型
@property (nonatomic,copy) NSString *marker;//批号
@property (nonatomic,copy) NSString *notice;//注意事项
@property (nonatomic,copy) NSString *address;//厂商	
@property (nonatomic,retain) NSNumber *shop_id;//商家id


@end
