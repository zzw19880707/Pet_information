//
//  PetKindViewController.m
//  宠信
//
//  Created by tenyea on 14-7-16.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "PetKindViewController.h"

@interface PetKindViewController ()
{
    int _select;
    NSArray *_kindArr;
}
@end

@implementation PetKindViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"种类";
    
    _kindArr = @[@"狗狗",@"猫猫",@"小宠",@"水族",@"其他"];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:bgView];
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 44*[_kindArr count]) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    NSString *kindStr =[[[NSUserDefaults standardUserDefaults]dictionaryForKey:UD_petInfo_temp_PetModel] objectForKey:@"petKind"];
    _select = kindStr== nil?0:[kindStr intValue];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [button addTarget: self  action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)returnAction{
    [self popVC];
}
-(void)submitAction{
    [self popVC];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_kindArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = _kindArr[indexPath.row];
    if (indexPath.row == _select) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSIndexPath *index = [NSIndexPath indexPathForRow: (_select) inSection:0];
    UITableViewCell *desCell = [tableView cellForRowAtIndexPath:index];
    desCell.accessoryType = UITableViewCellAccessoryNone;
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    _select = indexPath.row;
    
    [self performSelector:@selector(popVC) withObject:nil afterDelay:.2];
    
}
-(void)popVC {
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UD_petInfo_temp_PetModel ];
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [muDic setValue:[NSString stringWithFormat:@"%d",_select] forKey:@"petKind"];
    [[NSUserDefaults standardUserDefaults]setValue:muDic forKeyPath:UD_petInfo_temp_PetModel];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //    返回上一级菜单
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
