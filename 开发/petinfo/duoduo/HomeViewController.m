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
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        return 2;
    }else
    {
        return 4;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0)
    {
        static NSString *cellName_top = @"cell_top";
        // 声明cell并去复用池中找是否有对应标签的闲置cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName_top];
        // 如果没找到可复用的cell
        if(cell == nil)
        {
            // 实例化新的cell并且加上标签
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName_top] ;
            [self _initUI];
            [cell addSubview:view];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(indexPath.section==1)
    {
        static NSString *cellName_button = @"cellName_button";
        // 声明cell并去复用池中找是否有对应标签的闲置cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName_button];
        // 如果没找到可复用的cell
        if(cell == nil)
        {
            // 实例化新的cell并且加上标签
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName_button] ;
            UIImageView *igv=[[UIImageView alloc]init];
            igv.frame=CGRectMake(10, 10, 100, 60);
            igv.image=[UIImage imageNamed:@"main_pedia.png"];
//            [cell addSubview:igv];
            
            UILabel *imageLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 10, 30, 40)];
            imageLabel.text = @"宠信百科";
            imageLabel.numberOfLines = 2;
            imageLabel.textColor = [UIColor colorWithRed:0.84 green:0.99 blue:0.18 alpha:1];
            imageLabel.font = [UIFont boldSystemFontOfSize:14];
//            [igv addSubview:imageLabel];
            
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
                    btn.backgroundColor=[UIColor colorWithRed:0.4 green:0.75 blue:0.62 alpha:1];
                    [cell addSubview:btn];
                    m++;
                }
            }
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(indexPath.section==2)
    {
        if (indexPath.row == 0) {
            static NSString *cellName1_title = @"cellName1_title";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName1_title];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName1_title];
                UIImageView *igv=[[UIImageView alloc]init];
                igv.frame=CGRectMake(10, 2, 25, 25);
                igv.image=[UIImage imageNamed:@"home_horn.png"];
                [cell addSubview:igv];
                UILabel *label = [[UILabel alloc]init];
                label.frame=CGRectMake(40, 0, 300, 30);
                label.font=[UIFont boldSystemFontOfSize:13];
                label.textColor=COLOR(59, 193, 151);
                label.text=@"本周萌宠";
                [cell addSubview:label];
                
                UIView *bview = [[UIView alloc]initWithFrame:CGRectMake(10, 29, 300, 1)];
                bview.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
                [cell addSubview:bview];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
            
        }else{
            static NSString *cellName1_content = @"cellName1_content";
            // 声明cell并去复用池中找是否有对应标签的闲置cell
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName1_content];
            // 如果没找到可复用的cell
            if(cell == nil)
            {
                // 实例化新的cell并且加上标签
                //            标题
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName1_content] ;
                UILabel *label = [[UILabel alloc]init];
                label.frame=CGRectMake(100, 5, 200, 30);
                label.font=[UIFont boldSystemFontOfSize:15];
                label.textColor=[UIColor colorWithRed:0.36 green:0.62 blue:0.11 alpha:1];
                label.tag = 100;
                [cell addSubview:label];
                //            内容
                UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 210, 80)];
                desc.numberOfLines = 2;
                desc.tag = 101;
                desc.textColor = [UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1];
                [cell addSubview:desc];
                //            赞数
                UILabel *label1 = [[UILabel alloc]init];
                label1.tag = 104;
                label1.frame=CGRectMake(280, 70,40, 15);
                label1.font=[UIFont boldSystemFontOfSize:12];
                label1.textColor=[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1];
                [cell addSubview:label1];
                
                //            左侧图
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
                imageView.layer.masksToBounds = YES;
                imageView.layer.cornerRadius = 13;
                imageView.backgroundColor = [UIColor redColor];
                imageView.tag = 103;
                [cell addSubview:imageView];
                
                //            图片
                UIImageView *igv=[[UIImageView alloc]init];
                igv.frame=CGRectMake(283, -7, 30, 30);
                igv.image=[UIImage imageNamed:@"main_top.png"];
                [cell addSubview:igv];
                UIImageView *igv1=[[UIImageView alloc]init];
                igv1.frame=CGRectMake(260, 70, 15, 15);
                igv1.image=[UIImage imageNamed:@"main_praise.png"];
                [cell addSubview:igv1];
                
            }
            
            
            UILabel *label = (UILabel *)VIEWWITHTAG(cell, 100);
            label.text= @"小于宝宝和露露";
            
            UILabel *desc = (UILabel *)VIEWWITHTAG(cell, 101);
            desc.text = @"宠物对我们而言或许只是孤单一时的陪伴，可在宠物眼里我们却是他的整个世界";
            
            UILabel *label1 = (UILabel *)VIEWWITHTAG(cell, 104);
            label1.text=@"7788";
            
            UIImageView *image = (UIImageView *)VIEWWITHTAG(cell, 103);
            image.image = [UIImage imageNamed:@"main_praise.png"];
            
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
    
        
    }
    else
    {
        if (indexPath.row == 0) {
            static NSString *cellName2_title = @"cellName2_title";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName2_title];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName2_title];
                UILabel *label = [[UILabel alloc]init];
                label.frame=CGRectMake(20, 5, 300, 30);
                label.font=[UIFont boldSystemFontOfSize:13];
                [cell addSubview:label];
                label.text=@"每日一宠";
                label.textColor=COLOR(59, 193, 151);
                UIView *bview = [[UIView alloc]initWithFrame:CGRectMake(10, 29, 300, 1)];
                bview.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
                [cell addSubview:bview];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            static NSString *cellName2_content = @"cellName2_content";
            // 声明cell并去复用池中找是否有对应标签的闲置cell
            StoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName2_content];
            if(cell == nil)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:self options:nil] lastObject];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
        
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
        if (indexPath.row == 0 ) {
            return 30;
        }
        return 100;
    }else{
        if (indexPath.row == 0 ) {
            return 30;
        }
        return 90;
    }
    
    
}



