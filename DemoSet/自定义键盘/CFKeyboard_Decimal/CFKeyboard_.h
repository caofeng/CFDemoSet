//
//  CFDecimalKeyboard.h
//  customkeyboard
//
//  Created by Mountain.Cao on 16/6/12.
//  Copyright © 2016年 Mountain.Cao All rights reserved.
//

#import <UIKit/UIKit.h>

/** 键盘高度 */
#define kCFKeyboardHeight           [UIScreen mainScreen].bounds.size.width*(201)/375.0
/** 键盘和顶部按钮高度 */
#define kCFKeyboardWithButtonHeight kCFKeyboardHeight+44

/** 键盘类型(目前就这三种)*/
typedef NS_ENUM(NSUInteger, CFKeyboardType) {
    CFKeyboardTypeDecimal,      //小数
    CFKeyboardTypeNumber,       //纯数字
    CFKeyboardTypeID,           //身份证
};

typedef void(^HandleEvent)();

NS_ASSUME_NONNULL_BEGIN

@interface CFKeyboard_ : UIView

/** 默认小数点键盘*/
+ (instancetype)keyboard;

/** 默认小数点键盘，完成动作回调*/
+ (instancetype)keyboardWithCompelement:(HandleEvent _Nullable)compelementBlock;

/** 可选键盘类型，完成动作回调*/
+ (instancetype)keyboardType:(CFKeyboardType)keyboardType compelement:(HandleEvent _Nullable)compelementBlock;

/** 可设置顶部按钮标题，默认红色背景，完成动作回调*/
+ (instancetype)keyboardType:(CFKeyboardType)keyboardType buttonTitle:(NSString * _Nullable)title buttonClick:(HandleEvent _Nullable)buttonBlock compelement:(HandleEvent _Nullable)compelementBlock;

/** 可设置顶部按钮标题的键盘，默认红色背景，设置顶部按钮字体，完成动作回调*/
+ (instancetype)keyboardType:(CFKeyboardType)keyboardType buttonTitle:(NSString * _Nullable)title buttonAttributes:(NSDictionary<NSString *,id> * _Nullable)attributes buttonClick:(HandleEvent _Nullable)buttonBlock compelement:(HandleEvent _Nullable)compelementBlock;

/** 可设置顶部按钮标题的键盘，设置按钮背景颜色，设置顶部按钮字体，完成动作回调*/
+ (instancetype)keyboardType:(CFKeyboardType)keyboardType buttonTitle:(NSString * _Nullable)title buttonAttributes:(NSDictionary<NSString *,id> * _Nullable)attributes buttonBackgroundColor:(UIColor * _Nullable)backgroundColor buttonClick:(HandleEvent _Nullable)buttonBlock compelement:(HandleEvent _Nullable)compelementBlock;


@end

NS_ASSUME_NONNULL_END
