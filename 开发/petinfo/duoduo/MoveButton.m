//
//  MoveButton.m
//  宠信
//
//  Created by tenyea on 14-7-10.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "MoveButton.h"
#import <QuartzCore/QuartzCore.h>
#define time .7
#define repeat 1
@implementation MoveButton{
    BOOL isEnd;
}
//@synthesize imageView = _imageView;
//@synthesize label = _label;
-(id)initWithFrame:(CGRect)frame LabelText:(NSString *)text ImageView:(NSString *)image{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc]init];
        self.logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:image]];
        [self beginFrame];
        _label.text = text;
        _label.font = [UIFont systemFontOfSize:13];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        [self addSubview:_label];
        [self addSubview:self.logoImageView];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.5;
        isEnd = NO;
    }
    return self;
}
//初始化坐标
-(void)beginFrame{
    _label.frame = CGRectMake(0, 20, self.bounds.size.width, 20);
    self.logoImageView.frame = CGRectMake(self.bounds.size.width /2 - 10, 0, 20, 20);
}
//开始结束状态动画
-(void)beginAnimation{
    if (isEnd) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.duration = time;
        animation.repeatCount = repeat;
        //创建路径
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 45,20);
        CGPathAddCurveToPoint(path,NULL,45,30, 40,30 , 35,30);
        animation.path = path;
        //  动画运行完，保留最后动作
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [_label.layer addAnimation:animation forKey:@"test"];
        //    _label.frame = CGRectMake(15, 10, 60, 20);
        CAKeyframeAnimation *animation_image = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation_image.duration = time;
        animation_image.repeatCount = repeat;
        //创建路径
        CGMutablePathRef path_image = CGPathCreateMutable();
        CGPathMoveToPoint(path_image, NULL, 10,20);
        CGPathAddCurveToPoint(path_image,NULL,10,10,20,5, 35, 10);
        animation_image.path = path_image;
        //  动画运行完，保留最后动作
        animation_image.removedOnCompletion = NO;
        animation_image.fillMode = kCAFillModeForwards;
        [self.logoImageView.layer addAnimation:animation_image forKey:@"test"];
        //    _imageView.frame = CGRectMake(0, 10, 20, 20);
        isEnd = YES;

        
        
        isEnd = NO;
    }
}
-(void)endAnimation{
    if (!isEnd) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.duration = time;
        animation.repeatCount = repeat;
        //创建路径
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 35, 30);
        CGPathAddCurveToPoint(path,NULL,40,30,45,30, 45,20);
        animation.path = path;
        //  动画运行完，保留最后动作
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [_label.layer addAnimation:animation forKey:@"test"];
        //    _label.frame = CGRectMake(15, 10, 60, 20);
        CAKeyframeAnimation *animation_image = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation_image.duration = time;
        animation_image.repeatCount = repeat;
        //创建路径
        CGMutablePathRef path_image = CGPathCreateMutable();
        CGPathMoveToPoint(path_image, NULL, 35, 10);
        CGPathAddCurveToPoint(path_image,NULL,20, 5,10,10, 10,20);
        animation_image.path = path_image;
        //  动画运行完，保留最后动作
        animation_image.removedOnCompletion = NO;
        animation_image.fillMode = kCAFillModeForwards;
        [self.logoImageView.layer addAnimation:animation_image forKey:@"test"];
        //    _imageView.frame = CGRectMake(0, 10, 20, 20);
        isEnd = YES;
    }
}
@end
