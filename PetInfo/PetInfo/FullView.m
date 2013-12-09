//
//  FullView.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-9.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "FullView.h"
#import "ImageWallModel.h"
#import "DataService.h"
@implementation FullView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
#pragma mark init
- (id)initWithModel:(ImageWallModel *)model andFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor=PetBackgroundColor;
        self.userInteractionEnabled=YES;//使view获取交互响应
        self.contentMode = UIViewContentModeScaleAspectFit;//填充模式
        
        //返回view
        UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        backView.backgroundColor =[UIColor blackColor];
        backView.alpha=0.3;
        backView.tag=1023;
        //返回按钮
        UIButton *backButton =[[UIButton alloc]initWithFrame:CGRectMake(20, (44-30)/2, 40, 30)];
        [backButton setImage:[UIImage imageNamed:@"home_btn_gray.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:backButton];
        [backButton release];
        [self addSubview:backView];
        [backView release];
        [backView setHidden:YES];
        //添加手势
        //双击返回
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shrinkAction:)];
        tapGesture.numberOfTapsRequired=2;
        [self addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        //向上显示详细
        UISwipeGestureRecognizer *swipUpGesture =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImageAction:)];
        swipUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipUpGesture];
        [swipUpGesture release];
        //向下全屏
        UISwipeGestureRecognizer *swipDownGesture =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImageAction:)];
        swipDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:swipDownGesture];
        [swipDownGesture release];
        
        //添加详细页面
        UIView *descView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight -130, ScreenWidth, 130)];
        descView.tag =1024;
        [descView setAlpha:0.3];
        descView.backgroundColor= [UIColor blackColor];
        
        //点赞按钮
        UIButton *goodButton =[[UIButton alloc]init];
        goodButton.frame=CGRectMake(320-40-10, 10, 40, 40);
        //tag = 1000 +0(0:good ,1:bad)
        goodButton.tag=1000 +0;
        [goodButton setImage:[UIImage imageNamed:@"home_good.png"] forState:UIControlStateNormal];
        [goodButton setImage:[UIImage imageNamed:@"home_good_highlighted.png"] forState:UIControlStateSelected];
        //已经选中
        if ([model.goodFlag intValue]>0) {
            goodButton.selected =YES;
        }
        [goodButton addTarget:self action:@selector(GoodBadAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //点赞label
        UILabel *goodLabel = [[UILabel alloc ]initWithFrame:CGRectMake(320-40-10,  goodButton.bottom, 40, 10)];
        goodLabel.font =[UIFont systemFontOfSize:10];
        ;
        goodLabel.text = [NSString stringWithFormat:@"%@",model.good ];
        goodLabel.tag =1033;
        goodLabel.textAlignment =NSTextAlignmentCenter;
        goodLabel.backgroundColor= CLEARCOLOR;
        [descView addSubview:goodLabel];
        [goodLabel release];
        //鄙视按钮
        UIButton *badButton= [[UIButton alloc]init];
        badButton.frame=CGRectMake(320-40-10,goodLabel.bottom+10, 40, 40);
        badButton.tag =1000 + 1;
        [badButton setImage:[UIImage imageNamed:@"home_bad.png"] forState:UIControlStateNormal];
        [badButton setImage:[UIImage imageNamed:@"home_bad_highlighted.png"] forState:UIControlStateSelected];
        //已经选中
        if ([model.badFlag intValue]>0) {
            badButton.selected =YES;
        }
        [badButton addTarget:self action:@selector(GoodBadAction:) forControlEvents:UIControlEventTouchUpInside];
        [descView addSubview:goodButton];
        [descView addSubview:badButton];
        [goodButton release];
        [badButton release];
        UILabel *badLabel = [[UILabel alloc ]initWithFrame:CGRectMake(320-40-10, badButton.bottom, 40, 10)];
        badLabel.font =[UIFont systemFontOfSize:10];
        badLabel.text = [NSString stringWithFormat:@"%@",model.bad];
        badLabel.tag = 1034;
        badLabel.textAlignment = NSTextAlignmentCenter;
        badLabel.backgroundColor = CLEARCOLOR;
        [descView addSubview:badLabel];
        [badLabel release];
        
        //作者
        UILabel *authorLable =[[UILabel alloc]initWithFrame:CGRectMake(10, 2, 100, 17)];
        authorLable.font=[UIFont systemFontOfSize:17];
        authorLable.text = model.author;
        authorLable.backgroundColor = CLEARCOLOR;
        authorLable.textColor = [UIColor whiteColor];
        [descView addSubview:authorLable];
        [authorLable release];
        //描述
        UIScrollView *descScroll =[[UIScrollView alloc] initWithFrame:CGRectMake(10, 25, ScreenWidth-50, 130-25)];
        
        UILabel *descLabel =[[UILabel alloc]init];
        descLabel.numberOfLines =0;
        descLabel.font=[UIFont systemFontOfSize:15];
        descLabel.text = model.des;
        descLabel.textColor= [UIColor whiteColor];
        CGSize size=[descLabel.text sizeWithFont:descLabel.font constrainedToSize:CGSizeMake(ScreenWidth-50, 1000)];//适配高度
        descLabel.frame =CGRectMake(0, 0, ScreenWidth-50, size.height);
        descLabel.tag = 1034;
        descLabel.backgroundColor = CLEARCOLOR;
        descScroll.showsVerticalScrollIndicator = NO;//隐藏竖滚动
        descScroll.showsHorizontalScrollIndicator =NO;//隐藏横滚动
        descScroll.contentSize = CGSizeMake(ScreenWidth-50, size.height);
        descScroll.backgroundColor= CLEARCOLOR;
        [descScroll addSubview:descLabel];
        [descLabel release];
        [descView addSubview:descScroll];
        [descScroll release];
        
        
        
        [self addSubview:descView];
        [descView release];
        _frame =frame;
    }
    return self;
}
#pragma mark 按钮事件
//全屏后缩小图片
-(void)shrinkAction:(UITapGestureRecognizer *)tapGesture{
    [self shrinkView];
}
//上下手势， 上 隐藏  下显示
- (void)scaleImageAction:(UISwipeGestureRecognizer *)gesture {
    if(gesture.direction==UISwipeGestureRecognizerDirectionRight){
        
    }else if(gesture.direction==UISwipeGestureRecognizerDirectionDown){
        UIView *view =[self viewWithTag:1024];
        UIView *backView =[self viewWithTag:1023];
        if (!view.hidden) {
            [UIView animateWithDuration:0.5 animations:^{
                view.transform =CGAffineTransformTranslate(view.transform, 0, 130);
                backView.transform =CGAffineTransformTranslate(backView.transform, 0, -44);
            } completion:^(BOOL finished) {
                [view setHidden:YES];
                [backView setHidden:YES];
            }];
            
        }
    }else if(gesture.direction==UISwipeGestureRecognizerDirectionUp){
        UIView *view =[self viewWithTag:1024];
        UIView *backView =[self viewWithTag:1023];
        if (view.hidden) {
            [UIView animateWithDuration:.5 animations:^{
                [view setHidden:NO];
                [backView setHidden:NO];
                backView.transform=CGAffineTransformIdentity;
                view.transform=CGAffineTransformIdentity;
            }];
            
        }
    }
    
}

