//
//  SendViewController.m
//  PetInfo
//
//  Created by 佐筱猪 on 13-11-28.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "SendViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface SendViewController ()

@end

@implementation SendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"分享";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    _latitude=0.0f;
//    _longitude =0.0f;
    [self _initView];
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = PetTextColor;
    [button setTitle:@"发送" forState:UIControlStateNormal];
    //    [button setImage:[UIImage imageNamed:@"navagiton_back.png"] forState:UIControlStateNormal];
    [button setTintColor:PetBackgroundColor];
    button.titleLabel.font=[UIFont systemFontOfSize:14];
    //圆角
    button.layer.cornerRadius =5;
    button.layer.masksToBounds=YES;
    button.frame = CGRectMake(0, 0, 40, 30);
    button.showsTouchWhenHighlighted = YES;
    [button addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = [backItem autorelease];
    
}
-(void)_initView{
    //显示键盘
    self.textView=[[UITextView alloc]init];
    self.textView.frame=CGRectMake(0, 0, ScreenWidth, 150);
    self.textView.backgroundColor=PetBackgroundColor;
    self.textView.font=[UIFont systemFontOfSize:14.0f];
    [self.view addSubview:self.textView];
    [self.textView  becomeFirstResponder];
    
    self.editorBar =[[UIView alloc]init];
    self.editorBar.frame=CGRectMake(0, 150, ScreenWidth, 55);
    self.editorBar.backgroundColor=PetBackgroundColor;
    [self.view addSubview:self.editorBar];
    
    
    UIButton *button=[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"compose_camerabutton_background.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted.png"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted.png"] forState:UIControlStateSelected];
    
    button.tag =100;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame=CGRectMake(70, 25, 23, 19);
    
    [self.editorBar addSubview:button];
    [button release];
    
    
}


#pragma mark 按钮事件
//缩小图片
-(void)selectImageAction:(UITapGestureRecognizer *)tapGesture{
    [_fullImageView viewWithTag:100].hidden=YES;
    
    [UIView animateWithDuration:.4 animations:^{
        _fullImageView.frame=CGRectMake(15, ScreenHeight-250, 20, 20);
    } completion:^(BOOL finished) {
        [_fullImageView removeFromSuperview];
    }];
    [UIApplication sharedApplication].statusBarHidden=NO;
    
    [self.textView becomeFirstResponder];
    
    
}

-(void)buttonAction:(UIButton *)button{
    [self Location];
    [self selectImage];
}
//上传图片和描述
-(void)sendAction{
    NSMutableDictionary *params =[[NSMutableDictionary alloc]init];
    
    [params setValue:UIImagePNGRepresentation(self.sendImage) forKey:@"image"];
    [params setValue:[[NSUserDefaults standardUserDefaults] objectForKey:user_id] forKey:@"userId"];
//    if (_latitude ==0.0f&&_longitude ==0.0f) {
//        
//    }else{
//        [params setValue:[NSNumber numberWithFloat:_longitude] forKey:@"longitude"];
//        [params setValue:[NSNumber numberWithFloat:_latitude] forKey:@"latitude"];
//    }
    [self showStaticTip:YES title:@"发送中.."];
    [DataService requestWithURL:UploadServlet andparams:params andhttpMethod:@"POST" completeBlock:^(id result) {
        [self showStaticTip:NO title:@"发送成功！"];
        [self dismissModalViewControllerAnimated:YES];
    } andErrorBlock:^(NSError *error) {
        
        [self showStaticTip:NO title:@"发送超时！"];
    }];
    
}

//删除按钮
-(void)deleteAction:(UIButton *)button{
    [_fullImageView viewWithTag:100].hidden=YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        _fullImageView.frame=CGRectMake(15, ScreenHeight-250, 20, 20);
        
    } completion:^(BOOL finished) {
        [_fullImageView removeFromSuperview];
        
    }];
    [UIApplication sharedApplication].statusBarHidden=NO;
    
    [self.textView becomeFirstResponder];
    
    //移除缩略图
    [self.imageButton removeFromSuperview];
    self.sendImage=nil;
    
    UIButton *cButton =(UIButton *)[self.editorBar viewWithTag:100];
    cButton.selected =NO;
}

//图片
-(void)selectImage{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"用户相册", nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}
//全屏按钮
-(void)imageAction:(UIButton *)button{
    if(_fullImageView==nil){
        _fullImageView =[[UIImageView alloc]init];
        _fullImageView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _fullImageView.backgroundColor=[UIColor blackColor];
        _fullImageView.userInteractionEnabled=YES;//手势.放大缩小
        _fullImageView.contentMode=UIViewContentModeScaleAspectFit;//不改变拉伸，只改变比例
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImageAction:)];
        tapGesture.numberOfTapsRequired=2;
        [_fullImageView addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        
        //创建删除按钮
        UIButton *deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton  setImage:[UIImage imageNamed:@"send_trash.png"] forState:UIControlStateNormal];
        
        deleteButton.frame=CGRectMake(280, 40, 35, 35);
        
        deleteButton.tag=100;
        [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.hidden=YES;
        [_fullImageView addSubview:deleteButton];
        [deleteButton release];
        
    }
    [self.textView resignFirstResponder];
    if(![_fullImageView superview]){
        _fullImageView.image=self.sendImage;
        [self.view.window addSubview:_fullImageView];
        
        _fullImageView.frame=CGRectMake(15,ScreenHeight-250, 20, 20);
        [UIView animateWithDuration:.4 animations:^{
            _fullImageView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        } completion:^(BOOL finished){
            [UIApplication sharedApplication].statusBarHidden=YES;
            [_fullImageView viewWithTag:100].hidden=NO;
        }];
    }
}

#pragma mark UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerControllerSourceType sourceType;
    
    
    if (buttonIndex==0) {
#warning 照片存放和汉化
        //判断是否有前置和后置摄像头
        BOOL isCamera =[UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
        if (!isCamera) {
            UIAlertView *allert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"此设备没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [allert show];
            [allert release];
            return;
        }
        //拍照
        sourceType=UIImagePickerControllerSourceTypeCamera;
        
    }else if(buttonIndex ==1 ){
        //        用户相册
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;//所有类型|||UIImagePickerControllerSourceTypeSavedPhotosAlbum可以默认文件夹。用户可自己建立
        
    }else if(buttonIndex ==2 ){
        //        取消
        return;
    }
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=sourceType;
    imagePicker.delegate=self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //如果已经有图片按钮，则隐藏、删除原有图片
    if (self.imageButton !=nil) {
        [self.imageButton setHidden:YES];
        self.imageButton = nil;
    }
    //    NSLog(@"%@",info);
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    self.sendImage=image;
    
    if(self.imageButton == nil){
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius =5;
        button.layer.masksToBounds=YES;
        
        button.frame=CGRectMake(15, 20, 25, 25);
        
        [button addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
        self.imageButton=button;
    }
    [self.imageButton setImage:image forState:UIControlStateNormal];
    UIButton *button =(UIButton *)[self.editorBar viewWithTag:100];
    button.selected= YES;
    [self.editorBar addSubview:self.imageButton];
    
    
    
    [picker dismissModalViewControllerAnimated:YES];
    //转换成data数据
    //    NSData *data = UIImageJPEGRepresentation(self.sendImage, 0.3);
    
}



#pragma mark 内存管理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_textView release];
    [_editorBar release];
    MARK;
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTextView:nil];
    [self setEditorBar:nil];
    [super viewDidUnload];
}
@end
