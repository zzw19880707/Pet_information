//
//  BaseTableView.h
//  tabbartest
//
//  Created by 佐筱猪 on 13-10-16.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView_old.h"

@class BaseTableView;
@protocol UItableviewEventDelegate <NSObject>
//可选事件
@optional
-(void)pullDown:(BaseTableView *)tableView;//下拉
-(void)pullUp:(BaseTableView *)tableView;//上拉
-(void)tableView:(BaseTableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath;//选中cell
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;//响应编辑事件
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;//设置类型
@end

@interface BaseTableView : UITableView <EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate >{
    EGORefreshTableHeaderView_old *_refreshHeaderView;
//
    BOOL _reloading;
    
    
    UIButton *_moreButton;
}
//data为空时，不显示下拉
@property(nonatomic,retain)NSArray *data;//为tabelView提供数据

@property (nonatomic,assign)BOOL refreshHeader;//是否需要下拉

@property (nonatomic,assign)BOOL isMore;//是否还有更多(下一页)
@property (nonatomic,assign) id<UItableviewEventDelegate> eventDelegate;
- (void)doneLoadingTableViewData;

//自动下拉刷新
- (void)autoRefreshData;
@end
