//
//  DataService.h
//  testLanucher
//
//  Created by 佐筱猪 on 13-11-18.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
typedef void (^RequestFinishBlock)(id result);
typedef void (^RequestErrorBlock)(NSError *error);
@interface DataService : NSObject

+ (ASIHTTPRequest *)requestWithURL:(NSString *)urlstring andparams:(NSMutableDictionary *)params andhttpMethod: (NSString *)httpMethod completeBlock:(RequestFinishBlock) block;

//+ (ASIHTTPRequest *)sendImageWithURL:(NSString *)urlstring andparams:(NSMutableDictionary *)params  completeBlock:(RequestFinishBlock) block andErrorBlock:(RequestErrorBlock) errorBlock;
@end
