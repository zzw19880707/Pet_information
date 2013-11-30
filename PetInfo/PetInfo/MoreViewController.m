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
    _data=@[@[],@[],@[@"提点意见",@"打个分，鼓励一下"],@[@"用户协议",@"关于我们"]];
    _section=@[@"个人信息",@"宠物信息",@"意见反馈",@"泡宠信息"];
}
-(void)viewWillAppear:(BOOL)animated{
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
    
    if (indexPath.section==0&&indexPath.row==0) {
        NSString *username=[[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
        if([username isEqualToString:@""]||username==NULL){
            cell.textLabel.text=@"登陆";
            cell.textLabel.textColor=PetTextColor;
        }else{
            cell.textLabel.textColor=[UIColor grayColor];
            cell.textLabel.text=username;
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.section==2){
        if (indexPath.row==0) {
            cell.textLabel.text=@"提点意见";
        }else{
            cell.textLabel.text=@"打个分，鼓励一下";
        }
    }else if(indexPath.section==3){
        if (indexPath.row==0) {
            cell.textLabel.text=@"用户协议";
            
        }else{
            cell.textLabel.text=@"关于我们";
            
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else{//宠物信息
        
        UIButton *button=[[UIButton  alloc]initWithFrame:CGRectMake(260, 7, 30, 30)];
        [button setImage:[UIImage imageNamed:@"more_pet_add"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addPet) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
        [button release];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    
    return cell;
}
#pragma mark ----delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0&&indexPath.row==0) {
        LoginViewController *login=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
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
