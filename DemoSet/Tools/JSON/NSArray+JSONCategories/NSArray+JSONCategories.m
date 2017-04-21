//
//  NSArray+JSONCategories.m
//
//  Created by Jandy on 4/17/14.
//

#import "NSArray+JSONCategories.h"


@implementation NSArray (JSONCategories)

/**
 * @brief 将数组转成JSON字符串
 *
 * @return 如果转换成功则返回转换得到的JSON字符串，否则返回nil
 */
- (NSString *)JSONString {
    
    NSString *JSONString = nil;
    NSError* error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:kNilOptions
                                                     error:&error];
    if (data != nil && error == nil) {
        JSONString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return JSONString;
}

@end
