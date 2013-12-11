//
//  BasePhotoViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-5.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BasePhotoViewController.h"
#import "DataService.h"
#import "ImageWallModel.h"
#import "MBProgressHUD.h"
#import "TMQuiltView.h"
#import "UIImageView+WebCache.h"
#import "TMPhotoQuiltViewCell.h"
#import "UIImageView+WebCache.h"
#import "BaseNavViewController.h"
#import "LoginViewController.h"
#import "Reachability.h"
@interface BasePhotoViewController ()<TMQuiltViewDataSource,TMQuiltViewDelegate>
{
	__block TMQuiltView *qtmquitView;
}
@property (nonatomic, retain) NSMutableArray *images;

@end
@implementation BasePhotoViewController

@synthesize images = _images;
//判断当前的网络是3g还是wifi
-(NSString*)GetCurrntNet
{
    NSString* result = nil;
    Reachability *r = [Reachability reachabilityWithHostName:
                       BASE_URL ];
//                       class="s3" style="word-wrap:break-word;margin:0px;padding:0px;">];
    _pn([r currentReachabilityStatus]);
    switch ([r currentReachabilityStatus]) {
        case NotReachable:// 没有网络连接
            result=nil;
            break;
        case ReachableViaWWAN:// 使用3G网络
            result=@"3g";
            break;
        case ReachableViaWiFi:// 使用WiFi网络
            result=@"wifi";
            break;
    }
    return result;
}
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

    self.data =[[NSMutableArray alloc]init];
    qtmquitView = [[TMQuiltView alloc] initWithFrame:CGRectMake(0, 0, 320, ScreenHeight-10-44-44-25)];
	qtmquitView.delegate = self;
	qtmquitView.dataSource = self;
    _dataService =[[DataService alloc]init];
	_dataService.eventDelegate = self;
	[self.view addSubview:qtmquitView];
    [qtmquitView reloadData];
    NSString *net =[self GetCurrntNet];
    if(net==nil){
        
    }else{
        //刷新数据
        [self refreshView];
    }

    //61秒后设置超时
    [self performSelector:@selector(outTime) withObject:nil afterDelay:61];
    [self createHeaderView];
    [self performSelector:@selector(testFinishedLoadData) withObject:nil afterDelay:0.0f];
}


-(void)viewWillAppear:(BOOL)animated{
    _user_id =[[NSUserDefaults standardUserDefaults]integerForKey:@"user_id"];
    if (_fullImageView!=NULL) {
        [_fullImageView setHidden: NO];
        [self performSelector:@selector(fullhidden) withObject:nil afterDelay:0.1];
    }
}
-(void)fullhidden{
    [UIApplication sharedApplication].statusBarHidden=YES;
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
    
	[qtmquitView addSubview:_refreshHeaderView];
    
    [_refreshHeaderView refreshLastUpdatedDate];
}
-(void)setFooterView{
    CGFloat height = MAX(qtmquitView.contentSize.height, qtmquitView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]) {
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              qtmquitView.frame.size.width,
                                              self.view.bounds.size.height);
    }else {
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         qtmquitView.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [qtmquitView addSubview:_refreshFooterView];
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
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:qtmquitView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:qtmquitView];
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
    [self.data  removeAllObjects];
    self.request = [_dataService requestWithURL:GetAOImg andparams:nil andhttpMethod:@"POST"];
}

#pragma mark DataService Delegate
-(void)requestFinished:(id )result{
    NSArray *array =[result objectForKey:@"celldata"];

    if (self.data.count==0) {
        [self.images removeAllObjects];
    }
    for (NSDictionary *dic in array) {
        ImageWallModel *model = [[ImageWallModel alloc]initWithDataDic:dic];
        [self.data addObject:model];
        [model release];
    }
    for(int i = 0; i < array.count; i++) {
        ImageWallModel *model = self.data[i];
        [_images addObject:model.pathMin];
    }
    [qtmquitView reloadData];

    [self outTime];
    [self testFinishedLoadData];
    

}
-(void)requestFailed:(ASIHTTPRequest *)request{
    alertContent([[request error] localizedDescription]);
}
//加载调用的方法
-(void)getNextPageView{
    [self removeFooterView];
    self.request =[_dataService requestWithURL:GetAOImg andparams:nil andhttpMethod:@"POST"];
    
}
//
-(void)testFinishedLoadData{
    [self finishReloadingData];
    [self setFooterView];
}



- (NSMutableArray *)images
{
    if (!_images)
	{
        NSMutableArray *imageNames = [NSMutableArray array];
//        for(int i = 0; i < 10; i++) {
//            [imageNames addObject:[NSString stringWithFormat:@"%d.jpeg", i % 10 + 1]];
//            ImageWallModel *model = self.data[i];
//            [imageNames addObject:model.pathMin];
//        }
        _images = [imageNames retain];

    }
    return _images;
}


- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {
//    return [UIImage imageNamed:[self.images objectAtIndex:indexPath.row]];
    NSString *url =[self.images objectAtIndex:indexPath.row];
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setImageWithURL:[NSURL URLWithString:url]];
    UIImage *image = imageView.image;
    [imageView release];
    return image;
}

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView {
    return [self.images count];
}

- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
    TMPhotoQuiltViewCell *cell = (TMPhotoQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"];
    if (!cell) {
        cell = [[[TMPhotoQuiltViewCell alloc] initWithReuseIdentifier:@"PhotoCell"] autorelease];
    }
    
    cell.photoView.image = [self imageAtIndexPath:indexPath];
    ImageWallModel *model =self.data[indexPath.row];
    cell.titleLabel.text = model.des;
    cell.goodLabel.text = [NSString stringWithFormat:@"%@",model.good];
    return cell;
}

#pragma mark - TMQuiltViewDelegate

- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {
	
    
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft
        || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
	{
        return 3;
    } else {
        return 2;
    }
}

- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return [self imageAtIndexPath:indexPath].size.height / [self quiltViewNumberOfColumns:quiltView];
}

- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
//	NSLog(@"index:%d",indexPath.row);
    ImageWallModel *model =self.data[indexPath.row];
    //获取按钮位置
    CGPoint point =[quiltView convertPoint:CGPointMake(0, 0) toView:[UIApplication sharedApplication].keyWindow];
    CGRect frame ;
    frame.origin=point;
    frame.size=quiltView.size;
    
    if (_fullImageView == NULL) {
        _fullImageView=[[FullView alloc]initWithModel:model andFrame:frame];
    }
    
    [_fullImageView setImageWithURL:[NSURL URLWithString:model.path]];
    _fullImageView.eventDelegate =self;
    
    [UIView animateWithDuration:0.2 animations:^{
        _fullImageView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].statusBarHidden=YES;
        [[_fullImageView viewWithTag:1023]setHidden:NO];
        [[_fullImageView viewWithTag:1024]setHidden:NO];
        
    }];
    [self.view.window addSubview:_fullImageView];
    
}
#pragma mark -FullImageViewDelegate
- (void) presentModalViewController {
    LoginViewController *view =[[LoginViewController alloc]init] ;
    view.isCancelButton =YES;
    if (_fullImageView!=NULL) {
        [_fullImageView setHidden:YES];
        [UIApplication sharedApplication].statusBarHidden=NO;
    }
    [self presentModalViewController:[[BaseNavViewController alloc]initWithRootViewController:view] animated:YES];
}
- (void) releaseFullView{
    RELEASE_SAFELY(_fullImageView);
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
