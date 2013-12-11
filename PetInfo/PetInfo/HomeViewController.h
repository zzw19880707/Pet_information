//
//  HomeViewController.h
//  PetInfo
//  主页面，用于加载首页滚动栏数据。中间按钮可以查询数据，每日精选为前一日，赞数前10的数据。
//  Created by 佐筱猪 on 13-11-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "FullView.h"
#import "AOScrollerView.h"
@interface HomeViewController : BaseViewController <ValueClickDelegate,UITableViewDelegate,CLLocationManagerDelegate,UITableViewDataSource,FullImageViewDelegate> {
//图片最大化视图
  FullView *_fullImageView;
//按钮图片位置
    CGRect _frame;
    //登陆用户id 
    NSInteger _user_id;
}
- (IBAction)btnAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *label;
- (IBAction)moreAction:(id)sender;

//tableview数据源
@property (retain,nonatomic) __block NSArray *array;
@property (retain,nonatomic) __block NSMutableArray *cellData;
@end
