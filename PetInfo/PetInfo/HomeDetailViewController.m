//
//  HomeDetailViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-27.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "HomeDetailViewController.h"
//附近的相关子页面
@interface HomeDetailViewController ()

@end

@implementation HomeDetailViewController

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
}


#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeDetailViewController *homeDetailVC=[[HomeDetailViewController alloc]init];
    
    [self.navigationController pushViewController:homeDetailVC animated:YES];
    //设置为未选中状态
    [self.tabelView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *buttoncellIndentifier=@"buttonCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:buttoncellIndentifier];
//    
//    if (cell==nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:buttoncellIndentifier];
//        if (self.homeType ==kDiseaseType) {//常见病会添加图片
//            UIImageView *image=[[UIImageView alloc]init];
//            image.tag=1020;
//            image.frame=CGRectMake(20, (44-30)/2, 50, 30);
//            [cell.contentView addSubview:image];
//            [image release];
//            UILabel *label =[[UILabel alloc]init];
//            label.tag=1021;
//            label.frame=CGRectMake(90, (44-30)/2, 150, 30);
//            [cell.contentView addSubview:label];
//            [label release];
//        }
//    }
//    
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//   
    
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tabelView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTabelView:nil];
    [super viewDidUnload];
}
@end
