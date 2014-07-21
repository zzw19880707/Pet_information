//
//  PetSexViewController.m
//  宠信
//
//  Created by tenyea on 14-7-16.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "PetSexViewController.h"

@interface PetSexViewController ()
{
    int _select;
}
@end

@implementation PetSexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"性别";
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:bgView];
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 44*2) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    NSString *sexStr =[[[NSUserDefaults standardUserDefaults]dictionaryForKey:UD_petInfo_temp_PetModel] objectForKey:@"petSex"];
    _select = sexStr == nil ? 0 :[sexStr intValue];
    
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"公";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"母";
    }
    if (indexPath.row ==_select ) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSIndexPath *index = [NSIndexPath indexPathForRow: _select inSection:0];
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
    [muDic setValue:[NSString stringWithFormat:@"%d",_select] forKey:@"petSex"];
    [[NSUserDefaults standardUserDefaults]setValue:muDic forKeyPath:UD_petInfo_temp_PetModel];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //    返回上一级菜单
    [self.navigationController popViewControllerAnimated:YES];

}
@end
