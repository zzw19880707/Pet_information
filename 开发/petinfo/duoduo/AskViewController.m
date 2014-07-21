//
//  AskViewController.m
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "AskViewController.h"
#import "LatestAskCell.h"
@interface AskViewController ()
{
    NSArray *_titleArr;
    NSArray *_titleImageArr;
}
@end

@implementation AskViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    _titleArr = @[@"在线问诊",@"宠物医院"];
    _titleImageArr = @[@"ask_online.png",@"ask_hospital.png"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark -
#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [_titleArr count];
    }else{
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        static NSString *latestAskTitleIdentifier = @"latestAskTitleIdentifier" ;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:latestAskTitleIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:latestAskTitleIdentifier];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 43, ScreenWidth, 1)];
            view.backgroundColor = [UIColor colorWithRed:0.84 green:0.87 blue:0.87 alpha:1];
            [cell.contentView addSubview:view];
            
        }
//        cell.imageView.image = [UIImage imageNamed:_titleImageArr[indexPath.row]] ;
        cell.textLabel.text = _titleArr [indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithRed:0.33 green:0.63 blue:0.61 alpha:1];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *latestAskIdentifier = @"latestAskIdentifier" ;
        LatestAskCell *cell = [tableView dequeueReusableCellWithIdentifier:latestAskIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LatestAskCell"  owner:self options:nil] lastObject];
        }
        cell.imageV.backgroundColor = [UIColor redColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ( section==0) {
        return nil;
    }else{
        return @"最新提问";
    }
    
}
#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else{
        return 60;
    }
}
@end
