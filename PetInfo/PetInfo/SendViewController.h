//
//  SendViewController.h
//  PetInfo
//  发送图片及描述的页面，同时会上传坐标点。
//  Created by 佐筱猪 on 13-11-28.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "BaseViewController.h"

@interface SendViewController : BaseViewController {

    UIImageView *_fullImageView;

}
@property (retain, nonatomic) IBOutlet UITextView *textView;
@property (retain, nonatomic) IBOutlet UIView *editorBar;

@property (retain,nonatomic) UIButton *imageButton;

//senddata
@property (retain,nonatomic) UIImage *sendImage;
@end
