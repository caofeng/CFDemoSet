//
//  ZYXNumberKeyboardView.h
//
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYXKeyBoardView.h"
#import "ZYXBaseKeyboardView.h"

/**
 *  数字键盘
 *  底部 左侧: “ABC”切换到英文字母键盘
 */
@interface ZYXNumberKeyboardView : ZYXBaseKeyboardView

/**
 *  初始化数字键盘类型
 *
 *  @param frame 视图大小
 *  @param type  身份证键盘 和 数字字母键盘
 */
- (instancetype)initWithFrame:(CGRect)frame keyboardType:(ZYXKeyboardType)type;

- (void)setupWithBottomLeftButtonWithKeyBoardType:(ZYXKeyboardType)keyBoardType;

@end
