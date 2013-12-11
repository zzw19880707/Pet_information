//
//  HomeDetailTableView.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-10.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseTableView.h"

@interface HomeDetailTableView : BaseTableView 
@property (assign,nonatomic) kHomeTableViewCellType homeType;
@property (nonatomic, assign) int index;

@end
