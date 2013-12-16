//
//  BaseScrollView.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-12-15.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseScrollView.h"

@implementation BaseScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andButtons:(NSArray *) buttons andContents:(NSArray *) contents{
    self = [super initWithFrame:frame];
    if (self) {

        self.buttonsArray = buttons;
        self.contentsArray = contents;
        //用于分割线
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor =[UIColor grayColor];
        bgView.frame = CGRectMake(0, 0, frame.size.width, 40);
    
        _sliderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10+15, 30, 30, 10)];
        
        _sliderImageView.image = [UIImage imageNamed:@"slider_bg_baseScroll.png"];
        
        _buttonBgView = [[ UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 39)];
        [_buttonBgView addSubview:_sliderImageView];

        _buttonBgView.backgroundColor = PetBackgroundColor;
        _buttonBgView.contentSize =CGSizeMake( 70*buttons.count, 40);
        _buttonBgView.showsHorizontalScrollIndicator = NO;
        _buttonBgView.tag =10000;
        for (int i = 0; i<buttons.count ; i++) {
            UIButton *button = (UIButton *)buttons[i];
            [button addTarget: self  action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            button.tag = 1000+i;
            [_buttonBgView addSubview:button];
            [button release];
        }
    
        [bgView addSubview:_buttonBgView];
        [self addSubview:bgView];
        [bgView release];
        _contentBgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, frame.size.width+20, frame.size.height - 40)];
        _contentBgView.tag =10001;
        _contentBgView.pagingEnabled =YES;
        _contentBgView.delegate = self;
        _contentBgView.showsHorizontalScrollIndicator=NO;
        _contentBgView.showsVerticalScrollIndicator=NO;
        _contentBgView.contentSize = CGSizeMake(340*buttons.count, frame.size.height-40);
        _contentBgView.backgroundColor = PetBackgroundColor;
        int _tx = 0 ;
        for (int i = 0;i<contents.count ; i++) {
            
            UIScrollView *labelscroll = [[UIScrollView alloc]init];
            labelscroll.frame = CGRectMake(340 *i, 0, _contentBgView.width, _contentBgView.height);
            UIView *view =(UIView *)contents[i];
            labelscroll.contentSize = view.size;
            [labelscroll addSubview:view];
            [_contentBgView addSubview:labelscroll];
            _tx +=340;
        }
        [self addSubview:_contentBgView];

    }
    return self;
}


#pragma mark 按钮事件
-(void)selectAction:(UIButton *)button{
    int page = button.tag -1000;
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint spoint = _sliderImageView.origin;
        spoint.x = 10+15+page *70;
        _sliderImageView.origin = spoint;
    }];
    CGPoint point = _contentBgView.contentOffset;
    point.x = page *340;
    _contentBgView.contentOffset = point;
}


#pragma mark ScrollDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = _contentBgView.contentOffset.x/340;
    
    CGPoint point = [_sliderImageView convertPoint:CGPointMake(0, 0) fromView:[UIApplication sharedApplication].keyWindow ];
    //向右平移
    if (page<self.buttonsArray.count-1) {
        if (70+70-point.x>self.frame.size.width) {
            CGPoint cpoint = _buttonBgView.contentOffset;
            cpoint.x += 140 -(320+point.x)-25;
            [_buttonBgView setContentOffset:cpoint animated:YES];
        }
    }
    //向左平移
    if (page>0) {
        if (-point.x-70<0) {
            CGPoint cpoint = _buttonBgView.contentOffset;
            cpoint.x -=70 +point.x+25;
            [_buttonBgView setContentOffset:cpoint animated:YES];
        }
    }
    
    
    
    switch (scrollView.tag) {
        case 10000:
            break;
        case 10001:
            break;
        default:
            break;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag ==10001) {
        CGPoint point = _sliderImageView.origin;
        point=CGPointMake(scrollView.contentOffset.x /340 *70 +25, point.y);
        _sliderImageView.origin = point;
    }
    
    
}

-(void)dealloc{
    RELEASE_SAFELY(_buttonsArray);
    RELEASE_SAFELY(_contentBgView);
    RELEASE_SAFELY(_buttonBgView);
    RELEASE_SAFELY(_contentsArray);
    RELEASE_SAFELY(_sliderImageView);
    [super dealloc];
}
@end
