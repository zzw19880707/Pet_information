//
//  HomeViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "HomeViewController.h"
#import "DataService.h"
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
        self.title=@"泡宠";
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-10-44-44-15-10);
    self.scrollView.backgroundColor=PetBackgroundColor;
    self.scrollView.contentSize=CGSizeMake(ScreenWidth, 120+60+60+30);
    //添加分享按钮
    UIButton *shareButton = [[UIButton alloc]init];
    shareButton.backgroundColor=PetBackgroundColor;
    shareButton.frame=CGRectMake(0, 0, 30, 30);
    [shareButton setImage:[UIImage imageNamed:@"navagitionbar_share.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareitem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem= [shareitem autorelease];
    
    
    [self _initAOView];

}

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
    
    NSMutableDictionary *params;
    [self Location];
    if (_user_id ==0) {
        params =nil;
    }else{
        
        params=[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInteger:_user_id]] forKeys:@[@"user_id"]];
    }
    //加载网络，获取图片地址和title
    [DataService requestWithURL:GetAOImg andparams:params andhttpMethod:@"GET" completeBlock:^(id result) {
        //获取滚动条数据
        _array=[result objectForKey:@"data"];
        for (int i = 0; i<_array.count; i++) {
            NSDictionary *dic=_array[i];
            [arr addObject:[dic objectForKey:@"imageurl"]];
            [strArr addObject:[NSString stringWithFormat:@"  【%@】\n%@\n%@",[dic objectForKey:@"category"],[dic objectForKey:@"title"],[dic objectForKey:@"content"]]];
        }
        
        NSArray *array =[result objectForKey:@"celldata"];
//        self.cellData=[NSMutableArray arrayWithArray:array];
//        if ([self.cellData count]==0) {
//            [self.tableView setHidden:YES];
//            [self.label setHidden:NO];
//        }else{
//            self.tableView.height=[self.cellData count]*80+10;
//            [self.tableView reloadData];
//        }
        self.cellData =[[NSMutableArray alloc]init];
        for (NSDictionary *dic in array) {
            ImageWallModel *model = [[ImageWallModel alloc]initWithDataDic:dic];
            [self.cellData addObject:model];
            [model release];
        }
        if (self.cellData.count ==0) {
            [self.tableView setHidden:YES];
            [self.label setHidden:NO];

        }
        self.tableView.height=[self.cellData count]*80+10;
        [self.tableView reloadData];
        // 初始化自定义ScrollView类对象
        AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:arr titleArr:strArr height:119];
        //设置委托
        aSV.vDelegate=self;
        //添加进view
        [ASVBGView addSubview:aSV];
        [aSV release];
        
    } andErrorBlock:^(NSError *error) {
#warning 错误信息
    }];
    [self.scrollView addSubview:ASVBGView];
    [ASVBGView release];
    
    
}

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
        cell = [[[[NSBundle mainBundle]loadNibNamed:@"EveryCell" owner:self options:nil] lastObject]autorelease];
    }
    UILabel *textLabel=(UILabel *)[cell.contentView viewWithTag:1011];
    ImageWallModel *model = _cellData[indexPath.row];
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

#pragma mark AOScrollViewDelegate
-(void)buttonClick:(int)vid{
    NSLog(@"%d",vid);
}


#pragma mark 按钮事件
-(void)shareAction{
    if(_user_id==0){
        [self alertLoginView];
    }else{
        SendViewController *send=[[SendViewController alloc]init];
        send.isCancelButton=YES;
        BaseNavViewController *nav=[[BaseNavViewController alloc]initWithRootViewController:send];
        [self.navigationController presentViewController:nav animated:YES completion:NULL];
    }
    
}
- (IBAction)btnAction:(UIButton *)sender {
    HomeButtonViewController *homeButtonVC=[[[HomeButtonViewController alloc]init] autorelease];
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
            
            [self.navigationController pushViewController:[[[BasePhotoViewController alloc]init]autorelease] animated:YES];

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

//图片按钮点击变大
-(void)imageButtonAction:(UIButton *)button{
    //点击的cell 位置
    int count = button.tag -1020;
    ImageWallModel *model =_cellData[count];
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
    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].statusBarHidden=YES;
        [[_fullImageView viewWithTag:1023]setHidden:NO];
        [[_fullImageView viewWithTag:1024]setHidden:NO];

    }];
    [self.view.window addSubview:_fullImageView];
    
}

#pragma mark 方法
//定位
-(void)Location {
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    //精度10米
    [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [locationManager startUpdatingLocation];
}

-(void)alertLoginView {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你尚未登录，是否登陆？" delegate:self cancelButtonTitle:@"否"  otherButtonTitles:@"是", nil];
    [alert show];
    [alert release];
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
#pragma mark - CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
    
    [manager stopUpdatingLocation];
    
    _longtitude = newLocation.coordinate.longitude;
    _latitude = newLocation.coordinate.latitude;
    NSMutableDictionary *params;
    if (_user_id >0) {
        params =[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithFloat:_longtitude],[NSNumber numberWithFloat:_latitude]] forKeys:@[@"longtitude",@"latitude"]];
    }else{
        params=nil;
    }
    [DataService requestWithURL:HomeLogin andparams:params andhttpMethod:@"GET" completeBlock:^(id result) {
        
    } andErrorBlock:^(NSError *error) {
        
    }];

}
#pragma mark 内存管理
- (void)dealloc {
    [_scrollView release];
    _scrollView=nil;
    [_tableView release];
    
    [_label release];
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
