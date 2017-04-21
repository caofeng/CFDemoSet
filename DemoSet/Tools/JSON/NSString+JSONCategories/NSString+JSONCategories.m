//
//  NSString+JSONCategories.m
//  TTFM
//
//  Created by Jandy on 3/25/14.
//  Copyright (c) 2014 上海水渡石信息技术有限公司. All rights reserved.
//

#import "NSString+JSONCategories.h"


@implementation NSString (JSONCategories)

/**
 * @brief 将JSON字符串转成JSON对象
 *
 * @return 如果转换成功则返回转换得到的JSON对象，否则返回nil
 */
- (id)JSONValue {
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions
                                                  error:&error];
    
    if (error != nil) return nil;
    
    return result;
}

@end
