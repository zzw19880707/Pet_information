//
//  HomeButtonViewController.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-27.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeButtonViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
}
@property (assign,nonatomic) kHomeTableViewCellType homeType;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (assign,nonatomic) NSString *titleText;
@end
