//
//  BaseTableView.m
//  tabbartest
//
//  Created by 佐筱猪 on 13-10-16.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        [self _initView];
    }
    return self;
}
//从xib创建
-(void)awakeFromNib{
    [self _initView];
}
-(void)_initView{
    
    _refreshHeaderView = [[EGORefreshTableHeaderView_old alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    _refreshHeaderView.backgroundColor=[UIColor clearColor];
    self.dataSource=self;
    self.delegate=self;
    self.refreshHeader=YES;
    _moreButton=[[UIButton buttonWithType:UIButtonTypeCustom]retain];
    _moreButton.backgroundColor=[UIColor clearColor];
    _moreButton.frame=CGRectMake(0, 0, ScreenWidth, 40);
    _moreButton.titleLabel.font=[UIFont systemFontOfSize:16.0f];
    [_moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(loadMoredata) forControlEvents:UIControlEventTouchUpInside];
    
    //风火轮视图
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.tag=1000;
    activityView.frame=CGRectMake(100, 10, 20, 20);
    [activityView stopAnimating];
    [_moreButton addSubview:activityView];
    self.tableFooterView=_moreButton;
}

-(void)setRefreshHeader:(BOOL)refreshHeader{
    _refreshHeader=refreshHeader;
    if(_refreshHeader){
        [self addSubview:_refreshHeaderView];

    }else{
        if([_refreshHeaderView superclass]){
            [_refreshHeaderView removeFromSuperview];
        }
    }
}
#pragma mark ----delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.eventDelegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.eventDelegate tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.eventDelegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.eventDelegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}

#pragma mark ----datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]autorelease];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.eventDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
        [self.eventDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}
#pragma mark 上拉获取更多数据
-(void)loadMoredata{
    if([self.eventDelegate respondsToSelector:@selector(pullUp:)]){
        [self.eventDelegate pullUp:self];
        [self _startLoadMore];
    }
}

//风火轮转
-(void)_startLoadMore{
    [_moreButton setTitle:@"正在加载" forState:UIControlStateNormal];
    _moreButton.enabled = NO;
    UIActivityIndicatorView *activityView=(UIActivityIndicatorView *)[_moreButton viewWithTag:1000];
    [activityView startAnimating];
}

-(void)_stopLoadMore{
    if (self.data.count>0) {
        _moreButton.hidden = NO;
        [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
        _moreButton.enabled=YES;
        UIActivityIndicatorView *activityView=(UIActivityIndicatorView *)[_moreButton viewWithTag:1000];
        [activityView stopAnimating];
//        if(self.isMore!=NO){
//            [_moreButton setTitle:@"加载完成" forState:UIControlStateNormal];
//        }
        if (!self.isMore) {
            [_moreButton setTitle:@"到底啦..." forState:UIControlStateNormal];
            _moreButton.enabled = NO;
        }
    }else{
        _moreButton.hidden=YES;
    }
    
}

-(void)reloadData{
    [super reloadData];
    [self _stopLoadMore];       
}
#pragma mark - 下拉相关的方法
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}

- (void)autoRefreshData {
    [_refreshHeaderView initLoading:self];
}
#pragma mark UIScrollViewDelegate Methods
//监听scrollview  下拉到一定状态。
//滑动是实时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}
//拖拽时停止调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
    //偏移量
    float offset=scrollView.contentOffset.y;
    float contentHeight=scrollView.contentSize.height;
    NSLog(@"偏移量y:%f",offset);
    NSLog(@"content高度%f",contentHeight);
    //当offset偏移量滑到底部时，差值是scrollView的高度
    float sub=contentHeight-offset;
    if(scrollView.height-sub>30){
        if([self.eventDelegate respondsToSelector:@selector(pullUp:)]){
            [self.eventDelegate pullUp:self];
            [self _startLoadMore];
        }
    }
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView_old*)view{
    //设置为正在加载的状态
	[self reloadTableViewDataSource];
    
    //停止加载，弹回下拉
//	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	if ([self.eventDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.eventDelegate pullDown:self];

    }
    
}
//当前是否加载
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView_old*)view{
	
	return _reloading; 	
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView_old*)view{
	
	return [NSDate date]; 
	
}


@end
