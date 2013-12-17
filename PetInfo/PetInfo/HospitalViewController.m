//
//  HospitalViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "HospitalViewController.h"
#import "DataService.h"

@interface HospitalViewController ()

@end

@implementation HospitalViewController

-(void)test{
    NSArray *array = [[NSArray alloc]init];
    array = @[@"123"];
    self.tableView.height = self.cellData.count*44;
    [self.cellData addObjectsFromArray:array];

//    [self performSelector:@selector(test1) withObject:nil afterDelay:.5];
    [self.tableView  reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"医院";
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.cellData = [[NSMutableArray alloc]init];
    self.scrollView.backgroundColor=[UIColor redColor];
    UIBarButtonItem *item =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(test)];
    self.navigationItem.leftBarButtonItem = item;
    
    NSArray *array = [[NSArray alloc]init];
    array = @[@"123",@"444",@"444",@"444",@"444"];
    [self.cellData addObjectsFromArray:array];
    self.tableView.height = self.cellData.count*80;

    [self.tableView reloadData];
}

#pragma mark 内存管理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)dealloc{
    [_tableView release];
    [_scrollView release];
    [super dealloc];
}

#pragma -
#pragma mark UITableViewDelegate
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size=self.scrollView.contentSize;
    size.height+=80;
    self.scrollView.contentSize=size;
    return 80;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.cellData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str= @"a";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    //config the cell
    cell.textLabel.text = [self.cellData objectAtIndex:indexPath.row];
    return cell;
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end
