//
//  TenyeaBaseNavigationViewController.m
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseNavigationViewController.h"

@interface TenyeaBaseNavigationViewController ()

@end

@implementation TenyeaBaseNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBackgroundImage];
}


-(void)loadBackgroundImage{
    //    去除navigation的横线
    if ([self.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                imageView.hidden=YES;
            }
        }
    }
    UIImage *image=[UIImage imageNamed:@"nav_background7.png"];
//    [image resizableImageWithCapInsets: UIEdgeInsetsMake(0, 0, 10, 60) resizingMode: UIImageResizingModeTile];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 420, 64)];
    imageView.image=image;
//    imageView.clipsToBounds = YES;
//    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.navigationBar addSubview:imageView];
}

@end
