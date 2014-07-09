//
//  StoryViewController.m
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "StoryViewController.h"

@interface StoryViewController ()
{
    float _heigh;
}
@end

@implementation StoryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"宠信" ;
    [self _initView];
    
}
#pragma mark -
#pragma mark init
-(void)_initView{
    _heigh = 0;
    [self _initTOP];
    
}
-(void)_initTOP{
    
    NSArray *nameArr = @[@"宠物明星",@"晒萌宠",@"人气萌宠",@"附近宠物"];
    NSArray *imageArr = @[@"main_home.png",@"main_story.png",@"main_ask.png",@"main_my.png"];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (nameArr.count/2+1)*60 )];
    bgView.backgroundColor = [UIColor colorWithRed:0.95 green:0.99 blue:1 alpha:1];
    [self.view addSubview:bgView];
    for (int i = 0; i <nameArr.count; i ++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(30 + i%2 *135, (i/2+1 )*15, 135, 45)];
        [button setTitle:nameArr[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:0.36 green:0.68 blue:0.89 alpha:1];
        button.tag = i +100;
        if (i%2 == 0) {
            
        }
        [bgView addSubview:button];
    }
}
#pragma mark - 
#pragma mark Action
-(void)TouchAction:(UIButton *)button {
    switch (button.tag) {
        case 101:
            break;
        case 102:
            break;
        case 103:
            break;
        case 104:
            break;
        default:
            break;
    }
}


@end
