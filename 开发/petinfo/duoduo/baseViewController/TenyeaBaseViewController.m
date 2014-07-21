//
//  TenyeaBaseViewController.m
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import "TenyeaBaseNavigationViewController.h"
@interface TenyeaBaseViewController ()
{
    UILabel *_titleLabel;
}
@end

@implementation TenyeaBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"宠信";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *VCS = self.navigationController.viewControllers;
    if (VCS.count > 1) {
        [self needReturnButton];
    }
}
//需要返回按钮
-(void)needReturnButton{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [button addTarget: self  action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
//    [self setLeftButton: button];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}
//返回事件
-(void)returnAction{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
