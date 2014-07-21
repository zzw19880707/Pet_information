//
//  StoryViewController.m
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "StoryViewController.h"
#import "MJRefresh/MJRefresh.h"
#import "StoryCell.h"
#import "MoveButton.h"
@interface StoryViewController ()
{
    NSArray *_dataArray;
    UIView *_topView;
}
@end

@implementation StoryViewController
@synthesize tableView = _tableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initView];
    
}
#pragma mark -
#pragma mark init
-(void)_initView{
    [self _initTOPView];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button addTarget:self action:@selector(EditAction) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"story_edit.png"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
//    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
}

//初始化顶部4个按钮
-(void)_initTOPView{
    
    NSArray *nameArr = @[@"宠物明星",@"晒萌宠",@"人气萌宠",@"附近宠物"];
    NSArray *imageArr = @[@"story_star.png",@"story_image.png",@"story_sentiment.png",@"story_near.png"];
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, -60, ScreenWidth, (nameArr.count/2)*60 )];
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake( 0 , 0, 320, 60);
    [_topView addSubview:view];
    _topView.backgroundColor = [UIColor colorWithRed:0.95 green:0.99 blue:1 alpha:1];
    for (int i = nameArr.count-1; i >= 0; i --) {
        MoveButton *button = [[MoveButton alloc]initWithFrame:CGRectMake(45 + i%2 *160, (i/2 )*60 +20, 70, 40) LabelText:nameArr[i] ImageView:imageArr[i]];
        button.backgroundColor = [UIColor colorWithRed:0.36 green:0.68 blue:0.89 alpha:1];
        button.tag = i +100;
        [button addTarget:self action:@selector(TouchAction:) forControlEvents:UIControlEventTouchUpInside];

        [_topView addSubview:button];
    }
}

#pragma mark -
#pragma mark method
//y=-2x +3
//下排按钮
-(float)lowMovepath:(float)x{
    float result = 0.0;
    result = -2*x + 3;
    return result;
}
//上排按钮
-(float)highMovepath:(float)x{
    float result = 0.0;
    result = -1.7*x + 2.7;
    return result;
}
//顶部按钮动画
-(void)TopButtonFrameChange :(float )contentoffset_y{
    if (contentoffset_y> - 64 &&contentoffset_y < -4) {
        float now_offset = (64 + contentoffset_y) /60;
        for (int i = 0  ; i < 4 ; i ++ ) {
            int tag = 100 + i ;
            UIButton *button = (UIButton *)VIEWWITHTAG(_topView, tag);
            CGPoint point = button.center ;
            if(i/2 == 0){//上面两个
                point.x = (80 + 160 * (i%2) - now_offset*40 * [self highMovepath:now_offset] )  ;
                point.y = 30 + now_offset * 60;
            }else {//下面俩
                point.x = 80 + 160 * (i%2) +now_offset*40 *  [self lowMovepath:now_offset];
            }
            button.center = point;
        }
        
    }else if (contentoffset_y < - 63){
        for (int i = 0  ; i < 4 ; i ++ ) {
            int tag = 100 + i ;
            MoveButton *button = (MoveButton *)VIEWWITHTAG(_topView, tag);
            button.center = CGPointMake( (i%2) * 160 +80 , (i/2) *60 +30);
//            button.frame = CGRectMake(40 + i%2 *160, (i/2 )*60, 80, 60);
            [button beginAnimation];
        }
    }else if (contentoffset_y > -5){
        for (int i = 0  ; i < 4 ; i ++ ) {
            int tag = 100 + i ;
            MoveButton *button = (MoveButton *)VIEWWITHTAG(_topView, tag);
            button.center = CGPointMake(40 + (i/2) * 80 + (i%2) * 160 , 90);
//            button.frame = CGRectMake((i/2)*80 + (i%2) *160, 60, 80, 60);
            [button endAnimation];
        }
    }

}


#pragma mark - 
#pragma mark Action
//topview下4个按钮事件
-(void)TouchAction:(UIButton *)button {
    switch (button.tag) {
        case 101:
            break;
        case 102:
            break;
        case 103:
            break;
        case 104:
            break;
        default:
            break;
    }
}
//编辑按钮事件
-(void)EditAction{
    _po(@"1231");
}
#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float contentoffset_y = scrollView.contentOffset.y;
    [self TopButtonFrameChange:contentoffset_y];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float contentoffset_y = scrollView.contentOffset.y;
    [self TopButtonFrameChange:contentoffset_y];
}
#pragma mark -
#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        return nil;
    }else{
        UIView *bgsectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
        [bgsectionView addSubview:_topView];
        return bgsectionView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        return 60;
    }
    return 89;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        return 0;
    }
    return 60;
}
#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *nullCellIdentifier = @"nullCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nullCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nullCellIdentifier];
        }
        return cell;
    }else{
        static NSString *storyCellIdentifier = @"storyCellIdentifier";
        StoryCell *cell = [tableView dequeueReusableCellWithIdentifier:storyCellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"StoryCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


@end
