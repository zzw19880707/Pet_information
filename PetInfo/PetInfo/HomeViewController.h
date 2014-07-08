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
#import "EGORefreshTableHeaderView_old.h"
@interface HomeViewController : BaseViewController <UIScrollViewDelegate,ValueClickDelegate,UITableViewDelegate,UITableViewDataSource,FullImageViewDelegate,EGORefreshTableHeaderDelegate,ASIRequest
> {
    //图片最大化视图
    FullView *_fullImageView;
    //按钮图片位置
    CGRect _frame;
    //登陆用户id
    NSInteger _user_id;
    
    //下拉刷新
    EGORefreshTableHeaderView_old *_refreshHeaderView;
    //
    BOOL _reloading;
    AOScrollerView *_aSV;
    
}
- (IBAction)btnAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *label;
- (IBAction)moreAction:(id)sender;

//用于访问网络停止
//@property (copy,nonatomic) ASIHTTPRequest *request;
//tableview数据源
@property (retain,nonatomic) NSArray *array;//用于加载滚动条数据
@property (retain,nonatomic) NSMutableArray *cellData;//存放model数据
//用于接收mainview 的数据
@property (retain,nonatomic) NSArray *cellArray;
//用于判断mainView是否加载完网络
@property (assign,nonatomic) BOOL isMainFinish;
@end
