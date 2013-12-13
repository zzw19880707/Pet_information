//
//  MainViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "HospitalViewController.h"
#import "CommunityViewController.h"
#import "ShopViewController.h"
#import "MoreViewController.h"
#import "BaseNavViewController.h"
#import "Reachability.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:YES];
        //注册通知,用于移除视图
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RemoveandInit) name:isLoadHomeData object:nil];
    }
    return self;
}
//初始化定位数据
-(void)_initLocation{
    _longitude = 0;
    _latitude = 0;
    _isRemove = NO;
    _isFinish = NO;
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isLocation];

}

//初始化子控制器
-(void)_initController{
    HomeViewController *home=[[HomeViewController alloc]init];
    HospitalViewController *hospital=[[HospitalViewController alloc]init];
    CommunityViewController *commu=[[CommunityViewController alloc]init];
    ShopViewController *shop=[[ShopViewController alloc]init];
    MoreViewController *more=[[MoreViewController alloc]init];
    if (_celldata.count>0&&_data.count>0) {
        //为homeview 添加数据源
        home.cellArray = _celldata;
        home.array = _data;
    }
    home.isMainFinish = _isFinish;
    
    NSArray *views=@[hospital,shop,home,commu,more];
    NSMutableArray *viewControllers=[NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in views) {
        BaseNavViewController *navViewController =[[BaseNavViewController alloc]initWithRootViewController:viewController];
        [viewControllers addObject:navViewController];
        [navViewController release];
        
    }
    self.viewControllers=viewControllers;    
}

//初始化tabbar
-(void)_initTabbarView{
    _tabbarView=[[UIView alloc]init];
    _tabbarView.frame=CGRectMake(0, ScreenHeight-49-10, ScreenWidth, 49);
    _tabbarView.backgroundColor=PetBackgroundColor;
    [self.view addSubview:_tabbarView];
    _sliderView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_slider.png"]];
    _sliderView.backgroundColor = PetBackgroundColor;
    _sliderView.frame = CGRectMake(152.5, 29, 15, 44);
    [_tabbarView addSubview:_sliderView];
    NSArray *backgroud = @[@"tabbar_hosp.png",@"tabbar_shop.png",@"tabbar_home.png",@"tabbar_commun.png",@"tabbar_more.png"];
    
    NSArray *heightBackground = @[@"tabbar_hosp_highlighted.png",@"tabbar_shop_highlighted.png",@"tabbar_home_highlighted.png",@"tabbar_commun_highlighted.png",@"tabbar_more_highlighted.png"];
    NSArray *labels = @[@"医院",@"商店",@"首页",@"社区",@"我的"];
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage =backgroud[i];
        NSString *highImage =heightBackground[i];
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame=CGRectMake((64-30)/2+(i*64), (49-30)/2, 30, 30);
        button.frame=CGRectMake(64*i, 0, 64, 49);
        button.tag=100+i;
        //添加label  描述
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((64-20)/2, (49-30)/2+30, 20, (49-30)/2)];
        label.text=labels[i];
        label.tag=110+i;
        [button addSubview:label];
        //设置默认选中
        if (i==2) {
            button.selected=YES;
            self.selectedIndex=2;
            label.textColor=PetTextColor;
        }
        label.font=[UIFont systemFontOfSize:9];
        [label release];

        [button setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        //设置高亮
//        [button setShowsTouchWhenHighlighted:YES];
        
        [_tabbarView addSubview:button];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [UIApplication sharedApplication].statusBarHidden = YES;
    //判断是有有网络
    NSString *net =[self GetCurrntNet];
    _data = [[NSArray alloc]init];
    _celldata =[[NSArray alloc]init];
    //无网络
    if ([net isEqualToString:@"no"]) {
//        读plist文件
        NSString *path = [[NSBundle mainBundle]pathForResource:@"HomeCellData" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
        _data=[dic objectForKey:@"data"];
        _celldata = [dic objectForKey:@"celldata"];
    }
    //有网络
    else{
        DataService *dataService = [[DataService alloc]init];
        dataService.eventDelegate = self;
        NSMutableDictionary *params;
        [self Location];

        NSInteger self_user_id =[userDefaults integerForKey:user_id];
        if (self_user_id ==0) {
            params =nil;
        }else{
            params=[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInteger:self_user_id]] forKeys:@[@"user_id"]];
        }
        request =[dataService requestWithURL:GetAOImg andparams:params andhttpMethod:@"GET"];
    }
    
    UIImage *backImage= [[UIImage imageNamed:@"Main_Background.JPG"] autorelease];
    _backgroundView =[[UIImageView alloc]initWithImage:backImage];
    
    [self.view  addSubview: _backgroundView];
    //第一次登陆
    if (![userDefaults boolForKey:isNotFirstLogin]) {
#warning 推送绑定
        [BPush bindChannel];
        [userDefaults setBool:YES forKey:isNotFirstLogin];
    }else{
        //图片最多加载5秒
        [self performSelector:@selector(viewDidEnd) withObject:nil afterDelay:5];
    }
    self.view.backgroundColor=PetBackgroundColor;
    //定位
    [self Location];
}
//图片最多加载5秒 否则强行关闭
-(void)viewDidEnd{
//        读plist文件
    NSString *path = [[NSBundle mainBundle]pathForResource:@"HomeCellData" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    _data=[dic objectForKey:@"data"];
    _celldata = [dic objectForKey:@"celldata"];
    _isFinish = NO;
    [self RemoveandInit];

}
//移除背景大图，并初始化视图
-(void)RemoveandInit {
    if (_isRemove) {
        
    }else{
        [UIApplication sharedApplication].statusBarHidden = NO;
        //初始化子控制器
        [self _initController];
        [self _initTabbarView];
        [_backgroundView removeFromSuperview];
        _isRemove = YES;
        //    移除消息 call
        [[NSNotificationCenter defaultCenter ]removeObserver:self name:isLoadHomeData object:nil];

    }
}
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
            result=@"no";
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
//定位
-(void)Location
{
    //开启定位服务
    if([CLLocationManager locationServicesEnabled]){
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        //设置不筛选，(距离筛选器distanceFilter,下面表示设备至少移动1000米,才通知委托更新）
        locationManager.distanceFilter = kCLDistanceFilterNone;
        //精度10米
        [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        [locationManager startUpdatingLocation];
    }else{//未开启定位服务
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setFloat:_longitude forKey:user_longitude];
        [userDefaults setFloat:_latitude forKey:user_latitude];
        [userDefaults setBool:NO forKey:isLocation];
    }
}

#pragma mark - CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{


    [manager stopUpdatingLocation];
    _longitude = newLocation.coordinate.longitude;
    _latitude = newLocation.coordinate.latitude;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:_longitude forKey:user_longitude];
    [userDefaults setFloat:_latitude forKey:user_latitude];
    [userDefaults setBool:YES forKey:isLocation];
    
    NSMutableDictionary *params;
    int self_user_id =[userDefaults integerForKey:user_id];
    if ( self_user_id) {
        params =[NSMutableDictionary dictionaryWithObjects:
                 @[[NSNumber numberWithFloat:_longitude],
                   [NSNumber numberWithFloat:_latitude],
                   [NSNumber numberWithInt:self_user_id]]
                        forKeys:@[@"longtitude",@"latitude",@"user_id"]];
    }else{
        params=nil;
    }
    [DataService requestWithURL:HomeLogin andparams:params andhttpMethod:@"GET" completeBlock:^(id result) {
        
    } andErrorBlock:^(NSError *error) {
        
    }];

}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    _po([error localizedDescription]);
    [manager stopUpdatingLocation];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:isLocation];
}

