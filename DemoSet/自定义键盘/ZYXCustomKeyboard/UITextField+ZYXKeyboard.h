//
//  UITextField+ZYXKeyboard.h
//
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//


#import "ZYXKeyBoardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (ZYXKeyboard)

/**
 *  自定义键盘
 *
 *  @param safeKeyBoardType 键盘类型
 */
- (void)setSafeKeyBoardType:(ZYXKeyboardType)safeKeyBoardType;

/**
 *  自定义键盘
 *
 *  @param safeKeyBoardType       键盘类型
 *  @param safeKeyBoardReturnType 返回按钮类型（下一步、完成）
 */
- (void)setSafeKeyBoardType:(ZYXKeyboardType)safeKeyBoardType
     safeKeyBoardReturnType:(ZYXKeyboardReturnType)safeKeyBoardReturnType;
 
@end


NS_ASSUME_NONNULL_END