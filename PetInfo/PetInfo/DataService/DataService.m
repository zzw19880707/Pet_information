//
//  DataService.m
//  testLanucher
//
//  Created by 佐筱猪 on 13-11-18.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "DataService.h"

@implementation DataService
//发送异步请求
+ (ASIHTTPRequest *)requestWithURL:(NSString *)urlstring andparams:(NSMutableDictionary *)params andhttpMethod: (NSString *)httpMethod completeBlock:(RequestFinishBlock) block andErrorBlock:(RequestErrorBlock) errorBlock{
    
    //拼接url地址
    urlstring = [BASE_URL stringByAppendingString:urlstring];
    
    
    NSComparisonResult compGET =[httpMethod caseInsensitiveCompare:@"GET"];//忽略大小写比较。返回值是枚举类型的升序、降序、相同
    //处理post请求的参数
    if (compGET==NSOrderedSame) {//相同
        //用于做拼接字符串
        NSMutableString *paramsString =[NSMutableString string];
        NSArray *allKey=[params allKeys];
        for (int i=0; i<params.count; i++) {
            NSString *key=[allKey objectAtIndex:i];
            id value=[params objectForKey:key];
            [paramsString appendFormat:@"%@=%@",key,value];
            if (i<params.count-1) {
                [paramsString appendString:@"&"];
            }
        }
        //判断它是不是大于0 大于0就可以拼接
        if (paramsString.length > 0) {
            urlstring = [urlstring stringByAppendingFormat:@"?%@",paramsString];
        }
    }
    
        //设置请求url地址
        NSURL *url=[NSURL URLWithString:urlstring];
        __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        //设置超时时间
        [request setTimeOutSeconds:60];
        //设置请求方法
        [request setRequestMethod:httpMethod];
        NSComparisonResult compPost =[httpMethod caseInsensitiveCompare:@"POST"];//忽略大小写比较。返回值是枚举类型的升序、降序、相同
        //处理post请求的参数
    //处理POST请求方式
    //如果httpMethod = post 写的时候要忽略大小写
    //返回的是枚举
        if (compPost==NSOrderedSame) {//相同
            NSArray *allKey=[params allKeys];
            for (int i=0; i<params.count; i++) {
                NSString *key=[allKey objectAtIndex:i];
                
                id value=[params objectForKey:key];
                //判断是否是文件上传
                if ([value isKindOfClass:[NSData class]]) {
                    [request addData:value withFileName:@"test.png" andContentType:@"image/png" forKey:@"image"];
                }else{
                    [request addPostValue:value forKey:key];
                }
            }
        }
        
        //设置请求完成的block
    /*    [request setCompletionBlock: 会retain block
     NSData *data = request.responseData;  block  retain   request.
     这样导致循环retain。

 */
    _po(url);
    [request setCompletionBlock:^{
        NSData *data = request.responseData;
        float version = WXHLOSVersion();
        id result = nil ;
        if (version>=5.0) {
            result =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }else {//版本定位5.0以上.
//            result=[data obj]
        }
        if (block !=nil) {
            block(result);
        }        
    }];
    
    [request setFailedBlock:^{
        NSError *error = [request error];
        if(errorBlock !=nil){
            errorBlock(error);
        }
    }];
    [request startAsynchronous];

    return  request;
}
////异步上传图片
//+ (ASIHTTPRequest *)sendImageWithURL:(NSString *)urlstring andparams:(NSMutableDictionary *)params  completeBlock:(RequestFinishBlock) block andErrorBlock:(RequestErrorBlock) errorBlock{
//    //拼接url地址
//    urlstring = [BASE_URL stringByAppendingString:urlstring];
//    //设置请求url地址
//    NSURL *url=[NSURL URLWithString:urlstring];
//    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
//    //设置超时时间
//    [request setTimeOutSeconds:60];
//    //设置请求方法
//    [request setRequestMethod:@"POST"];
//    
//    //分界线的标识符
//    NSString *TWITTERFON_FORM_BOUNDARY = @"1473780983146649988";
//    
//    //设置HTTPHeader中Content-Type的值
//    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data;boundary=%@",TWITTERFON_FORM_BOUNDARY];
//    [request addRequestHeader:@"Content-Type" value:content];
//    //分界线 --AaB03x
//    NSString *MPboundary=[[NSString alloc]initWithFormat:@"\r\n--%@",TWITTERFON_FORM_BOUNDARY];
//    _po(MPboundary);
//    NSArray *allKey=[params allKeys];
//    //声明myRequestData，用来放入http body
//    NSMutableData *myRequestData=[NSMutableData data];
//    for (int i=0; i<params.count; i++) {
//        NSMutableString *body=[[NSMutableString alloc]init];
//        NSString *key=[allKey objectAtIndex:i];
//        id value=[params objectForKey:key];
//        _po([value class]);
//        //判断是否是文件上传
//        if ([value isKindOfClass:[NSData class]]) {
//            [body appendFormat:@"%@\r\n",MPboundary];
//            //声明pic字段，文件名为boris.png
//            [body appendFormat:@"Content-Disposition: form-data; name=\"userfiles\"; filename=\"upload.png\"\r\n"];
//            //声明上传文件的格式
//            [body appendFormat:@"Content-Type: image/png\r\n\r\n"];//png
//            //将body字符串转化为UTF8格式的二进制
//            [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
//
//            //将image的data加入
//            [myRequestData appendData:value];
//        }else{
//            //添加分界线，换行
//            [body appendFormat:@"%@\r\n",MPboundary];
//            //添加字段名称，换2行
//            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
//            //添加字段的值
//            [body appendFormat:@"%@\r\n",value];
//            //将body字符串转化为UTF8格式的二进制
//            [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
//        }
//        RELEASE_SAFELY(body)
//    }
//    //结束符 AaB03x--
//    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
//
//    //声明结束符：--AaB03x--
//    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
//    //加入结束符--AaB03x--
//    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
//    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [myRequestData length]]];
//    _pn([myRequestData length]);
//    _po(url);
//
//    [request setCompletionBlock:^{
//        NSData *data = request.responseData;
//        float version = WXHLOSVersion();
//        id result = nil ;
//        if (version>=5.0) {
//            result =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        }else {//版本定位5.0以上.
//            //            result=[data obj]
//        }
//        if (block !=nil) {
//            block(result);
//        }
//    }];
//    [request setFailedBlock:^{
//        NSError *error = [request error];
//        if(errorBlock !=nil){
//            errorBlock(error);
//        }
//    }];
//    [request startAsynchronous];
//    
//    return  request;
//}


