//
//  FullView.h
//  PetInfo
//  用于实现点击按钮，图片变为全屏的方法。需要实现代理来关闭全屏view
//  Created by 佐筱猪 on 13-12-9.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageWallModel;

@protocol FullImageViewDelegate <NSObject>
//关闭视图代理
- (void) presentModalViewController ;
- (void) releaseFullView;
@end
@interface FullView : UIImageView <UIAlertViewDelegate>
{
    CGRect _frame;
    ImageWallModel *_model;
}
@property (nonatomic,assign) id<FullImageViewDelegate> eventDelegate;
- (id)initWithModel:(ImageWallModel *)model andFrame:(CGRect)frame;

@end