#pragma mark asirequest delegate
-(void)requestFinished:(id)result
{
    _data = [result objectForKey:@"data"];
    _celldata = [result objectForKey:@"celldata"];
    //重复写入文件中
    NSString *path =[[NSBundle mainBundle]pathForResource:@"HomeCellData" ofType:@"plist"];
//    [result writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:nil];
    NSMutableDictionary * dic =[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *pathName = [plistPath1 stringByAppendingPathComponent:@"HomeCellData.plist"];
    
    [dic setObject:_data forKey:@"data"];
    [dic setObject:_celldata forKey:@"celldata"];
    [dic writeToFile:pathName atomically:YES];
    //访问网络完成
    _isFinish = YES;
    //定位结束，发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:isLoadHomeData object:nil];
}
-(void)requestFailed:(ASIHTTPRequest *)asirequest
{
    _po([[asirequest error] localizedDescription]);
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:isNotFirstLogin]) {
        alertContent([[asirequest error] localizedDescription]);
        [self RemoveandInit];
    }
}

#pragma mark 按钮事件
-(void)selectedTab:(UIButton *)button
{
    button.selected=YES;
    if (self.selectedIndex !=(button.tag-100)) {
        //设置选中的按钮----->未选中状态
        UIButton *bu = (UIButton *)VIEWWITHTAG(_tabbarView, (self.selectedIndex+100));
        [bu setSelected:NO];
        //设置当前字体颜色
        UILabel *label = (UILabel *)VIEWWITHTAG(_tabbarView, (self.selectedIndex+110));
        label.textColor = [UIColor blackColor];
//添加_sliderView滚动动画
        float x = button.left + (button.width-_sliderView.width)/2;
        [UIView animateWithDuration:0.2 animations:^{
            _sliderView.left = x;
        }];

    }
    UILabel *labelSelect = (UILabel *)VIEWWITHTAG(_tabbarView, button.tag+10);
    labelSelect.textColor = PetTextColor;
    self.selectedIndex = button.tag-100;
}


#pragma mark 内存管理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)dealloc{
    [super dealloc];
}
@end