- (ASIHTTPRequest *) requestWithURL:(NSString *)urlstring andparams:(NSMutableDictionary *)params andhttpMethod: (NSString *)httpMethod{
    //拼接url地址
    urlstring = [BASE_URL stringByAppendingString:urlstring];
    
    
    NSComparisonResult compGET =[httpMethod caseInsensitiveCompare:@"GET"];//忽略大小写比较。返回值是枚举类型的升序、降序、相同
    //处理post请求的参数
    if (compGET==NSOrderedSame) {//相同
        //用于做拼接字符串
        NSMutableString *paramsString =[NSMutableString string];
        NSArray *allKey=[params allKeys];
        for (int i=0; i<params.count; i++) {
            NSString *key=[allKey objectAtIndex:i];
            id value=[params objectForKey:key];
            [paramsString appendFormat:@"%@=%@",key,value];
            if (i<params.count-1) {
                [paramsString appendString:@"&"];
            }
        }
        //判断它是不是大于0 大于0就可以拼接
        if (paramsString.length > 0) {
            urlstring = [urlstring stringByAppendingFormat:@"?%@",paramsString];
        }
    }
    
    //设置请求url地址
    NSURL *url=[NSURL URLWithString:urlstring];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    //设置超时时间
    [request setTimeOutSeconds:20];
    //设置请求方法
    [request setRequestMethod:httpMethod];
    NSComparisonResult compPost =[httpMethod caseInsensitiveCompare:@"POST"];//忽略大小写比较。返回值是枚举类型的升序、降序、相同
    //处理post请求的参数
    //处理POST请求方式
    //如果httpMethod = post 写的时候要忽略大小写
    //返回的是枚举
    if (compPost==NSOrderedSame) {//相同
        NSArray *allKey=[params allKeys];
        for (int i=0; i<params.count; i++) {
            NSString *key=[allKey objectAtIndex:i];
            
            id value=[params objectForKey:key];
            //判断是否是文件上传
            if ([value isKindOfClass:[NSData class]]) {
                [request addData:value withFileName:@"test.png" andContentType:@"image/png" forKey:@"image"];
            }else{
                [request addPostValue:value forKey:key];
            }
        }
    }
    
    //设置请求完成的block
    /*    [request setCompletionBlock: 会retain block
     NSData *data = request.responseData;  block  retain   request.
     这样导致循环retain。
     
     */
    _po(url);
    [request setDelegate:self];
    [request startAsynchronous];
    return request;
}
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSData *data = request.responseData;
    id result = nil ;
    result =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [self.eventDelegate requestFinished:result];
}
- (void)requestFailed:(ASIHTTPRequest *)request{
    [self.eventDelegate requestFailed:request];

}
@end
