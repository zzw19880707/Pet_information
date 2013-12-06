//
//  MessView.h
//  AOWaterView
//
//  Created by akria.king on 13-4-10.
//  Copyright (c) 2013年 akria.king. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageWallModel.h"

@protocol imageDelegate <NSObject>

-(void)click:(ImageWallModel *)data;

@end

@interface MessView : UIView
@property(nonatomic,strong)ImageWallModel *dataInfo;
@property(nonatomic,strong)id<imageDelegate> idelegate;

-(id)initWithData:(ImageWallModel *)data yPoint:(float) y;

-(void)click;
@end