//返回按钮事件
-(void)backAction{
    [self shrinkView];
}
//点赞按钮事件
-(void)GoodBadAction:(UIButton *)button{
    if ( [[NSUserDefaults standardUserDefaults]integerForKey:@"user_id"]==0) {
        [self alertLoginView];
        return;
    }
    UIView *backView =[self viewWithTag:1024];
    
    UILabel *goodLabel = (UILabel *)[backView viewWithTag:1033];
    UILabel *badLabel = (UILabel *)[backView viewWithTag:1034];
    NSString *key ,*value;
    //tag = 1000 + 0(0:good ,1:bad)
    if (button.selected) {
        button.selected = NO;//取消选中
        if ((button.tag -1000)%10 ==0) {//good
            int n =[goodLabel.text intValue];
            goodLabel.text = [NSString stringWithFormat:@"%d",n-1 ];
            key=@"good";
            
        }else{
            int n =[badLabel.text intValue];
            badLabel.text =[NSString stringWithFormat:@"%d",n-1 ];
            key=@"bad";
        }
        value =@"sub";
    }else {
        button.selected = YES;
        if ((button.tag -1000)%10 ==0) {//good
            int n =[goodLabel.text intValue];
            goodLabel.text = [NSString stringWithFormat:@"%d",n+1 ];
            key=@"good";
        }else{
            int n =[badLabel.text intValue];
            badLabel.text =[NSString stringWithFormat:@"%d",n+1 ];
            key=@"bad";
        }
        value=@"add";
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithCapacity:2];
    [params setDictionary:@{@"key": key,@"value":value}];
    [DataService  requestWithURL:VoteServlet andparams:params andhttpMethod:@"GET" completeBlock:^(id result) {
        
    } andErrorBlock:^(NSError *error) {
        
    }];
    
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==1) {
        
        [self.eventDelegate presentModalViewController];
    }
    
}

#pragma mark function
//弹出提示，跳转至登陆页面
-(void)alertLoginView {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你尚未登录，是否登陆？" delegate:self cancelButtonTitle:@"否"  otherButtonTitles:@"是", nil];
    [alert show];
    [alert release];
}
//缩小视图 方法
-(void)shrinkView {
    [UIApplication sharedApplication].statusBarHidden=NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = _frame;
        [[self viewWithTag:1023]setHidden:YES];
        [[self viewWithTag:1024]setHidden:YES];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        //        RELEASE_SAFELY(self);
    }];
}
@end
