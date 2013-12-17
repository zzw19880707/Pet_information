//
//  OneDetailViewController.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-16.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseScrollView.h"

@interface OneDetailViewController : BaseViewController<ASIRequest>{
    UIView *_backgroundView;
    UIImageView *_imageView;
    BaseScrollView *_baseScrollView;
}

@property (nonatomic,assign) int detailId;
@property (assign,nonatomic) kHomeTableViewCellType homeType;

@end
