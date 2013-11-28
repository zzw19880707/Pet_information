//
//  HomeButtonViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-27.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "HomeButtonViewController.h"
#import "HomeDetailViewController.h"
@interface HomeButtonViewController ()

@end

@implementation HomeButtonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        switch (self.homeType) {
            case kMedicineType://药品
                self.title=@"宠物药品";
            case kDiseaseType://常见病
                self.title=@"常见病";
            case kNearType://附近
                
                self.title=@"附近";
        }
    }
    return self;
}
#pragma mark UI
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [NSBundle mainBundle]
}


#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeDetailViewController *homeDetailVC=[[HomeDetailViewController alloc]init];
    [self.navigationController pushViewController:homeDetailVC animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (self.homeType) {
        case kMedicineType://药品
            return 10;
        case kDiseaseType://常见病
            return 10;
        case kNearType://附近
            return 10;
        default:
            return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *buttoncellIndentifier=@"buttonCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:buttoncellIndentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:buttoncellIndentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
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
