//
//  BaseViewController.m
//  tabbartest
//
//  Created by 佐筱猪 on 13-10-15.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseViewController.h"
//#import "UIFactory.h"
#import "MBProgressHUD.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(AppDelegate *)appDelegate{
    AppDelegate *appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    return  appDelegate;
}

#pragma mark - loading tips 加载提示
//显示加载提示
- (void)showHUD:(NSString *)title isDim:(BOOL)isDim {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = title;
    self.hud.dimBackground = isDim;
}
//显示加载完成提示
- (void)showHUDComplete:(NSString *)title {
    self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.labelText = title;
}
//隐藏加载提示
- (void)hideHUD {
    [self.hud hide:YES];
}
//状态栏提示
-(void)showStaticTip:(BOOL)show title:(NSString *)title{
    if(_tipWindow==nil){
        _tipWindow =[[UIWindow alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        _tipWindow.windowLevel=UIWindowLevelStatusBar;
        _tipWindow.backgroundColor=[UIColor blackColor];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.textAlignment=UITextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:13];
        label.textColor=[UIColor whiteColor];
        label.backgroundColor=[UIColor clearColor];
        label.tag=13;
        [_tipWindow addSubview:label];
        
        UIImageView *progress=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"queue_statusbar_progress.png"]];
        progress.tag=14;
        progress.frame=CGRectMake(0, 20-6, 100, 6);
        
        [_tipWindow addSubview:progress];
        
    }
    UIImageView *progress=(UIImageView *)[_tipWindow viewWithTag:14];
    
    UILabel *tipLabel=(UILabel *)[_tipWindow viewWithTag:13];
    if (show) {
        tipLabel.text=title;
        _tipWindow.hidden=NO;
        //增加来回移动
        progress.left=0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        [UIView setAnimationRepeatCount:1000];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];//匀速移动
        progress.left=ScreenWidth-100;
        [UIView commitAnimations];
        
    }else{
        tipLabel.text=title;
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:2];
    }
    
}
-(void)removeTipWindow{
    _tipWindow.hidden=YES;
    [_tipWindow release];
    _tipWindow=nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置navegation背景颜色
    self.navigationController.navigationBar.tintColor = PetBackgroundColor;
	[self.view setBackgroundColor:PetBackgroundColor];


    NSArray *viewControllers = self.navigationController.viewControllers;
    
    
        
    if (self.isCancelButton) {
        UIBarButtonItem *cancelItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cencel)];
        self.navigationItem.leftBarButtonItem=[cancelItem autorelease];
    }else{
        if (viewControllers.count > 1 ) {
            UIButton *button = [[UIButton alloc]init];
            button.backgroundColor = PetBackgroundColor;
            //        [button setTitle:@"返回" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"navagiton_back.png"] forState:UIControlStateNormal];
            button.frame = CGRectMake(0, 0, 40, 30);
            //        button.showsTouchWhenHighlighted = YES;
            [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
            self.navigationItem.leftBarButtonItem = [backItem autorelease];
        }
    }

}
#pragma mark ----按钮事件
-(void)cencel{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----内存管理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    MARK;
    [super dealloc];
}
-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectZero];
//    titlelabel.textColor=[UIColor blackColor];
    titlelabel.font=[UIFont boldSystemFontOfSize:18.0f];
    titlelabel.backgroundColor= PetBackgroundColor;
    titlelabel.text=title;
    titlelabel.textColor=PetTextColor;
    [titlelabel sizeToFit];
    self.navigationItem.titleView = [titlelabel autorelease];
}


@end