#pragma mark XLCycleScrollViewDelegate

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *imgaeView =[[UIImageView alloc]init];
    imgaeView.image = [UIImage imageNamed:@"1.png"];
    imgaeView.frame = CGRectMake(0,0, ScreenWidth - 16*2, XLCycleHeight - 11 * 2);
    imgaeView.backgroundColor = [UIColor yellowColor];
    return imgaeView;
}
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index{
    
}
#pragma mark XLCycleScrollViewDatasource
-(void)PageExchange:(NSInteger)index{
    pageControl.currentPage = index;
    
}
- (NSInteger)numberOfPages
{
    return 4;
}
#pragma mark -
#pragma mark UI



-(void)_initUI{
    //    轮播图
    view = [[UIView alloc]initWithFrame:CGRectMake(0,0,ScreenWidth, XLCycleHeight)];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(14, 9, ScreenWidth - 14 * 2 , XLCycleHeight - 9 * 2)];
    bgView.backgroundColor = [UIColor colorWithRed:0.48 green:0.89 blue:0.87 alpha:1];
//    图片弧度
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 13;
    [view addSubview:bgView];
    
    
    XLCycleScrollView *xlCycleScrollView = [[XLCycleScrollView alloc]initWithFrame:CGRectMake(2 , 2, ScreenWidth - 16*2, XLCycleHeight - 11 * 2)];
    xlCycleScrollView.layer.masksToBounds = YES;
    xlCycleScrollView.layer.cornerRadius = 13;
    xlCycleScrollView.delegate = self;
    xlCycleScrollView.datasource = self;
    [xlCycleScrollView.pageControl setHidden:YES];
    [bgView addSubview:xlCycleScrollView];
    
    UIView *pageControlBg = [[UIView alloc]initWithFrame:CGRectMake(240 - 12 * 4 - 5, 85, 12 * 4 + 10*2, 15)];
    pageControlBg.layer.masksToBounds = YES;
    pageControlBg.layer.cornerRadius = 8;
    pageControlBg.backgroundColor = [UIColor colorWithRed:0.22 green:0.24 blue:0.23 alpha:.8];
    [xlCycleScrollView addSubview: pageControlBg];
    //pagecontrol
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(10, 0, 12*4, 15)];
    pageControl.backgroundColor = [UIColor clearColor];
    if (WXHLOSVersion()>=6.0) {
        pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1];
        pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.9 green:0.55 blue:0.13 alpha:1];
    }
    pageControl.userInteractionEnabled = NO;
    pageControl.numberOfPages = 4;
    pageControl.currentPage= 0;
    [pageControlBg addSubview:pageControl];
    
    
}
#pragma mark -
#pragma mark LoadDate
-(void)_loadDate{
    
}
@end
