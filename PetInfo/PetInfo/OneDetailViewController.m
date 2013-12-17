//
//  OneDetailViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-16.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "OneDetailViewController.h"
#import "UIImageView+WebCache.h"
@interface OneDetailViewController ()

@end

@implementation OneDetailViewController

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
    //视图初始化
    _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 119)];
    [_backgroundView addSubview:_imageView];
    [self.view addSubview:_backgroundView];
    //访问网络
    DataService *dataService=[[DataService alloc]init];
    dataService.eventDelegate = self;
    NSString *url =[[NSString alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];

    if (self.homeType == kDetailDiseaseType) {
        url=DiseaseDetailOneServlet;
        [params setValue:[NSNumber numberWithInt:self.detailId] forKey:@"Disease_id"];
    }else if(self.homeType == kDetailMedicineType){
        url=MedicineDetailOneServlet;
        [params setValue:[NSNumber numberWithInt:self.detailId] forKey:@"Medicine_id"];

    }
    [super showHUD:INFO_RequestNetWork isDim:YES];
    [dataService requestWithURL:url andparams:params andhttpMethod:@"GET"];
}

/*
 "disease": {
 "id": 1,
 "name": "名字",
 "category": 1,
 "des": "描述",
 "diagnose": "诊断",
 "symptom": "症状",
 "cure": "治疗",
 "prevent": "预防"
 }
 */
-(void)_initDisease:(id)result{
    
    NSDictionary *dic = [result objectForKey:@"disease"];
    
//    int disease_id = [[dic objectForKey:@"id"] intvalue];
    NSString *name = [dic objectForKey:@"name"];
    self.title = name;
    NSString *des = [dic objectForKey:@"des"];
    NSString *diagnose = [dic objectForKey:@"diagnose"];
    NSString *symptom = [dic objectForKey:@"symptom"];
    NSString *cure = [dic objectForKey:@"cure"];
    NSString *prevent = [dic objectForKey:@"prevent"];
    
    NSArray *labelArray = @[des,diagnose,symptom,cure,prevent];
    NSArray *nameArray = @[@"描述",@"诊断",@"症状",@"治疗",@"预防"];
    [self _initBaseScrollView:nameArray andlabelArray:labelArray andHeight:ScreenHeight -10-44-44-15-10];
    [_backgroundView setHidden:YES];
}
/*
 "drug": {
 "id": 2,
 "name": "阿司匹林",
 "pic": "http://ww1.sinaimg.cn/large/53e0c4edjw1dy3qf6n17xj.jpg",
 "picMin": "http://ww1.sinaimg.cn/large/53e0c4edjw1dy3qf6n17xj.jpg",
 "country": "中国",
 "chemicalName": "不知道",
 "base": "阿斯和匹林",
 "scope": "生物",
 "des": "吃",
 "price": 3.1415926,
 "standard": "无规格",
 "category": "1",
 "dosage": "随便吃",
 "marker": "国药2013",
 "notice": "没病别吃",
 "address": "腾翼制药",
 "shopId": 1
 }
 */
-(void)_initMedicine:(id)result{
    NSDictionary *dic = [result objectForKey:@"drug"];
    NSString *name = [dic objectForKey:@"name"];
    self.title = name;
    
    
    
    NSArray *labelArray = @[des,diagnose,symptom,cure,prevent];
    NSArray *nameArray = @[@"描述",@"诊断",@"症状",@"治疗",@"预防"];
    [_imageView setImageWithURL:[dic objectForKey:@"pic"]];
    [self _initBaseScrollView:nameArray andlabelArray:labelArray andHeight:ScreenHeight-120 -10-44-44-15-10];
}
-(void)_initBaseScrollView:(NSArray *)nameArray andlabelArray:(NSArray*)labelArray andHeight:(int)height{
    NSMutableArray *arrays = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<nameArray.count; i++) {
        UIButton *button =[[UIButton alloc]init];
        [button setTitle:nameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:PetTextColor forState:UIControlStateNormal];
        button.backgroundColor = PetBackgroundColor;
        button.frame = CGRectMake(10 + 70*i, 0, 60, 30);
        [arrays addObject:button];
        [button release];
    }
    NSArray *array = [NSArray arrayWithArray:arrays];
    arrays = [[NSMutableArray alloc]init];
    for (int i =0; i<10; i++) {
        UILabel *view=[[UILabel alloc]init];
        view.text =labelArray[i];
        view.font = FONT(18);
        view.textColor = PetTextColor;
        view.backgroundColor = PetBackgroundColor;
        view.numberOfLines = 0;
        CGSize size =[view sizeThatFits:CGSizeMake(ScreenWidth, 1000)];
        view.frame = CGRectMake(0, 0, ScreenWidth, size.height);
        [arrays addObject: view];
        [view release];
    }
    _baseScrollView = [[BaseScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, height) andButtons:array andContents:[NSArray arrayWithArray:arrays]];
    [self.view addSubview:_baseScrollView];
}
#pragma mark asiDelegate
-(void)requestFailed:(ASIHTTPRequest *)request{
    _po([[request error] localizedDescription]);
}
-(void)requestFinished:(id)result{
    [self hideHUD];
    switch (self.homeType) {
        case kDetailMedicineType:
            [self _initMedicine:result];
            break;
        case kDetailDiseaseType:
            [self _initDisease:result];
            break;
        default:
            break;
    }
    
}
#pragma mark 内存管理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    RELEASE_SAFELY(_backgroundView);
    RELEASE_SAFELY(_imageView);
    RELEASE_SAFELY(_baseScrollView);
    
    [super dealloc];
}
@end
