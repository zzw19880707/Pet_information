//
//  StoryCell.h
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *TimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *UserNameLabel;

@end
