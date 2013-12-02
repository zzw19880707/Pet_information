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
#import "HomeButtonViewController.h"
#import "BaseNavViewController.h"
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
    [shareButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
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
    //    //加载网络，获取图片地址和title
    [DataService requestWithURL:GetAOImg andparams:nil andhttpMethod:@"GET" completeBlock:^(id result) {
        //获取滚动条数据
        _array=[result objectForKey:@"data"];
        for (int i = 0; i<_array.count; i++) {
            NSDictionary *dic=_array[i];
            [arr addObject:[dic objectForKey:@"imageurl"]];
            [strArr addObject:[NSString stringWithFormat:@"  【%@】\n%@\n%@",[dic objectForKey:@"category"],[dic objectForKey:@"titile"],[dic objectForKey:@"content"]]];
        }
        
        //获取tablevie数据
        NSDictionary *celldic = [result objectForKey:@"celldata"];
        NSMutableArray *arrya = [[NSMutableArray alloc]initWithCapacity:10];
        for (int i=0; i<celldic.count; i++) {
            NSDictionary *dic = [celldic objectForKey:[NSString stringWithFormat:@"%d",i+1]];
            [arrya  addObject:dic];
        }
        self.cellData=arrya;
        if ([self.cellData count]==0) {
            [self.tableView setHidden:YES];
            [self.label setHidden:NO];
        }else{
            self.tableView.height=[self.cellData count]*80+10;
            [self.tableView reloadData];
        }
        
        // 初始化自定义ScrollView类对象
        AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:arr titleArr:strArr height:119];
        //设置委托
        aSV.vDelegate=self;
        //添加进view
        [ASVBGView addSubview:aSV];
        [aSV release];
        
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
    textLabel.text = [_cellData[indexPath.row] objectForKey: @"desc"];
    UILabel *countLabel=(UILabel *)[cell.contentView viewWithTag:1013];
    UIButton *imageBtn=(UIButton *)[cell.contentView viewWithTag:1012];
    [imageBtn setImageWithURL:[NSURL URLWithString: [_cellData[indexPath.row] objectForKey:@"path_min"]]];
    imageBtn.tag=1020+indexPath.row;
    [imageBtn addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    imageBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    countLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    return cell;
}

#pragma mark AOScrollViewDelegate
-(void)buttonClick:(int)vid{
    NSLog(@"%d",vid);
}


#pragma mark 按钮事件
-(void)shareAction{
#warning 判断是否登陆？如果登陆可以分享，如果未登陆，则提示登陆后才能分享
    
    if(0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登陆，再发布分享！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }else{
        //        SendViewController *send=[[SendViewController alloc]init];
        //        BaseNavViewController *nav=[[BaseNavViewController alloc]initWithRootViewController:send];
        //        [self.navigationController presentViewController:nav animated:YES completion:^{
        //
        //        }];
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
    int count = button.tag -1020;
    UIImage *imageFull = button.imageView.image;
    if (_fullImageView == NULL) {
        _fullImageView = [[UIImageView alloc]init];
        _fullImageView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _fullImageView.backgroundColor=PetBackgroundColor;
        _fullImageView.userInteractionEnabled=YES;//使view获取交互响应
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;//填充模式
        //添加手势
        //向右返回
        UISwipeGestureRecognizer *swipRightGesture =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImageAction:)];
        swipRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [_fullImageView addGestureRecognizer:swipRightGesture];
        [swipRightGesture release];
        //向上显示详细
        UISwipeGestureRecognizer *swipUpGesture =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImageAction:)];
        swipUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
        [_fullImageView addGestureRecognizer:swipUpGesture];
        [swipUpGesture release];
        //向下全屏
        UISwipeGestureRecognizer *swipDownGesture =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImageAction:)];
        swipDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
        [_fullImageView addGestureRecognizer:swipDownGesture];
        [swipDownGesture release];
        
        //添加详细页面
        UIView *descView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight -130, ScreenWidth, 130)];
        descView.tag =1024;
        [descView setAlpha:0.3];
        descView.backgroundColor= [UIColor blackColor];
        
        //点赞按钮
        UIButton *goodButton =[[UIButton alloc]init];
        goodButton.frame=CGRectMake(320-40-10, 10, 40, 40);
        [goodButton setImage:[UIImage imageNamed:@"home_good.png"] forState:UIControlStateNormal];
        [goodButton setImage:[UIImage imageNamed:@"home_good_highlighted.png"] forState:UIControlStateSelected];
        [goodButton addTarget:self action:@selector(GoodBadAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //点赞label
        UILabel *goodLabel = [[UILabel alloc ]initWithFrame:CGRectMake(320-40-10,  goodButton.bottom, 40, 10)];
        goodLabel.font =[UIFont systemFontOfSize:10];
        goodLabel.text = [_cellData[count] objectForKey:@"good"];
        goodLabel.tag =1033;
        goodLabel.textAlignment =NSTextAlignmentCenter;
        goodLabel.backgroundColor= CLEARCOLOR;
        [descView addSubview:goodLabel];
        [goodLabel release];
        //鄙视按钮
        UIButton *badButton= [[UIButton alloc]init];
        badButton.frame=CGRectMake(320-40-10,goodLabel.bottom+10, 40, 40);
        [badButton setImage:[UIImage imageNamed:@"home_bad.png"] forState:UIControlStateNormal];
        [badButton setImage:[UIImage imageNamed:@"home_bad_highlighted.png"] forState:UIControlStateSelected];
        [badButton addTarget:self action:@selector(GoodBadAction:) forControlEvents:UIControlEventTouchUpInside];
        [descView addSubview:goodButton];
        [descView addSubview:badButton];
        [goodButton release];
        [badButton release];
        UILabel *badLabel = [[UILabel alloc ]initWithFrame:CGRectMake(320-40-10, badButton.bottom, 40, 10)];
        badLabel.font =[UIFont systemFontOfSize:10];
        badLabel.text = [_cellData[count] objectForKey:@"bad"];
        badLabel.tag = 1034;
        badLabel.textAlignment = NSTextAlignmentCenter;
        badLabel.backgroundColor = CLEARCOLOR;
        [descView addSubview:badLabel];
        [badLabel release];
        
        //作者
        UILabel *authorLable =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 15)];
        authorLable.font=[UIFont systemFontOfSize:15];
        authorLable.text = [_cellData[count] objectForKey:@"author"];
        authorLable.backgroundColor = CLEARCOLOR;
        authorLable.textColor = PetBackgroundColor;
        [descView addSubview:authorLable];
        [authorLable release];
        //描述
        UIScrollView *descScroll =[[UIScrollView alloc] initWithFrame:CGRectMake(10, 25, ScreenWidth-50, 130-25)];
        
        UILabel *descLabel =[[UILabel alloc]init];
        descLabel.numberOfLines =0;
        descLabel.font=[UIFont systemFontOfSize:15];
        descLabel.text = [_cellData[count] objectForKey:@"desc"];
        CGSize size=[descLabel.text sizeWithFont:descLabel.font constrainedToSize:CGSizeMake(ScreenWidth-50, 1000)];//适配高度
        descLabel.frame =CGRectMake(0, 0, ScreenWidth-50, size.height);
        descLabel.tag = 1034;
        descLabel.backgroundColor = CLEARCOLOR;
        descScroll.showsVerticalScrollIndicator = NO;//隐藏竖滚动
        descScroll.showsHorizontalScrollIndicator =NO;//隐藏横滚动
        descScroll.contentSize = CGSizeMake(ScreenWidth-50, size.height);
        descScroll.backgroundColor= CLEARCOLOR;
        [descScroll addSubview:descLabel];
        [descLabel release];
        [descView addSubview:descScroll];
        [descScroll release];

        

        [_fullImageView addSubview:descView];
        [descView release];
    }
    
    _fullImageView.image=imageFull;
    
    //获取按钮位置
    CGPoint point =[button convertPoint:CGPointMake(0, 0) toView:[UIApplication sharedApplication].keyWindow];
    _frame.origin=point;
    _frame.size=button.size;
    
    _fullImageView.frame = _frame;
    [UIView animateWithDuration:0.2 animations:^{
        _fullImageView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].statusBarHidden=YES;
    }];
    [self.view.window addSubview:_fullImageView];
    
}
//点赞按钮事件
-(void)GoodBadAction:(UIButton *)button{
    button.selected = !button.selected;
}
//全屏后缩小图片
- (void)scaleImageAction:(UISwipeGestureRecognizer *)gesture {
    if(gesture.direction==UISwipeGestureRecognizerDirectionRight){
        [UIView animateWithDuration:0.2 animations:^{
            _fullImageView.frame = _frame;
        } completion:^(BOOL finished) {
            [_fullImageView removeFromSuperview];
        }];
        [UIApplication sharedApplication].statusBarHidden = NO;
    }else if(gesture.direction==UISwipeGestureRecognizerDirectionDown){
        UIView *view =[_fullImageView viewWithTag:1024];
        if (!view.hidden) {
            [view setHidden:YES];
        }
    }else if(gesture.direction==UISwipeGestureRecognizerDirectionUp){
        UIView *view =[_fullImageView viewWithTag:1024];
        if (view.hidden) {
            [view setHidden:NO];
        }
    }

}



#pragma mark 内存管理
- (void)dealloc {
    [_scrollView release];
    _scrollView=nil;
    [_tableView release];
    
    [_label release];
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
