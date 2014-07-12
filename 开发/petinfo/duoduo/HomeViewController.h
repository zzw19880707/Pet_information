//
//  HomeViewController.h
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import "XLCycleScrollView.h"
@interface HomeViewController : TenyeaBaseViewController<XLCycleScrollViewDatasource,XLCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    //轮播图
    UIPageControl *pageControl;
    UIView *view;
}
@end
