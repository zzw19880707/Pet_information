//
//  MyViewController.m
//  宠信
//
//  Created by tenyea on 14-7-8.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "MyViewController.h"
#import "SettingViewController.h"
#import "TenyeaBaseNavigationViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "PetModel.h"
#import "UIImageView+WebCache.h"
#import "AddPetViewController.h"
#import "AboutViewController.h"
#import "MyAskViewController.h"
#import "MyPostViewController.h"
#import "MyInfoViewController.h"
#define bgTabelViewTag 100
@interface MyViewController ()
{
    NSString *_userName;
    UITableView *_tableView;
//    顶部背景图
    UIView *_topView;
    
    NSArray *_noLoginNameArr;
    NSArray *_noLoginImageArr;
    
    NSArray *_petArr;
    
//    登陆后和未登录的背景view
    UIView *_bgView;
    
//    头像
    UIButton *_headButton;
//    用户名
    UILabel *_usernameLabel;
//    地址
    UILabel *_addressLabel;
//    性别
    UIImageView *_sexImageView;
}
@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //  初始化数据
    [self _initData];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 90, 0, 0);
    [self.view addSubview:_tableView];
//    headview
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
    _tableView.tableHeaderView = headerView;
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 70)];
    _topView.backgroundColor = [UIColor redColor];
    [headerView addSubview:_topView];

//    top的背景图
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -330, ScreenWidth, 400)];
    topImageView.image = [UIImage imageNamed:@"test.png"];
    [_topView addSubview:topImageView];

    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, _topView.height)];
    [_topView addSubview: _bgView];
    
    

    
    
//    右侧按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setTitle:@"设置" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
}
-(void)_initData{
    _noLoginNameArr = @[@[@"我的问诊",@"我的帖子",@"个人资料"],@[@"打个分,鼓励一下"],@[@"用户协议",@"关于我们"]];
    _noLoginImageArr = @[@[@"my_ask.png",@"my_dynamic.png",@"my_myInfo.png"],@[@"my_score@.png"],@[@"my_agreement.png",@"my_about.png"]];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _userName = [[NSUserDefaults standardUserDefaults] stringForKey:UD_userName_Str];
    _userName = @"1234";
    [_tableView reloadData];
//    移除所有视图
    NSArray *arr = [_bgView subviews];
    for (UIView *view in arr) {
        [view removeFromSuperview];
//        view  = ;
    }
//    判断是否登陆
    if (_userName)
    {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults ]dictionaryForKey:UD_userInfo_DIC];
#warning
        if (_headButton) {
            _headButton = nil;
        }
        _headButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 60, 60)];
        _headButton.backgroundColor = [UIColor redColor];
        _headButton.layer.masksToBounds = YES;
        _headButton.layer.cornerRadius = 30;
        [_headButton addTarget:self action:@selector(uploadHeadAction) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_headButton];

        //        白色背景图
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 25, 160, 35)];
        view.backgroundColor = [UIColor whiteColor];
        view.alpha = .7;
        [_bgView addSubview:view];
        
        if (_usernameLabel ) {
            _usernameLabel = nil;
        }
        _usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 25, 80, 20)];
        _usernameLabel.textColor = [UIColor colorWithRed:0.9 green:0.52 blue:0.13 alpha:1];
        _usernameLabel.font = [UIFont boldSystemFontOfSize:14];
        [_bgView addSubview:_usernameLabel];
        _usernameLabel.text = @"佐佐猪";
        [_usernameLabel sizeToFit];
        
        if (_sexImageView) {
            _sexImageView = nil;
        }
        _sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(110, 25, 20, 20)];
        _sexImageView.backgroundColor = [UIColor redColor];
        [_bgView addSubview:_sexImageView];
        _sexImageView.left = _usernameLabel.right + 5;
        
//        普通图标
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 30, 15)];
        imageView.image = [UIImage imageNamed:@"my_address@2x.png"];
        [view addSubview:imageView];
        
        if (_addressLabel) {
            _addressLabel = nil;
        }
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 45, 120, 15)];
        _addressLabel.textColor = [UIColor colorWithRed:0.48 green:0.4 blue:0.09 alpha:1];
        _addressLabel.font = [UIFont boldSystemFontOfSize:13];
        [_bgView addSubview:_addressLabel];
        _addressLabel.text = @"辽宁|沈阳|铁西区";
//        读取宠物信息
        _petArr = [[NSUserDefaults standardUserDefaults]arrayForKey:UD_pet_Array];
        
    }
    else
    {//未登录
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake( (ScreenWidth - 100)/2  , 0, 120, 50)];
        view.backgroundColor = [UIColor whiteColor];
        view.alpha = .7;
        [_bgView addSubview:view];
        

//        登录和注册按钮
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 59, 50)];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 100;
        [button addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(1 + 60, 0, 59, 50)];
        [button1 setTitle:@"注册" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button1.tag = 101;
        [button1 addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button1];

        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(59, 10, 2, 30)];
        line.backgroundColor = [UIColor grayColor];
        [view addSubview:line];
    }
}

