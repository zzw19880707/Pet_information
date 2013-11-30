//
//  HomeButtonViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-27.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "HomeButtonViewController.h"
//#import "HomeDetailViewController.h"
@interface HomeButtonViewController ()

@end

@implementation HomeButtonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
#pragma mark UI
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.titleText;
    NSDictionary *dic=[[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"HomeButton" ofType:@"plist"]];
    
    switch (self.homeType) {
        case kMedicineType://药品
            _data =[[dic objectForKey:@"Medicine"]retain];
            break;
        case kDiseaseType://常见病
            _data =[[dic objectForKey:@"Disease"]retain];;
            break;
        case kNearType://附近
            _data =[[dic objectForKey:@"near"]retain];;
            break;
    }
}


#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeButtonViewController *homeDetailVC=[[HomeButtonViewController alloc]init];
    if (self.homeType<3) {
        homeDetailVC.homeType=self.homeType+3;
        homeDetailVC.titleText=self.titleText;
    }else{
        switch (self.homeType) {
            case kDiseaseType://常见病
                
            case kMedicineType://药品
                break;
            case kNearType://附近
                break;
            case kDetailDiseaseType://
                break;
            case kDetailNearType://
                break;
            case kDetailMedicineType://
                break;
            default:
                break;
        }

    }
    [self.navigationController pushViewController:homeDetailVC animated:YES];
    //设置为未选中状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *buttoncellIndentifier=@"buttonCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:buttoncellIndentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:buttoncellIndentifier];
        if (self.homeType ==kDiseaseType) {//常见病会添加图片
            UIImageView *image=[[UIImageView alloc]init];
            image.tag=1020;
            image.frame=CGRectMake(20, (44-30)/2, 50, 30);
            [cell.contentView addSubview:image];
            [image release];
            UILabel *label =[[UILabel alloc]init];
            label.tag=1021;
            label.frame=CGRectMake(90, (44-30)/2, 150, 30);
            [cell.contentView addSubview:label];
            [label release];
        }
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (self.homeType == kDiseaseType) {
        UIImageView *image=(UIImageView *)[cell.contentView viewWithTag:1020];
        NSString *imagename=[NSString stringWithFormat:@"homecell_backgroundimage_%d.png",indexPath.row];
        image.image =[UIImage imageNamed:imagename];
        UILabel *label =(UILabel *)[cell.contentView viewWithTag:1021];
        label.text=_data[indexPath.row];
        
    }else{
        cell.textLabel.text=_data[indexPath.row];

    }
    
    return cell;
}





#pragma mark 内存管理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    RELEASE_SAFELY(_data);

    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    RELEASE_SAFELY(_data);
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
