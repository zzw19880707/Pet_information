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
    // Do any additional setup after loading the view from its nib.
}

#pragma mark 内存管理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [super dealloc];
}

- (IBAction)test:(id)sender {
    
    [DataService requestWithURL:@"test" andparams:nil andhttpMethod:@"POST" completeBlock:^(id result) {
        
    }andErrorBlock:^(NSError *error) {
        
    }];
}
@end
