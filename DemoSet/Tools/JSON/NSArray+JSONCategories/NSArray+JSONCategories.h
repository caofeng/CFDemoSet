//
//  NSArray+JSONCategories.h
//
//  Created by Jandy on 4/17/14.
//

#import <Foundation/Foundation.h>

/**
 * NSArray扩展
 * 增加数组转成JSON字符串的方法
 */
@interface NSArray (JSONCategories)

/**
 * @brief 将数组转成JSON字符串
 *
 * @return 如果转换成功则返回转换得到的JSON字符串，否则返回nil
 */
- (NSString *)JSONString;

@end
