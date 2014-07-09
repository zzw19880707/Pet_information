//
//  StoryCell.m
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "StoryCell.h"

@implementation StoryCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _init];
}
-(void)_init{
    _ImageView.layer.masksToBounds = YES;
    _ImageView.layer.cornerRadius = 50;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
