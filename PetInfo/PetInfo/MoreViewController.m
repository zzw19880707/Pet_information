//
//  MoreViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "MoreViewController.h"
#import "LoginViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"我的";
    }
    return self;
}
#pragma mark UI
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults stringForKey:@"username"];
    NSArray *petArray = [userDefaults arrayForKey:@"pet"];
    if ([username isEqualToString:@""] ||username ==NULL) {
        username = @"登陆";
        petArray = @[@"尚未登陆"];
    }else {
        if ([petArray  count] == 0) {
            petArray = @[@"无"];
        }
        
    }
    _data=@[@[username],petArray,@[@"提点意见",@"打个分，鼓励一下"],@[@"用户协议",@"关于我们"]] ;
    _data = [_data retain];
    _section=@[@"个人信息",@"宠物信息",@"意见反馈",@"泡宠信息"];
    _section = [_section retain];
    [self.tableView  reloadData];
    [super viewWillAppear:animated];
}



#pragma mark ----datasource

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _section[section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _section.count;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}//选中时跳转视图。

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_data[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSArray array=
    //定义一个静态标识符
    static NSString *cellIndentifier = @"cell";
    //检查是否有闲置单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    //创建单元格
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier]autorelease];
    }
    cell.textLabel.text = _data[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
        if (![cell.textLabel.text isEqualToString:@"登陆"]) {
            cell.textLabel.textColor=PetTextColor;
        }else{
            cell.textLabel.textColor=[UIColor grayColor];
        }
    }else if(indexPath.section==1&&indexPath.row==0){
        if ([cell.textLabel.text isEqualToString:@"尚未登陆"]) {
            
        }else{
            UIButton *button=[[UIButton  alloc]initWithFrame:CGRectMake(240, 7, 30, 30)];
            [button setImage:[UIImage imageNamed:@"more_pet_add"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(addPet) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
            [button release];
        }
        
    }
 

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    
    return cell;
}
#pragma mark ----delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0&&indexPath.row==0) {
        LoginViewController *login=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }else if(indexPath.section == 1){
        if ([_data[indexPath.section][0]isEqualToString:@"尚未登陆"]) {
#warning 
        }else {
            
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];

}

#pragma mark ----按钮事件
-(void)addPet{
//    [self.navigationController pushViewController:[[SettingViewController alloc]init] animated:YES];
}














#pragma mark 内存管理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
