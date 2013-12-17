//
//  CommunityViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "CommunityViewController.h"
#import "BaseScrollView.h"
@interface CommunityViewController ()

@end

@implementation CommunityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"社区";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    NSMutableArray *arrays = [[NSMutableArray alloc]init];
    for (int i =0; i<10; i++) {
        UIButton *button =[[UIButton alloc]init];
        [button setTitle:[NSString stringWithFormat:@"title%d",i] forState:UIControlStateNormal];
        [button setTitleColor:PetTextColor forState:UIControlStateNormal];
        button.backgroundColor = PetBackgroundColor;
        button.frame = CGRectMake(10 + 70*i, 0, 60, 30);
        [arrays addObject:button];
        [button release];
    }
    NSArray *array = [NSArray arrayWithArray:arrays];
    arrays = [[NSMutableArray alloc]init];
    for (int i =0; i<10; i++) {
        UILabel *view=[[UILabel alloc]init];
        view.text =[NSString stringWithFormat: @"content%d",i];
        view.textColor = PetTextColor;
        view.backgroundColor = PetBackgroundColor;
        view.frame = CGRectMake(0, 0, 320, 40);
        [arrays addObject: view];
    }
    BaseScrollView *sc = [[BaseScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 350) andButtons:array andContents:[NSArray arrayWithArray:arrays]];
    [self.view addSubview:sc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
