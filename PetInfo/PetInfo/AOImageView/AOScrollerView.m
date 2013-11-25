//
//  AOScrollerView.m
//  AOImageViewDemo
//
//  Created by akria.king on 13-4-2.
//  Copyright (c) 2013年 akria.king. All rights reserved.
//

#import "AOScrollerView.h"
#define WIDTH 320
@implementation AOScrollerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
//自定义实例化方法

-(id)initWithNameArr:(NSMutableArray *)imageArr titleArr:(NSMutableArray *)titleArr height:(float)heightValue{
    self=[super initWithFrame:CGRectMake(0, 0, WIDTH, 416)];
    if (self) {
        page=0;//设置当前页为1
        
        imageNameArr = imageArr;
        titleStrArr=titleArr;
        //图片总数
        int imageCount = [imageNameArr count];
        //标题总数
        int titleCount =[titleStrArr count];
        //初始化scrollView
        imageSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, heightValue)];
        //设置sview属性
        
        imageSV.directionalLockEnabled = YES;//锁定滑动的方向
        imageSV.pagingEnabled = YES;//滑到subview的边界
        
        imageSV.showsVerticalScrollIndicator = NO;//不显示垂直滚动条
        imageSV.showsHorizontalScrollIndicator = NO;//不显示水平滚动条
        
        
        CGSize newSize = CGSizeMake(WIDTH * imageCount,  imageSV.frame.size.height);//设置scrollview的大小
        [imageSV setContentSize:newSize];
        [self addSubview:imageSV];
        //*********************************
        //添加图片视图
        for (int i=0; i<imageCount; i++) {
            NSString *str = @"";
            if (i<titleStrArr.count) {
                
                str=[titleStrArr objectAtIndex:i];
            }
            //创建内容对象
            AOImageView *imageView = [[AOImageView alloc]initWithImageName:[imageArr objectAtIndex:i] title:str x:WIDTH*i y:0 height:imageSV.frame.size.height];
            //制定AOView委托
            imageView.uBdelegate=self;
            //设置视图标示
            imageView.tag=i;
            //添加视图
            [imageSV addSubview:imageView];
        }
        //设置NSTimer
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
        
        
    }
    return self;
}
//NSTimer方法
-(void)changeView
{
    //修改页码
    if (page == 0) {
        switchDirection = rightDirection;
    }else if(page == imageNameArr.count-1){
        switchDirection = leftDirection;
    }
    if (switchDirection == rightDirection) {
        page ++;
    }else if (switchDirection == leftDirection){
        page --;
    }

    //page++;
//    //判断是否大于上线
//    if (page==imageNameArr.count) {
//        //重置页码
//        page=0;
//    }
    //设置滚动到第几页
    [imageSV setContentOffset:CGPointMake(WIDTH*page, 0) animated:YES];
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma UBdelegate
-(void)click:(int)vid{
    //调用委托实现方法
    [self.vDelegate buttonClick:vid];
}
@end
