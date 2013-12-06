//
//  BasePhotoViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-5.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BasePhotoViewController.h"
#import "DataAccess.h"
#import "DataService.h"
#import "ImageWallModel.h"
#import "MBProgressHUD.h"
@interface BasePhotoViewController ()

@end
@implementation BasePhotoViewController
@synthesize aoView;
//@synthesize data;
#pragma mark UI
-(void)viewDidLoad{
    [super viewDidLoad];
    _HUD=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:_HUD];
    //如果设置此属性则当前的view置于后台
    _HUD.dimBackground = YES;
    
    //设置对话框文字
    _HUD.labelText = @"请稍等...";
    
    //显示对话框
    [_HUD show:YES];
//    self.data =[[NSMutableArray alloc]init];
    self.aoView =[[AOWaterView alloc]initWithDataArray:nil];
    //滚动条代理
    self.aoView.delegate =self;
    [self.view addSubview:self.aoView];
    //刷新数据
    [self refreshView];
    //61秒后设置超时
    [self performSelector:@selector(outTime) withObject:nil afterDelay:61];
    [self createHeaderView];
    [self performSelector:@selector(testFinishedLoadData) withObject:nil afterDelay:0.0f];
    
}
//超时
-(void)outTime{
    if (![_HUD isHidden]) {
        [_HUD hide:YES];
        [_HUD removeFromSuperview];
    }
}

//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
//初始化刷新视图
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark
#pragma methods for creating and removing the header view

-(void)createHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
	_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                          CGRectMake(0.0f, 0.0f - self.view.bounds.size.height,
                                     self.view.frame.size.width, self.view.bounds.size.height)];
    _refreshHeaderView.delegate = self;
	[self.aoView addSubview:_refreshHeaderView];
    
    [_refreshHeaderView refreshLastUpdatedDate];
}
-(void)removeHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
    _refreshHeaderView = nil;
}
-(void)setFooterView{
    CGFloat height = MAX(self.aoView.contentSize.height, self.aoView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]) {
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              self.aoView.frame.size.width,
                                              self.view.bounds.size.height);
    }else {
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         self.aoView.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [self.aoView addSubview:_refreshFooterView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView refreshLastUpdatedDate];
    }
}
-(void)removeFooterView{
    if (_refreshFooterView && [_refreshFooterView superview]) {
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}
//设置屏幕方向
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}
#pragma mark 按钮事件
//点击图片按钮事件
-(void)click:(ImageWallModel *)data{
    _pn(123);
}
#pragma mark-
#pragma mark force to show the refresh headerView
-(void)showRefreshHeader:(BOOL)animated{
	if (animated)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		self.aoView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        // scroll the table view to the top region
        [self.aoView scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
        [UIView commitAnimations];
	}
	else
	{
        self.aoView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[self.aoView scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
	}
    
    [_refreshHeaderView setState:EGOOPullRefreshLoading];
}
//===============
//刷新delegate
#pragma mark -
#pragma mark data reloading methods that must be overide by the subclass
//设置代理方法位置
-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
	
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader) {
        // pull down to refresh data
//        [self performSelector:@selector(refreshView) withObject:nil afterDelay:2.0];
        [self refreshView];
    }else if(aRefreshPos == EGORefreshFooter){
        // pull up to load more data
//        [self performSelector:@selector(getNextPageView) withObject:nil afterDelay:2.0];
        [self getNextPageView];
    }
    
	// overide, the actual loading data operation is done in the subclass
}

#pragma mark -
#pragma mark method that should be called when the refreshing is finished
#pragma mark 方法加载完成，回归原位
- (void)finishReloadingData{
	
	//  model should call this when its done loading
	_reloading = NO;
    
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.aoView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.aoView];
        [self setFooterView];
    }
    
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
#pragma mark UIscrollViewDelegate代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
	
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark -
#pragma mark EGORefreshTableDelegate Methods
#pragma mark EGORefreshTableDelegate 代理方法
//监听上拉下拉事件
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
	[self beginToReloadData:aRefreshPos];
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}


// if we don't realize this method, it won't display the refresh timestamp
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

//刷新调用的方法
-(void)refreshView{
    
    [DataService requestWithURL:GetAOImg andparams:nil andhttpMethod:@"POST" completeBlock:^(id result) {
        NSArray *array =[result objectForKey:@"celldata"];
        NSMutableArray *data =[[NSMutableArray alloc]init];
        for (NSDictionary *dic in array) {
            ImageWallModel *model = [[ImageWallModel alloc]initWithDataDic:dic];
//            [self.data addObject:model];
            [data addObject:model];
            [model release];
        }
        
        [self.aoView refreshView:data];
        [self outTime];
        [self testFinishedLoadData];

        
    }andErrorBlock:^(NSError *error) {
        
    }];
    
}
//加载调用的方法
-(void)getNextPageView{
    [self removeFooterView];

    [DataService requestWithURL:GetAOImg andparams:nil andhttpMethod:@"POST" completeBlock:^(id result) {
        NSArray *array =[result objectForKey:@"celldata"];
        NSMutableArray *data =[[NSMutableArray alloc]init];
        for (NSDictionary *dic in array) {
            ImageWallModel *model = [[ImageWallModel alloc]initWithDataDic:dic];
            [data addObject:model];
            [model release];
        }
        [self.aoView getNextPage:data];
        [self testFinishedLoadData];
        
        
    } andErrorBlock:^(NSError *error) {
        
    }];
}
//
-(void)testFinishedLoadData{
    [self finishReloadingData];
    [self setFooterView];
}

#pragma mark 内存管理
-(void)dealloc{
    RELEASE_SAFELY(_HUD);
//    RELEASE_SAFELY(self.data);
    RELEASE_SAFELY(_refreshHeaderView);
    RELEASE_SAFELY(_refreshFooterView);
    MARK;
    [super dealloc];
}
@end
