//
//  SendViewController.h
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-28.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SendViewController : BaseViewController<CLLocationManagerDelegate> {
    //经纬度
    float _longitude;
    float _latitude;
    UIImageView *_fullImageView;

}
@property (retain, nonatomic) IBOutlet UITextView *textView;
@property (retain, nonatomic) IBOutlet UIView *editorBar;

@property (retain,nonatomic) UIButton *imageButton;

//senddata
@property (retain,nonatomic) UIImage *sendImage;
@end
