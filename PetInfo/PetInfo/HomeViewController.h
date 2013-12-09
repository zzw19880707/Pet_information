//
//  HomeViewController.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "FullView.h"
#import "AOScrollerView.h"
@interface HomeViewController : BaseViewController <ValueClickDelegate,UITableViewDelegate,CLLocationManagerDelegate,UITableViewDataSource,FullImageViewDelegate> {
    __block NSArray *_array;
//图片最大化视图
  FullView *_fullImageView;
//按钮图片位置
    CGRect _frame;
    //登陆用户id 
    NSInteger _user_id;
    //经纬度
    float _longtitude;
    float _latitude;

}
- (IBAction)btnAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *label;
- (IBAction)moreAction:(id)sender;
//tableview数据源

@property (retain,nonatomic) __block NSMutableArray *cellData;
@end
