//
//  BaseScrollView.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-15.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UIScrollViewEventDelegate <NSObject>
@optional

@end
@interface BaseScrollView : UIScrollView <UIScrollViewDelegate>{
    UIScrollView *_buttonBgView;
    UIScrollView *_contentBgView;
    UIImageView *_sliderImageView;
}
//button宽70 ，frame（10+70*i,0,60,30）
//content
-(id)initWithFrame:(CGRect)frame andButtons:(NSArray *) buttons andContents:(NSArray *) contents;


@property (nonatomic,retain) NSArray *buttonsArray;
@property (nonatomic,retain) NSArray *contentsArray;

@property (nonatomic,assign) id<UIScrollViewEventDelegate> eventDelegate;
@end
