//
//  NSString+JSONCategories.h
//  TTFM
//
//  Created by Jandy on 3/25/14.
//  Copyright (c) 2014 上海水渡石信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * NSString扩展
 * 增加字符串转成JSON对象的方法
 */
@interface NSString (JSONCategories)

/**
 * @brief 将JSON字符串转成JSON对象 
 *
 * @return 如果转换成功则返回转换得到的JSON对象，否则返回nil
 */
- (id)JSONValue;

@end
