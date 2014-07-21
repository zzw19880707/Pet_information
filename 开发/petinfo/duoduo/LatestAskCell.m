//
//  LatestAskCell.m
//  宠信
//
//  Created by tenyea on 14-7-19.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "LatestAskCell.h"

@implementation LatestAskCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imageV.layer.masksToBounds = YES;
    self.imageV.layer.cornerRadius = 25;
}



@end
