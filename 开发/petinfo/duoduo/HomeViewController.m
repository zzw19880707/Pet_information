//
//  HomeViewController.m
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "HomeViewController.h"
#import "StoryCell.h"
#define XLCycleHeight 130
@interface HomeViewController ()
{
    float _heigh;
    NSArray *array;
}
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    array=[[NSArray alloc]init];
    array=@[@"推荐医院",@"寻宠招领",@"狗狗训练",@"求医问药",@"公益领养",@"宠物美容"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    self.view.backgroundColor=  [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    // tableView.scrollEnabled=NO;
    // 取消tableview的row的横线
    // tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    [self _loadDate];
}

#pragma mark -
#pragma mark UITableViewDataSource
// 设置一个表单中有多少分组(非正式协议如果不实现该方法则默认只有一个分组)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

// 设置一个分组中有多少行(必须实现的正式协议)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else if(section==1)
    {
        return 1;
    }else if(section==2)
    {
        return 1;
    }else
    {
        return 4;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0)
    {
        static NSString *cellName = @"cell";
        // 声明cell并去复用池中找是否有对应标签的闲置cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        // 如果没找到可复用的cell
        if(cell == nil)
        {
            // 实例化新的cell并且加上标签
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName] ;
        }
        [self _initUI];
        [cell addSubview:view];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(indexPath.section==1)
    {
        static NSString *cellName = @"cell1";
        // 声明cell并去复用池中找是否有对应标签的闲置cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        // 如果没找到可复用的cell
        if(cell == nil)
        {
            // 实例化新的cell并且加上标签
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName] ;
        }
        UIImageView *igv=[[UIImageView alloc]init];
        igv.frame=CGRectMake(10, 10, 100, 60);
        igv.image=[UIImage imageNamed:@"main_pedia.png"];
        [cell addSubview:igv];
        int m=0;
        for (int i=0; i<2; i++) {
            for (int j=0; j<3; j++) {
                
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=CGRectMake(110+j*70, 15+30*i, 60, 20);
                [btn setTitle:[array objectAtIndex:m] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
                btn.titleLabel.textAlignment=NSTextAlignmentCenter;
                //  btn.titleLabel.textColor=[UIColor colorWithRed:0.67f green:0.67f blue:0.67f alpha:1.00f];
                btn.tag=i*10+j;
                btn.layer.cornerRadius=4;
                btn.backgroundColor=COLOR(59, 193, 151);
                [cell addSubview:btn];
                m++;
            }
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(indexPath.section==2)
    {
        static NSString *cellName = @"cell2";
        // 声明cell并去复用池中找是否有对应标签的闲置cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        // 如果没找到可复用的cell
        if(cell == nil)
        {
            // 实例化新的cell并且加上标签
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName] ;
        }
        UILabel *label = [[UILabel alloc]init];
        label.frame=CGRectMake(80, 5, 200, 30);
        label.font=[UIFont boldSystemFontOfSize:15];
        label.textColor=COLOR(59, 193, 151);
        label.text=@"小于宝宝和露露";
        [cell addSubview:label];
        // 设置附标题(默认风格不能显示)
        cell.detailTextLabel.text = @"宠物对我们而言或许只是孤单一时的陪伴，可在宠物眼里我们却是他的整个世界";
        cell.detailTextLabel.numberOfLines=2;
        // 设置图片
        cell.imageView.image = [UIImage imageNamed:@"1.png"];
        UIImageView *igv=[[UIImageView alloc]init];
        igv.frame=CGRectMake(280, 0, 30, 30);
        igv.image=[UIImage imageNamed:@"main_top.png"];
        [cell addSubview:igv];
        UIImageView *igv1=[[UIImageView alloc]init];
        igv1.frame=CGRectMake(260, 70, 15, 15);
        igv1.image=[UIImage imageNamed:@"main_praise.png"];
        [cell addSubview:igv1];
        UILabel *label1 = [[UILabel alloc]init];
        label1.frame=CGRectMake(280, 70,40, 15);
        label1.font=[UIFont boldSystemFontOfSize:12];
        label1.textColor=[UIColor grayColor];
        label1.text=@"7788";
        [cell addSubview:label1];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        static NSString *cellName = @"cell3";
        // 声明cell并去复用池中找是否有对应标签的闲置cell
        StoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
    
    
}
#pragma mark -
#pragma mark UITableViewDelegate
// 设置行高(默认为44px)
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return XLCycleHeight;
    }else if(indexPath.section==1)
    {
        return 80;
    }else if(indexPath.section==2)
    {
        return 100;
    }else
        return 90;
    
}
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0||section==1)
        return 0;
    else
        return 30.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor=[UIColor whiteColor];
    
    
    if (section==2) {
        UIImageView *igv=[[UIImageView alloc]init];
        igv.frame=CGRectMake(10, 2, 25, 25);
        igv.image=[UIImage imageNamed:@"home_horn.png"];
        [view1 addSubview:igv];
        UILabel *label = [[UILabel alloc]init];
        label.frame=CGRectMake(40, 0, 300, 30);
        label.font=[UIFont boldSystemFontOfSize:13];
        label.textColor=COLOR(59, 193, 151);
        label.text=@"本周萌宠";
        [view1 addSubview:label];
        
        
    }else if(section==3)
    {
        UILabel *label = [[UILabel alloc]init];
        label.frame=CGRectMake(20, 5, 300, 30);
        label.font=[UIFont boldSystemFontOfSize:13];
        [view1 addSubview:label];
        label.text=@"每日一宠";
        label.textColor=COLOR(59, 193, 151);
    }
    return view1;
}



#pragma mark -
#pragma mark UI
- (NSInteger)numberOfPages
{
    return 4;
}
- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *imgaeView =[[UIImageView alloc]init];

    imgaeView.image = [UIImage imageNamed:@"1.png"];
    imgaeView.frame = CGRectMake(1,1, ScreenWidth - 15*2, XLCycleHeight- 20 *2);
    imgaeView.backgroundColor = [UIColor yellowColor];
//    图片弧度
    imgaeView.layer.masksToBounds = YES;
    imgaeView.layer.cornerRadius = 1;
    return imgaeView;

    
}

-(void)PageExchange:(NSInteger)index{
    pageControl.currentPage = index;
    
}
-(void)_initUI{
    //    轮播图
    view = [[UIView alloc]initWithFrame:CGRectMake(0,0,ScreenWidth, XLCycleHeight)];
    view.backgroundColor=[UIColor redColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(14, 19, ScreenWidth - 14 * 2 , XLCycleHeight - 19 * 2)];
    bgView.backgroundColor = [UIColor colorWithRed:0.48 green:0.89 blue:0.87 alpha:1];
    [view addSubview:bgView];
    
    
    XLCycleScrollView *xlCycleScrollView = [[XLCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 24*2, 84)];
    xlCycleScrollView.delegate = self;
    xlCycleScrollView.datasource = self;
    [xlCycleScrollView.pageControl setHidden:YES];
    [bgView addSubview:xlCycleScrollView];
    //pagecontrol
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(260 - 12*4-5, 85, 12*4, 15)];
    pageControl.backgroundColor = [UIColor clearColor];
    if (WXHLOSVersion()>=6.0) {
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = COLOR(245, 0, 152);
    }
    pageControl.userInteractionEnabled = NO;
    pageControl.numberOfPages = 4;
    pageControl.currentPage= 0;
    [xlCycleScrollView addSubview:pageControl];
    
    
}
#pragma mark -
#pragma mark LoadDate
-(void)_loadDate{
    
}
@end
