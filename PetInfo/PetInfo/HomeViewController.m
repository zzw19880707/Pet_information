//
//  HomeViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-14.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "HomeViewController.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "HomeButtonViewController.h"
#import "BaseNavViewController.h"
#import "LoginViewController.h"
#import "SendViewController.h"
#import "ImageWallModel.h"
#import "BasePhotoViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"宠信";
    }
    return self;
}
#pragma -
#pragma mark UI
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-10-44-44-15-10);
    self.scrollView.backgroundColor=PetBackgroundColor;
    self.scrollView.contentSize=CGSizeMake(ScreenWidth, 120+60+60+30 );
    self.scrollView.delegate =self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //添加分享按钮
    UIButton *shareButton = [[UIButton alloc]init];
    shareButton.backgroundColor=PetBackgroundColor;
    shareButton.frame=CGRectMake(0, 0, 30, 30);
    [shareButton setImage:[UIImage imageNamed:@"navagitionbar_share.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareitem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem= [shareitem autorelease];
    
    [self _initView];
    [self _initAOView];
    [self _initTabelData];
    [self _loadAndWriteData];
}


-(void)viewWillAppear:(BOOL)animated{
    _user_id =[[NSUserDefaults standardUserDefaults]integerForKey:user_id];
    if (_fullImageView!=NULL) {
        [_fullImageView setHidden: NO];
        [self performSelector:@selector(fullhidden) withObject:nil afterDelay:0.1];
    }
    [super viewWillAppear:animated];
}
-(void)fullhidden{
    [UIApplication sharedApplication].statusBarHidden=YES;
}
#pragma -
#pragma mark init
//初始化AOScroller
-(void)_initAOView{
    //设置图片url数组
    NSMutableArray *arr =[[NSMutableArray alloc]init];
    //设置标题数组
    NSMutableArray *strArr =[[NSMutableArray alloc]init];
    UIView *ASVBGView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    ASVBGView.backgroundColor = [UIColor grayColor];
    
    UIImageView *ASVBGImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 119)];
    ASVBGImage.image=[UIImage imageNamed:@"ao_background.png"];
    [ASVBGView addSubview:ASVBGImage];
    [ASVBGImage release];
    [self.scrollView addSubview:ASVBGView];
    [ASVBGView release];
    for (int i = 0; i<self.array.count; i++) {
        NSDictionary *dic=self.array[i];
        [arr addObject:[dic objectForKey:@"imageurl"]];
        [strArr addObject:[NSString stringWithFormat:@"  【%@】\n%@\n%@",[dic objectForKey:@"category"],[dic objectForKey:@"title"],[dic objectForKey:@"content"]]];
    }
    //数据大于0才添加，否则下面ui上移
    if (self.array.count>0) {
        AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:arr titleArr:strArr height:119];
        //设置委托
        aSV.vDelegate=self;
        //添加进view
        [ASVBGView addSubview:aSV];
        [aSV release];
    }else{
        
    }
}
-(void)_initTabelData{
    self.cellData = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.cellArray) {
        ImageWallModel *model = [[ImageWallModel alloc]initWithDataDic:dic];
        [self.cellData addObject:model];
        [model release];
    }
    if (self.cellData.count ==0) {
        [self.tableView setHidden:YES];
        [self.label setHidden:NO];
    }else{
        self.tableView.height=[self.cellData count]*80+10;
        [self.tableView reloadData];
    }
}

-(void)_loadAndWriteData{
    //mainView数据加载完成
    if (self.isMainFinish) {
    }
    //未加载完成,重新刷新tableview,并将celldata和array重写入
    else{
        [self autoRefreshData];
        [self loadMoredata];
    }
}


