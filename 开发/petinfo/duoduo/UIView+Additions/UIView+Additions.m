//
//  UIView+Additions.m
//  testLanucher
//
//  Created by 佐筱猪 on 13-10-31.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)
//获取下一事件。即上一层视图的事件，直到改视图是viewcontroll为止。
-(UIViewController *)viewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }else{
            next= [next nextResponder]; 
        }
    } while (next!=nil);
    
    return nil;
}
@end