#pragma mark =
#pragma mark Action 
//上传用户头像
-(void)uploadHeadAction{
    UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"马上照一张" otherButtonTitles:@"从手机相册选择", nil ];
    [as showInView:self.view];
}
-(void)settingAction{
    [self.navigationController pushViewController:[[SettingViewController alloc]init] animated:YES];
}
-(void)loginAction:(UIButton *)button{
    switch (button.tag) {
        case 100:
            [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
            break;
        case 101:
            [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
            break;
        default:
            break;
    }
}

-(void)addPetAction:(UIButton *)button{
    [self.navigationController pushViewController:[[AddPetViewController alloc]initWithPetDic:nil] animated:YES];
//    [self presentViewController:[[AddPetViewController alloc]init]  animated:YES completion:NULL];
}
#pragma mark - 
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float contentoffset_y = scrollView.contentOffset.y;
    if (contentoffset_y> 3.5 ) {
        CGPoint point = _topView.center;
        point.y =  contentoffset_y -  3.5 +120 ;
        _topView.center = point;
    }else{
        _topView.center = CGPointMake(160, 120);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float contentoffset_y = scrollView.contentOffset.y;
    if (contentoffset_y> 3.5 ) {
        CGPoint point = _topView.center;
        point.y =  contentoffset_y -  3.5 +120 ;
        _topView.center = point;
    }else{
        _topView.center = CGPointMake(160, 120);
    }
}


#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (_userName) {
        if (section == 0 ) {
            return _petArr.count == 0 ? 1:_petArr.count;
        }else{
            NSArray *arr = _noLoginNameArr[section - 1];
            return [arr count];
        }
    }
    
    NSArray *arr = _noLoginNameArr[section];
    return [arr count];
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString *myCellIdentifier = @"myCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCellIdentifier];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 7, 40, 30)];
        imageView.tag = 100;
        [cell.contentView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(90, 7, 200, 30)];
        label.tag = 101;
        label.font = [UIFont boldSystemFontOfSize: 13];
        label.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1];
        [cell.contentView addSubview:label];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if (_userName) {
        UILabel *label = (UILabel *)VIEWWITHTAG(cell.contentView, 101);
        UIImageView *imageView = (UIImageView *)VIEWWITHTAG(cell.contentView, 100);
        
        
        
        if (indexPath.section == 0 ) {
            cell.accessoryType = UITableViewCellAccessoryNone;

//            尚未有宠物
            if (_petArr.count == 0 ) {
                label.text = @"添加宠物";
                imageView.image = [UIImage imageNamed:@"my_petlogo@2x.png"];
            }//已经有宠物
            else{
                NSDictionary *dic = _petArr[indexPath.row];
                PetModel *model = [[PetModel alloc]initWithDataDic:dic];
                label.text = model.petName;
                [imageView setImageWithURL:[NSURL URLWithString:model.petHeadImage] placeholderImage:[UIImage imageNamed:@"my_petlogo@2x.png"]];
            }
            if (indexPath.row == 0 ) {
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
                button.backgroundColor = [UIColor redColor];
                [button setImage:[UIImage imageNamed:@"my_addpet@2x.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(addPetAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.accessoryView =button;
            }
            
        }else{
            label.text = _noLoginNameArr[indexPath.section-1][indexPath.row];
            imageView.image = [UIImage imageNamed:_noLoginImageArr[indexPath.section - 1][indexPath.row]];
        }
    }else{
        UILabel *label = (UILabel *)VIEWWITHTAG(cell.contentView, 101);
        label.text = _noLoginNameArr[indexPath.section][indexPath.row];
        UIImageView *imageView = (UIImageView *)VIEWWITHTAG(cell.contentView, 100);
        imageView.image = [UIImage imageNamed:_noLoginImageArr[indexPath.section][indexPath.row]];
    }
    return  cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_userName) {
        return ([_noLoginNameArr count] + 1 );
    }
    return [_noLoginNameArr count];

}
#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_userName) {
        if (indexPath.section == 0) {
            [self.navigationController pushViewController:[[AddPetViewController alloc] initWithPetDic:(_petArr.count == 0 ? nil : _petArr[indexPath.row]) ] animated:YES];
        }else if(indexPath.section == 1){
            if (indexPath.row == 0) {//我的问诊
                [self.navigationController pushViewController:[[MyAskViewController alloc]init] animated:YES];
            }else if(indexPath.row == 1){//我的帖子
                [self.navigationController pushViewController:[[MyPostViewController alloc]init] animated:YES];
            }else{//个人资料
                [self.navigationController pushViewController:[[MyInfoViewController alloc]init] animated:YES];

            }
        }else if(indexPath.section == 2){//打分
            NSString *str = [NSString stringWithFormat:
                             
                             @"itms-apps://itunes.apple.com/app/id%d",itunesappid];
            //                @"http://itunes.apple.com/us/app/%E4%B8%9C%E5%8C%97%E6%96%B0%E9%97%BB%E7%BD%91/id802739994?ls=1&mt=8"
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else{
            [self.navigationController pushViewController:[[AboutViewController alloc] initWithTitle:(indexPath.row == 0? @"用户协议":@"关于我们") andFileName:(indexPath.row == 0? @"agreement":@"about")] animated:YES];
        }
    }
}
#pragma mark ----------ActionSheet 按钮点击-------------
#pragma mark -
#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"用户点击的是第%d个按钮",buttonIndex);
    switch (buttonIndex) {
        case 0:
            //照一张
        {
            UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
            [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [imgPicker setDelegate:self];
            [imgPicker setAllowsEditing:YES];
            [self.navigationController presentViewController:imgPicker animated:YES completion:nil];
        }
            break;
        case 1:
            //搞一张
        {
            UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
            [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [imgPicker setDelegate:self];
            [imgPicker setAllowsEditing:YES];
            [self.navigationController presentViewController:imgPicker animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}
#pragma mark -
#pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    关闭navigation
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    //    获取图片
    UIImage  * image=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    image = [self scaleToSize:image size:CGSizeMake(60, 60)];
    //    如果是照相的图片。保存到本地
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {//保存到本地
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        });
    }else{
        [_headButton setImage:image forState:UIControlStateNormal];
    }
}
#pragma mark -
#pragma mark Method
//保存成功或失败
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        _po(@"保存失败");
    }else {
        [_headButton setImage:image forState:UIControlStateNormal];
    }
}

//图片缩放到指定大小尺寸
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


@end
