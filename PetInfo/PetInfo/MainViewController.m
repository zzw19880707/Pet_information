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
    
    NSArray *views=@[home,hospital,commu,shop,more];
    NSMutableArray *viewControllers=[NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in views) {
        BaseNavViewController *navViewController =[[BaseNavViewController alloc]initWithRootViewController:viewController];
        [viewControllers addObject:navViewController];
        [navViewController release];
        
    }
    self.viewControllers=viewControllers;    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    //第一次登陆
    if (![userDefaults boolForKey:isFirstLogin]) {
        [BPush bindChannel];
        [userDefaults setBool:YES forKey:isFirstLogin];
    }
    //初始化子控制器
    [self _initController];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
