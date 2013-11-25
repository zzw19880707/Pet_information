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

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:YES];
    }
    return self;
}

//初始化子控制器
-(void)_initController{
    HomeViewController *home=[[HomeViewController alloc]init];
    HospitalViewController *hospital=[[HospitalViewController alloc]init];
    CommunityViewController *commu=[[CommunityViewController alloc]init];
    ShopViewController *shop=[[ShopViewController alloc]init];
    MoreViewController *more=[[MoreViewController alloc]init];
    
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
    //第一次登陆
    if (![userDefaults boolForKey:isFirstLogin]) {
#warning 推送绑定
        [BPush bindChannel];
        [userDefaults setBool:YES forKey:isFirstLogin];
    }

    //初始化子控制器
    [self _initController];
    [self _initTabbarView];
//    _sliderView.frame= CGRectMake(152.5, 44, 15, 44);
//    {{152.5, 5}, {15, 44}};

    
    
}
#pragma mark 按钮事件
-(void)selectedTab:(UIButton *)button {
    //    NSLog(@"tag--->%d",button.tag);
    
    button.selected=YES;
    if (self.selectedIndex !=(button.tag-100)) {
        //设置选中的按钮----->未选中状态
        UIButton *bu = (UIButton *)[_tabbarView viewWithTag:(self.selectedIndex+100)];
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

@end
