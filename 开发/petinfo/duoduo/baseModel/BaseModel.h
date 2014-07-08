//
//  BaseModel.h
//  tabbartest
//
//  Created by 佐筱猪 on 13-10-16.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject<NSCoding>{
    
}

-(id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;

- (NSString *)cleanString:(NSString *)str;    //清除\n和\r的字符串
@end
