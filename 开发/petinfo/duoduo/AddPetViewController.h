//
//  AddPetViewController.h
//  宠信
//
//  Created by tenyea on 14-7-16.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
@class PetModel;
@interface AddPetViewController : TenyeaBaseViewController <UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

-(id)initWithPetDic:(NSDictionary *)dic;
@property (nonatomic,strong) PetModel *model;
@end
