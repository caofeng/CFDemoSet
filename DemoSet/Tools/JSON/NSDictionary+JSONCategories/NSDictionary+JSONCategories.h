//
//  NSDictionary+JSONCategories.h
//
//  Created by Jandy on 4/17/14.
//

#import <Foundation/Foundation.h>


/**
 * NSDictionary扩展
 * 增加字典转成JSON字符串的方法
 */
@interface NSDictionary (JSONCategories)

/**
 * @brief 将字典转成JSON字符串
 *
 * @return 如果转换成功则返回转换得到的JSON字符串，否则返回nil
 */
- (NSString *)JSONString;

@end
