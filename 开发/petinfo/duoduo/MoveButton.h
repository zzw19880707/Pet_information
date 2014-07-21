//
//  MoveButton.h
//  宠信
//
//  Created by tenyea on 14-7-10.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveButton : UIButton
{
//    UILabel *_label;
//    UIImageView *_imageView;
    
//    CGPoint _labelCenter;
    float _label_R;
    double _label_S;
//    CGPoint _imageCenter;
    double _image_S;
    float _image_R;
    
}
-(id)initWithFrame:(CGRect)frame LabelText:(NSString *)text ImageView:(NSString *)image;
//动画
-(void)beginAnimation;
-(void)endAnimation;

@property (strong,nonatomic) UILabel *label;
@property (strong,nonatomic) UIImageView *logoImageView;
@end
