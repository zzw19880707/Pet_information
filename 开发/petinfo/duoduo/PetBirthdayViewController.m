//
//  PetBirthdayViewController.m
//  宠信
//
//  Created by tenyea on 14-7-16.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "PetBirthdayViewController.h"
#import "PetModel.h"
@interface PetBirthdayViewController ()

@end

@implementation PetBirthdayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"生日";
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [button addTarget: self  action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    PetModel *model = [[PetModel alloc]initWithDataDic:[[NSUserDefaults standardUserDefaults] objectForKey:UD_petInfo_temp_PetModel]];
    if (![model.petBirthday isEqualToString:@""]) {
        NSString *bir = model.petBirthday;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:bir];
        [self.birthday setDate:date animated:NO];
    }
    
}
-(void)setDate {
    NSDate *date = [self.birthday date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSDictionary *dic= [[NSUserDefaults standardUserDefaults] objectForKey:UD_petInfo_temp_PetModel];
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:dic];
    [d setValue:strDate forKey:@"petBirthday"];
//    model.petBirthday = strDate;
    [[NSUserDefaults standardUserDefaults] setValue:d forKey:UD_petInfo_temp_PetModel];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)submitAction{
    [self setDate];
    [self.navigationController popViewControllerAnimated:YES];
}

//返回事件
-(void)returnAction{
    [self setDate];
    [super returnAction];
}
@end
