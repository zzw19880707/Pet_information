//
//  HomeDetailViewController.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-27.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeDetailTableView.h"

@interface HomeDetailViewController : BaseViewController <ASIRequest,UItableviewEventDelegate>{
    NSArray *_data;
}
@property (retain, nonatomic) IBOutlet HomeDetailTableView *tableView;
@property (nonatomic, assign) int index;
@property (assign,nonatomic) kHomeTableViewCellType homeType;
@property (assign,nonatomic) NSString *titleText;

@end
