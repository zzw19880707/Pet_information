//
//  UtilDefine.h
//  Pet_info
//
//  Created by 佐筱猪 on 13-11-14.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#ifndef Pet_info_UtilDefine_h
#define Pet_info_UtilDefine_h




#pragma mark --------log

//打印方法名，行数
#ifdef DEBUG
#   define DLOG(fmt, ...) NSLog((@"********\n%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLOG(...)
#endif

//debug log
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#   define DLogRect(rect)  DLog(@"%s x=%f, y=%f, w=%f, h=%f", #rect, rect.origin.x, rect.origin.y,rect.size.width, rect.size.height)
#   define DLogPoint(pt) DLog(@"%s x=%f, y=%f", #pt, pt.x, pt.y)
#   define DLogSize(size) DLog(@"%s w=%f, h=%f", #size, size.width, size.height)
#   define DLogColor(_COLOR) DLog(@"%s h=%f, s=%f, v=%f", #_COLOR, _COLOR.hue, _COLOR.saturation, _COLOR.value)
#   define DLogSuperViews(_VIEW) { for (UIView* view = _VIEW; view; view = view.superview) { GBLog(@"%@", view); } }
#   define DLogSubViews(_VIEW) \
{ for (UIView* view in [_VIEW subviews]) { GBLog(@"%@", view); } }
#   else
#   define DLog(...)
#   define DLogRect(rect)
#   define DLogPoint(pt)
#   define DLogSize(size)
#   define DLogColor(_COLOR)
#   define DLogSuperViews(_VIEW)
#   define DLogSubViews(_VIEW)
#   endif

#define DOBJ(obj)  DLOG(@"%s: %@", #obj, [(obj) description])
//当前方法和行数
#define MARK    NSLog(@"********%@\nMARK: %s, %d",[self class] , __PRETTY_FUNCTION__, __LINE__)
//输出日志
#define _po(o) DLOG(@"%@", (o))
#define _pn(o) DLOG(@"%d", (o))
#define _pf(o) DLOG(@"%f", (o))
#define _ps(o) DLOG(@"CGSize: {%.0f, %.0f}", (o).width, (o).height)
#define _pr(o) DLOG(@"NSRect: {{%.0f, %.0f}, {%.0f, %.0f}}", (o).origin.x, (o).origin.x, (o).size.width, (o).size.height)






#pragma mark --------设备信息

//获取颜色
#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

//设备版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
//获取图片。效率比imagename快，因为imagename会缓存图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
//获取视图
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG] 






#pragma mark --------提示框

//弹出提示框
#define alertContent(content) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" \
message:content \
delegate:nil   \
cancelButtonTitle:@"确定" \
otherButtonTitles:nil];  \
[alert show];  \
[alert release];
#endif






#pragma mark --------字体

//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]





#pragma mark --------清除

//安全删除对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

//logo图片
#define LogoImage [UIImage imageNamed:@"logo_80x60.png"]
#define LogoImage_280x210 [UIImage imageNamed:@"logo_280x210.png"]
