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
    _cellData=@[@"1",@"555",@"1234",@"123"];
    self.scrollView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-10-44-44-15-10);
    self.scrollView.backgroundColor=PetBackgroundColor;
    self.scrollView.contentSize=CGSizeMake(ScreenWidth, 120+60+60+30);
    
    
    [self _initAOView];
    if ([_cellData count]==0) {
        [self.tableView setHidden:YES];
        [self.label setHidden:NO];
    }else{
        self.tableView.height=[_cellData count]*80+10;
    }
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
        _array=[result objectForKey:@"data"];
        for (int i = 0; i<_array.count; i++) {
            NSDictionary *dic=_array[i];
            [arr addObject:[dic objectForKey:@"imageurl"]];
            [strArr addObject:[NSString stringWithFormat:@"  【%@】\n%@\n%@",[dic objectForKey:@"category"],[dic objectForKey:@"titile"],[dic objectForKey:@"content"]]];
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

    return [_cellData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier=@"everyCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell==nil) {
        cell = [[[[NSBundle mainBundle]loadNibNamed:@"EveryCell" owner:self options:nil] lastObject]autorelease];
    }
    UILabel *textLabel=(UILabel *)[cell.contentView viewWithTag:1011];
    UILabel *countLabel=(UILabel *)[cell.contentView viewWithTag:1013];
    UIButton *imageBtn=(UIButton *)[cell.contentView viewWithTag:1012];
#warning 图片
    [imageBtn setImageWithURL:[NSURL URLWithString:@"http://ww1.sinaimg.cn/large/53e0c4edjw1dy3qf6n17xj.jpg"]];
//    imageBtn.tag=1020+indexPath.row;
    [imageBtn addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    imageBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    countLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    return cell;
}

#pragma mark AOScrollViewDelegate
-(void)buttonClick:(int)vid{
    NSLog(@"%d",vid);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark 按钮事件
- (IBAction)btnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1001:
            _pn(123);
            break;
        case 1002:
            _pn(456);

            break;
        case 1003:
            _pn(789);

            break;
        case 1004:
            _pn(123);

            break;
            
        default:
            break;
    }
    
}

//图片按钮点击变大
-(void)imageButtonAction:(UIButton *)button{
    UIImage *imageFull = button.imageView.image;
    if (_fullImageView == NULL) {
        _fullImageView = [[UIImageView alloc]init];
        _fullImageView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _fullImageView.backgroundColor=PetBackgroundColor;
        _fullImageView.userInteractionEnabled=YES;//使view获取交互响应
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;//填充模式
        //添加手势
        UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImageAction:)];
        [_fullImageView addGestureRecognizer:tapGesture];
        [tapGesture release];
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
//全屏后缩小图片
- (void)scaleImageAction:(UIGestureRecognizer *)gesture {
    [UIView animateWithDuration:0.2 animations:^{
        _fullImageView.frame = _frame;
    } completion:^(BOOL finished) {
        [_fullImageView removeFromSuperview];
    }];
    [UIApplication sharedApplication].statusBarHidden = NO;
}
@end
