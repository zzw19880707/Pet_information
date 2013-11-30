//
//  LoginViewController.h
//  testLanucher
//
//  Created by 佐筱猪 on 13-10-22.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController <UITableViewDataSource,UITextFieldDelegate>{
    
    IBOutlet UITableView *loginTableView;
    IBOutlet UIImageView *logoImageView;
	UIButton *btnLogin;
	UIButton *btnCancel;
    
	UITextField *txtUser;
	UITextField *txtPass;
	
	NSArray *dataArray;
}

- (IBAction)loginAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
@property (nonatomic, retain) UITextField *txtUser;
@property (nonatomic, retain) UITextField *txtPass;
@property (retain, nonatomic) IBOutlet UITableView *loginTableView;
@property (retain, nonatomic) IBOutlet UIImageView *logoImageView;
@property (retain, nonatomic) IBOutlet UIButton *btnLogin;
@property (retain, nonatomic) IBOutlet UIButton *btnCancel;
- (IBAction)resignAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *resignButton;
@property (nonatomic, retain) NSArray *dataArray;
@end
