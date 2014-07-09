//
//  MainViewController.h
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TenyeaBaseNavigationViewController.h"

@interface MainViewController : UITabBarController<UINavigationControllerDelegate>
{
    UIView *_tabbarView;//tabbar
}
-(void)setTabbarShow:(BOOL)isshow;
@end
