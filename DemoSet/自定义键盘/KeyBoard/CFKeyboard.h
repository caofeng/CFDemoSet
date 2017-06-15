//
//  CFKeyboard.h
//  CFKeyboardPro
//
//  Created by Appple on 16/3/15.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    CFKBTypeNumberPad = 1 << 0,         //纯数字
    CFKBTypeDecimalPad = 1 << 1,        //数字 + “.”
    CFKBTypeASCIICapable = 1 << 2,      //数字，字符，英文
    CFKBTypeIDNumberPad = 1 << 3        //身份证键盘
}CFKBType;

/*!
 *  @brief Dependency:Masonry framework
 */

@interface CFKeyboard : UIView

/*!
 *  @brief create safe keyboard
 *
 *  @param type kb's type
 *
 *  @return the kb's instance
 */
+ (nonnull instancetype)keyboardWithType:(CFKBType)type;

/*!
 *  @brief kb's icon logo to show user
 */
@property (nullable, nonatomic, copy) NSString *icon;

/*!
 *  @brief kb's 完成按钮 show user
 */
@property (nullable, nonatomic, copy) NSString *next;

/*!
 *  @brief kb's title to show user
 */
@property (nonatomic, nullable, copy) NSString *enterprise;

/*!
 *  @brief such as UITextField,UITextView,UISearchBar
 */
@property (nonatomic, nullable, strong) UIView *inputSource;

@end
