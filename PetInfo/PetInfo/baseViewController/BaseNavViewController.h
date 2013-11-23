//
//  BaseNavViewController.h
//  tabbartest
//
//  Created by 佐筱猪 on 13-10-15.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavViewController : UINavigationController

- (void)customPushViewController:(UIViewController *)viewController;
- (void)pushViewController: (UIViewController*)controller
        animatedWithTransition: (UIViewAnimationTransition)transition;
- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition;
@end
