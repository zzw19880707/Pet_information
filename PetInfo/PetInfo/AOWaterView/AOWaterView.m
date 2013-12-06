//
//  AOWaterView.m
//  AOWaterView
//
//  Created by akria.king on 13-4-10.
//  Copyright (c) 2013年 akria.king. All rights reserved.
//

#import "AOWaterView.h"
#import "ImageWallModel.h"
#define Screen_WIDTH 320/3
@implementation AOWaterView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//初始化视图
-(id)initWithDataArray:(NSMutableArray *)array{
    
    self=[super initWithFrame:CGRectMake(0, 0, 320, ScreenHeight -10-44-24-44)];
    if (self) {
        [self initProperty];//初始化参数
        for (int i=0; i<array.count; i++) {
            if (i/3>0&&i%3==0) {
                row++;
            }
            ImageWallModel *data = [array objectAtIndex:i];
           
            //如果是第一行
            if (row==1) {
                switch (i%3) {
                    case 0:
                        
                        [self addMessView:lower DataInfo:data];
                      
                        break;
                    case 1:
                        
                        [self addMessView:lower DataInfo:data];

                        break;
                    case 2:
                        
                        [self addMessView:lower DataInfo:data];
                        
                        break;
                    default:
                        break;
                }

            }else{
                
                [self addMessView:lower DataInfo:data];
                
            }
            //重新判断最高和最低view
            [self getHViewAndLView];


        }
        //添加scrollView
        [self setContentSize:CGSizeMake(320, highValue)];
        [self addSubview:v1];
        [self addSubview:v2];
        [self addSubview:v3];
        
        
      
    

    }
    return self;
}
//初始化参数
-(void)initProperty{
    row =1;
    //初始化第一列视图
    v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_WIDTH, 0)];
    //初始化第二列视图
    v2 = [[UIView alloc]initWithFrame:CGRectMake(Screen_WIDTH, 0, Screen_WIDTH, 0)];
   //初始化第三列视图
    v3 = [[UIView alloc]initWithFrame:CGRectMake( Screen_WIDTH*2,0, Screen_WIDTH, 0)];
   
 //初始化最高视图
    higher =1;
    //初始化最低视图
    lower=1;
    highValue=1;
 

}

//向视图添加MessView
-(void)addMessView:(int)lValue DataInfo:(ImageWallModel *)data{
       MessView *mView=nil;
    float hValue=0;
    switch (lValue) {
        case 1:
            // 创建内容视图
            mView= [[MessView alloc]initWithData:data yPoint:v1.frame.size.height];
            hValue=mView.frame.size.height;
            _po(mView.dataInfo);

            v1.frame=CGRectMake(v1.frame.origin.x, v1.frame.origin.y, Screen_WIDTH, v1.frame.size.height+hValue);
            [v1 addSubview:mView];
           
            break;
        case 2:
            // 创建内容视图
            mView= [[MessView alloc]initWithData:data yPoint:v2.frame.size.height];
           hValue=mView.frame.size.height;
            v2.frame=CGRectMake(v2.frame.origin.x, v2.frame.origin.y, Screen_WIDTH, v2.frame.size.height+hValue);
            [v2 addSubview:mView];
         
            break;
        case 3:
            // 创建内容视图
            mView= [[MessView alloc]initWithData:data yPoint:v3.frame.size.height];
            hValue=mView.frame.size.height;
            v3.frame=CGRectMake(v3.frame.origin.x, v3.frame.origin.y, Screen_WIDTH, v3.frame.size.height+hValue);
            [v3 addSubview:mView];
         
            break;
            
        default:
            break;
    }
    mView.idelegate =self;
    _po(data.des);
}
-(void)getHViewAndLView{
   

    if (v1.frame.size.height>highValue) {
        highValue=v1.frame.size.height;
        higher=1;
    }else if(v2.frame.size.height>highValue) {
        highValue=v2.frame.size.height;
        higher=2;
    }else if(v3.frame.size.height>highValue) {
        highValue=v3.frame.size.height;
        higher=3;
    }
    float v1Height=v1.frame.size.height;
    float v2Height=v2.frame.size.height;
    float v3Height=v3.frame.size.height;
    if (v1Height<v2Height) {
        if (v1Height<v3Height) {
            lower=1;
        }else{
            lower=3;
        }
    }else{
        if (v2Height<v3Height) {
            lower=2;
        }else{
            lower=3;
        }
    }
    
      }

//加载数据
-(void)getNextPage:(NSMutableArray *)array
{
    for (int i=0; i<array.count; i++) {
        if (i/3>0&&i%3==0) {
            row++;
        }
        ImageWallModel *data = (ImageWallModel*)[array objectAtIndex:i];
           
            
      
        [self addMessView:lower DataInfo:data];
       
        //重新判断最高和最低view
        [self getHViewAndLView];
    }
    //添加scrollView
    [self setContentSize:CGSizeMake(320, highValue)];
}

-(void)refreshView:(NSMutableArray *)array{
    [v1 removeFromSuperview];
    [v2 removeFromSuperview];
    [v3 removeFromSuperview];
    v1=nil;
    v2=nil;
    v3=nil;
    row =1;
    [self initProperty];//初始化参数
    for (int i=0; i<array.count; i++) {
        if (i/3>0&&i%3==0) {
            row++;
        }
        ImageWallModel *data = [array objectAtIndex:i];
        
        //如果是第一行
        if (row==1) {
            switch (i%3) {
                case 0:
                    
                    [self addMessView:lower DataInfo:data];
                    
                    break;
                case 1:
                    
                    [self addMessView:lower DataInfo:data];
                    
                    break;
                case 2:
                    
                    [self addMessView:lower DataInfo:data];
                    
                    break;
                default:
                    break;
            }
            
        }else{
            
            [self addMessView:lower DataInfo:data];
            
        }
        //重新判断最高和最低view
        [self getHViewAndLView];
        
        
    }

    //添加scrollView
    [self setContentSize:CGSizeMake(320, highValue)];
    [self addSubview:v1];
    [self addSubview:v2];
    [self addSubview:v3];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark 按钮事件
//点击图片按钮事件
-(void)click:(ImageWallModel *)data{
    _po(data.des);
}
@end
