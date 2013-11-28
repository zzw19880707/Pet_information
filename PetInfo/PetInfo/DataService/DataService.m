//
//  DataService.m
//  testLanucher
//
//  Created by 佐筱猪 on 13-11-18.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "DataService.h"

@implementation DataService
+ (ASIHTTPRequest *)requestWithURL:(NSString *)urlstring andparams:(NSMutableDictionary *)params andhttpMethod: (NSString *)httpMethod completeBlock:(RequestFinishBlock) block{
    
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
                    [request addData:value forKey:key];
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
    [request startAsynchronous];

    return  request;
}
@end
