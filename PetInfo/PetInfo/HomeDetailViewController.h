//
//  HomeDetailViewController.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-27.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_data;
}
@property (retain, nonatomic) IBOutlet UITableView *tabelView;

@end
