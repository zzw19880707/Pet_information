//
//  HomeViewController.m
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "HomeViewController.h"
@interface HomeViewController ()
{
    UIScrollView *_bgScrollView;
    float _heigh;
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
    
    


//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44+20, ScreenWidth, ScreenHeight - 44- 20 -49)];
    _bgScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_bgScrollView];
    _heigh = 0;
    [self _initUI];
    [self _loadDate];
}

#pragma mark - 
#pragma mark UI
-(void)_initUI{
//    轮播图
    
}
#pragma mark -
#pragma mark LoadDate
-(void)_loadDate{
    
}
@end
