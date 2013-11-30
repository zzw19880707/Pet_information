//
//  MoreViewController.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseViewController.h"

@interface MoreViewController : BaseViewController < UITableViewDataSource,UITableViewDelegate>{
    NSArray *_data;
    NSArray *_section;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
