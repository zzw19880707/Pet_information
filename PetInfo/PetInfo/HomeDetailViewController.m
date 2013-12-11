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
    [self _initView];
}
-(void)_initView{
    DataService *dataService = [[DataService alloc]init];
    dataService.eventDelegate = self;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithInt:self.index] forKey:@"category"];
    
    [self showHUD:@"加载中..." isDim:YES];
    self.tableView.index = self.index;
    self.tableView.homeType = self.homeType;
    switch (self.homeType) {
        case kDetailMedicineType://药品
            self.request =[dataService requestWithURL:MedicineServlet andparams:params andhttpMethod:@"GET"];
            break;
        case kDetailDiseaseType://常见病
            self.request =[dataService requestWithURL:DiseaseServlet andparams:params andhttpMethod:@"GET"];
            break;
        case kDetailNearType://附近
//            [params setValue:[NSNumber numberWithFloat:_longitude] forKey:@"longitude"];
//            [params setValue:[NSNumber numberWithFloat:_latitude] forKey:@"latitude"];
            self.request =[dataService requestWithURL:NearServlet andparams:params andhttpMethod:@"GET"];
            break;
        default:
            break;
    }
}
#pragma mark UItableviewEventDelegate
-(void)pullDown:(BaseTableView *)tableView{
    
}
-(void)pullUp:(BaseTableView *)tableView{
    
}
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark ASIRequest delegate
- (void)requestFinished:(id )result{
    
    [self hideHUD];
    switch (self.homeType) {
        case kDetailMedicineType://药品
            _data =[result objectForKey:@"Medicine"];
            break;
        case kDetailDiseaseType://常见病
            _data = [result objectForKey:@"Disease"];
            break;
        case kDetailNearType://附近
            _data = [result objectForKey:@"Near"];
            break;
        default:
            break;
    }
    self.tableView.data = _data;

}
-(void)requestFailed:(ASIHTTPRequest *)request{
    [self hideHUD];
    alertContent([[request error] localizedDescription]);
}
#pragma mark 内存管理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    RELEASE_SAFELY(_tableView);
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
