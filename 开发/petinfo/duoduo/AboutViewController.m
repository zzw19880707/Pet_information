//
//  AboutViewController.m
//  东北新闻网
//
//  Created by tenyea on 13-12-23.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
{
    NSString *_fileName;
}
@end

@implementation AboutViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTitle:(NSString *)title andFileName:(NSString *)fileName{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = title;
    }
    return self;
}
-(id)initWithTitle:(NSString *)title andFileName:(NSString *)fileName{
    self = [super init];
    if (self) {
        self.title = title;
        _fileName = fileName;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *aboutPath = [[NSBundle mainBundle] pathForResource: _fileName ofType: @"html"];
    NSError *error = nil;
    NSStringEncoding encoding;
    NSString *htmlString = [NSString stringWithContentsOfFile: aboutPath usedEncoding: &encoding error: &error];
//    添加版本号
    NSArray *array = [htmlString componentsSeparatedByString:@"</BODY>"];
    NSString *curversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *centerString = [NSString stringWithFormat:@"<center>Version %@</center>",curversion];
    NSString *newhtmlString = [array componentsJoinedByString:centerString];
    [_webView loadHTMLString: newhtmlString baseURL: nil];
    
}

@end
