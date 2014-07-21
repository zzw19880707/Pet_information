//
//  AboutViewController.h
//  东北新闻网
//
//  Created by tenyea on 13-12-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "TenyeaBaseViewController.h"

@interface AboutViewController : TenyeaBaseViewController{

    IBOutlet UIWebView *_webView;
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTitle:(NSString *)title andFileName:(NSString *)fileName;
-(id)initWithTitle:(NSString *)title andFileName:(NSString *)fileName;
@end
