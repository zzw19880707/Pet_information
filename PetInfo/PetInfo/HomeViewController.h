//
//  HomeViewController.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseViewController.h"
#import "AOScrollerView.h"
@interface HomeViewController : BaseViewController <ValueClickDelegate,UITableViewDelegate,UITableViewDataSource> {
    __block NSArray *_array;
//图片最大化视图
  UIImageView *_fullImageView;
//按钮图片位置
    CGRect _frame;


}
- (IBAction)btnAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *label;
//tableview数据源

@property (retain,nonatomic) __block NSMutableArray *cellData;
@end
