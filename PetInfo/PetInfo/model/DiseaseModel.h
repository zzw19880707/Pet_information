//
//  DiseaseModel.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-10.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseModel.h"

@interface DiseaseModel : BaseModel

//常见病id	id	int
//常见病名称	name	varchar
//分类	category	varchar
//简介	des	varchar
//诊断
//症状
//治疗
//预防
@property (nonatomic,retain) NSNumber *disease_id;//常见病id
@property (nonatomic,copy) NSString *name;//常见病名称
@property (nonatomic,retain) NSNumber *category;//常见病id
@property (nonatomic,copy) NSString *des;//简介
@property (nonatomic,copy) NSString *diagnose;//诊断
@property (nonatomic,copy) NSString *symptom;//症状
@property (nonatomic,copy) NSString *cure;//治疗
@property (nonatomic,copy) NSString *prevent;//预防

@end
