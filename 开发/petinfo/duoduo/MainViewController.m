//
//  MainViewController.m
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "StoryViewController.h"
#import "AskViewController.h"
#import "MyViewController.h"

@interface MainViewController ()
{
    int _tabbar_button_select ;
}
@end

@implementation MainViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化子控制器
    [self _initController];
    //初始化tabbar
    [self _initTabbarView];

}



#pragma mark -
#pragma mark init
//初始化子控制器
-(void)_initController{
    HomeViewController *home=[[HomeViewController alloc]init];
    StoryViewController *story=[[StoryViewController alloc]init];
    AskViewController *ask=[[AskViewController alloc]init];
    MyViewController *my=[[MyViewController alloc]init] ;
    
    NSArray *views=@[home,story,ask,my];
    NSMutableArray *viewControllers=[NSMutableArray arrayWithCapacity:4];
    for (UIViewController *viewController in views) {
        TenyeaBaseNavigationViewController *navViewController =[[TenyeaBaseNavigationViewController alloc]initWithRootViewController:viewController];
        [viewControllers addObject:navViewController];
        navViewController.delegate = self;
    }
    self.viewControllers=viewControllers;
}
//初始化tabbar
-(void)_initTabbarView{
    [self.tabBar setHidden:YES];
    _tabbarView=[[UIView alloc]init];
    _tabbarView.frame=CGRectMake(0, ScreenHeight-49, ScreenWidth, 49);
    _tabbarView.backgroundColor = COLOR(249, 249, 249);
    [self.view addSubview:_tabbarView];
    NSArray *backgroud = @[@"main_home.png",@"main_story.png",@"main_ask.png",@"main_my.png"];
    NSArray *backgroud_selected = @[@"main_home_selected.png",@"main_story_selected.png",@"main_ask_selected.png",@"main_my_selected.png"];
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage =backgroud[i];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake( (320/backgroud.count) *i, 0, (320/backgroud.count), 49);
        button.tag=100+i;
        if (i == 0 ) {
            button.selected = YES;
            _tabbar_button_select = button.tag;
        }
        [button setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:backgroud_selected[i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        //设置高亮
//        [button setShowsTouchWhenHighlighted:YES];
        [_tabbarView addSubview:button];
    }
    
    
}


#pragma mark -
#pragma mark 按钮事件
//tabbar选中事件
-(void)selectedTab:(UIButton *)button
{
    if (_tabbar_button_select) {
        UIButton *button = (UIButton *)VIEWWITHTAG(_tabbarView, _tabbar_button_select);
        button.selected = NO;
    }
    _tabbar_button_select = button.tag;
    int site = button.tag - 100;
    button.selected = YES;
    self.selectedIndex = site;
}

#pragma mark -
#pragma mark method
-(void)setTabbarShow:(BOOL)isshow{
    if (isshow) {
        [UIView animateWithDuration:.3 animations:^{
            _tabbarView.transform = CGAffineTransformIdentity;
        }];
    }else{
        [UIView animateWithDuration:.3 animations:^{
            _tabbarView.transform = CGAffineTransformTranslate(_tabbarView.transform, 0, _tabbarView.height);
        }];
    }
}
@end
