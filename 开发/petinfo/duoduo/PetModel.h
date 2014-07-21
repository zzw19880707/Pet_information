//
//  PetModel.h
//  宠信
//
//  Created by tenyea on 14-7-16.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "BaseModel.h"

@interface PetModel : BaseModel
@property (nonatomic,strong ) NSString *petName;//昵称
@property (nonatomic,strong) NSString *petHeadImage;//头像
@property (nonatomic,strong) NSString *petBirthday;//生日
@property (nonatomic,strong) NSString *petSex;//性别
@property (nonatomic,strong) NSString *petKind;//种类
@property (nonatomic,strong) NSString *petVariety;//品种
@end
