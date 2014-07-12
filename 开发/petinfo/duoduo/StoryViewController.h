//
//  StoryViewController.h
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"

@interface StoryViewController : TenyeaBaseViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView *_tableView;
}
@property (strong,nonatomic) UITableView *tableView;
@end
