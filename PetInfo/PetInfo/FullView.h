//
//  FullView.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-9.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageWallModel;

@protocol FullImageViewDelegate <NSObject>

- (void) presentModalViewController ;

@end
@interface FullView : UIImageView <UIAlertViewDelegate>
{
    CGRect _frame;
}
@property (nonatomic,assign) id<FullImageViewDelegate> eventDelegate;
- (id)initWithModel:(ImageWallModel *)model andFrame:(CGRect)frame;

@end
