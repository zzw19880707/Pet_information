//
//  HomeDetailViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-27.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "BaseTableView.h"
#import "OneDetailViewController.h"
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
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithInt:self.index] forKey:@"category"];
    
    if (self.homeType == kDetailDiseaseType) {
//        int self_user_id = [[NSUserDefaults standardUserDefaults]integerForKey:user_id];
        int self_user_id =10;
        if (self_user_id >0) {
            [params setValue:[NSNumber numberWithInt:self_user_id] forKey:@"user_id"];
        }
    }
    self.tableView.eventDelegate =self;
    self.tableView.index = self.index;
    self.tableView.homeType = self.homeType;
    self.tableView.refreshHeader = YES;
    self.tableView.isMore = YES;
    [self showHUD:INFO_RequestNetWork isDim:YES];
    [self accessToNetwork:params andGetCount:0 andLastId:0 andIsSetDone:NO];
    }
-(void)accessToNetwork:(NSMutableDictionary *)params andGetCount:(int)count andLastId:(int)lastId  andIsSetDone:(BOOL)isSetDone {
    DataService *dataService = [[DataService alloc]init];
    dataService.eventDelegate = self;
    [params setValue:[NSNumber numberWithInt:self.index] forKey:@"category"];
    if (count !=0) {
        [params setValue:[NSNumber numberWithInt:count] forKey:@"count"];
    }
    if (lastId !=0) {
        [params setValue:[NSNumber numberWithInt:lastId] forKey:@"lastid"];
    }
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
    //设置为true，则为上拉加载数据结束。否则不设置
    if (isSetDone) {
        [self.tableView doneLoadingTableViewData];
    }

}
#pragma mark UItableviewEventDelegate
-(void)pullDown:(BaseTableView *)tableView{
    _po(@"123");
}
-(void)pullUp:(BaseTableView *)tableView{
    _po(@"456");
    _po([_data lastObject]);
    int number = [[[_data lastObject] objectForKey:@"id"]intValue];
    [self accessToNetwork:[[NSMutableDictionary alloc]init] andGetCount:10 andLastId:number andIsSetDone:YES];
}
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OneDetailViewController  *oneDetailVC = [[OneDetailViewController alloc]init];
    oneDetailVC.detailId= [[_data[indexPath.row] objectForKey:@"id"] intValue];
    oneDetailVC.homeType = self.homeType;
    [self.navigationController pushViewController:oneDetailVC animated:YES];
//    switch (self.homeType) {
//        case kDetailMedicineType:
//            
//            break;
//        case kDetailDiseaseType:
//            
//            break;
//        case kDetailNearType:
//            
//            break;
//        default:
//            break;
//    }
}

#pragma mark ASIRequest delegate
- (void)requestFinished:(id )result{
    _data =[[NSArray alloc]init];
    [self hideHUD];
    switch (self.homeType) {
        case kDetailMedicineType://药品
            _data =[result objectForKey:@"drugs"];
            break;
        case kDetailDiseaseType://常见病
            _data = [result objectForKey:@"diseases"];
            break;
        case kDetailNearType://附近
            _data = [result objectForKey:@"Near"];
            break;
        default:
            break;
    }
    self.tableView.data = _data;
    [self.tableView reloadData];

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