-(void)_initView{
    
    _refreshHeaderView = [[EGORefreshTableHeaderView_old alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.scrollView.bounds.size.height, self.scrollView.frame.size.width, self.scrollView.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    _refreshHeaderView.backgroundColor=[UIColor clearColor];
    [self.scrollView addSubview:_refreshHeaderView];
    
}

#pragma mark asirequest delegate

-(void)requestFinished:(id)result
{
    NSArray *array =[result objectForKey:@"celldata"];
    NSString *path =[[NSBundle mainBundle]pathForResource:@"HomeCellData" ofType:@"plist"];
    NSMutableDictionary * dic =[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *pathName = [plistPath1 stringByAppendingPathComponent:@"HomeCellData.plist"];
    
    [dic setObject:[result objectForKey:@"data"] forKey:@"data"];
    [dic setObject:array forKey:@"celldata"];
    [dic writeToFile:pathName atomically:YES];
    
    [self.cellData removeAllObjects];
    //    self.cellData =[[NSMutableArray alloc]init];
    for (NSDictionary *dic in array) {
        ImageWallModel *model = [[ImageWallModel alloc]initWithDataDic:dic];
        [self.cellData addObject:model];
        [model release];
    }
    if (self.cellData.count ==0) {
        [self.tableView setHidden:YES];
        [self.label setHidden:NO];
    }else {
        self.tableView.height=[self.cellData count]*80+10;
        [self reloadData];
    }
    
}
-(void)requestFailed:(ASIHTTPRequest *)asirequest{
    _po([[asirequest error] localizedDescription]);
    [self doneLoadingTableViewData];

}
#pragma -
#pragma mark 按钮事件

//分享 发送按钮
-(void)shareAction{
    if(_user_id==0){
        [super alertLoginView];
    }else{
    SendViewController *send=[[SendViewController alloc]init];
    send.isCancelButton=YES;
    BaseNavViewController *nav=[[BaseNavViewController alloc]initWithRootViewController:send];
    [self.navigationController presentViewController:nav animated:YES completion:NULL];
    }
}
//更多按钮
- (IBAction)moreAction:(id)sender{
    BasePhotoViewController *basePhoto =[[[BasePhotoViewController alloc]init]autorelease];
#warning baseurl
    //    basePhoto.baseURL = ;
    //    basePhoto.params;
    [self.navigationController pushViewController:basePhoto animated:YES];
}
//图片按钮点击变大
-(void)imageButtonAction:(UIButton *)button{
    //点击的cell 位置
    int count = button.tag -1020;
    ImageWallModel *model =self.cellData[count];
    UIImage *imageFull = button.imageView.image;
    //获取按钮位置
    CGPoint point =[button convertPoint:CGPointMake(0, 0) toView:[UIApplication sharedApplication].keyWindow];
    _frame.origin=point;
    _frame.size=button.size;
    
    if (_fullImageView == NULL) {
        _fullImageView=[[FullView alloc]initWithModel:model andFrame:_frame];
    }
    
    _fullImageView.image=imageFull;
    _fullImageView.eventDelegate =self;
    
    [UIView animateWithDuration:0.2 animations:^{
        _fullImageView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _fullImageView.alpha =1;
    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].statusBarHidden=YES;
        [[_fullImageView viewWithTag:1023]setHidden:NO];
        [[_fullImageView viewWithTag:1024]setHidden:NO];
        
    }];
    [self.view.window addSubview:_fullImageView];
    
}
//中间按钮，根据不同的tag  选择不同的页面
- (IBAction)btnAction:(UIButton *)sender {
    HomeButtonViewController *homeButtonVC=[[[HomeButtonViewController alloc]init] autorelease];
    BasePhotoViewController *basePhoto =[[[BasePhotoViewController alloc]init]autorelease];
    
    //    homeButtonVC.isBackButton=YES;
    switch (sender.tag) {
        case 1001:
            homeButtonVC.homeType=kMedicineType;
            homeButtonVC.titleText=@"宠物药品";
            //宠物药品
            [self.navigationController pushViewController:homeButtonVC animated:YES];
            break;
        case 1002:
            //常见病
            homeButtonVC.homeType=kDiseaseType;
            homeButtonVC.titleText=@"常见病";
            [self.navigationController pushViewController:homeButtonVC animated:YES];
            break;
        case 1003:
            //晒靓照
#warning baseurl
            //    basePhoto.baseURL = ;
            //    basePhoto.params;
            [self.navigationController pushViewController:basePhoto animated:YES];
            break;
        case 1004:
            //附近
            homeButtonVC.titleText=@"附近";
            homeButtonVC.homeType=kNearType;
            [self.navigationController pushViewController:homeButtonVC animated:YES];
            break;
            
        default:
            break;
    }
    
}

#pragma mark AOScrollViewDelegate
-(void)buttonClick:(int)vid{
    NSLog(@"%d",vid);
}
#pragma -
#pragma mark 下拉刷新



#pragma mark 上拉获取更多数据
-(void)loadMoredata{
    [self pullUp:self.tableView];
}
-(void)pullUp:(UITableView *)tableView{
    //加载数据
    NSMutableDictionary *params;
    if (_user_id ==0) {
        params =nil;
    }else{
        params=[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInteger:_user_id]] forKeys:@[@"user_id"]];
    }
    
    DataService *dataService =[[DataService alloc]init];
    dataService.eventDelegate = self;
    [dataService requestWithURL:GetAOImg andparams:params andhttpMethod:@"GET"];
}

-(void)reloadData
{
    
    [self doneLoadingTableViewData];
    [self.tableView reloadData];
    
}
#pragma mark - 下拉相关的方法
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
}

- (void)autoRefreshData {
    [_refreshHeaderView initLoading:self.scrollView];
}
#pragma mark UIScrollViewDelegate Methods
//监听scrollview  下拉到一定状态。
//滑动是实时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
    if ([scrollView isKindOfClass:[UIScrollView class]]) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    
}
//拖拽时停止调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
    if ([scrollView isKindOfClass:[UIScrollView class]]) {
        if (scrollView.contentOffset.y==-60) {
            [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
            [self loadMoredata];
        }

        
        
    }
}
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView_old*)view{
    //设置为正在加载的状态
	[self reloadTableViewDataSource];
    
}
//当前是否加载
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView_old*)view{
	
	return _reloading;
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView_old*)view{
	
	return [NSDate date];
	
}

#pragma -
#pragma mark UITableViewDelegate
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size=self.scrollView.contentSize;
    size.height+=80;
    self.scrollView.contentSize=size;
    return 80;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.cellData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *homecellIndentifier=@"everyCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:homecellIndentifier];
    
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EveryCell" owner:self options:nil] lastObject];
    }
    UILabel *textLabel=(UILabel *)[cell.contentView viewWithTag:1011];
    ImageWallModel *model = self.cellData[indexPath.row];
    textLabel.text = model.des;
    UILabel *countLabel=(UILabel *)[cell.contentView viewWithTag:1013];
    UIButton *imageBtn=(UIButton *)[cell.contentView viewWithTag:1012];
    [imageBtn setImageWithURL:[NSURL URLWithString: model.pathMin]];
    imageBtn.tag=1020+indexPath.row;
    imageBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [imageBtn addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    countLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    return cell;

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
- (void) releaseFullView {
    RELEASE_SAFELY(_fullImageView);
}

#pragma mark 内存管理
- (void)dealloc {
    RELEASE_SAFELY(_scrollView);
    RELEASE_SAFELY(_tableView);
    RELEASE_SAFELY(_label);
    RELEASE_SAFELY(_array);
    RELEASE_SAFELY(_cellData);
    MARK;
    [super dealloc];
}
- (void)viewDidUnload {
    [self.scrollView release];
    self.scrollView=nil;
    [self setTableView:nil];
    [self setLabel:nil];
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}

@end
