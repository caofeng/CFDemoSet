//
//  UITextField+ZYXKeyboard.m
//
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//


#import "UITextField+ZYXKeyboard.h"

@implementation UITextField (ZYXKeyboard)

- (void)setSafeKeyBoardType:(ZYXKeyboardType)safeKeyBoardType {
    
    ZYXKeyBoardView *keyboardCustom = [[ZYXKeyBoardView alloc] init];
    keyboardCustom.keyboardType = safeKeyBoardType;
    [keyboardCustom setAssociateTextView:self];
}

- (void)setSafeKeyBoardType:(ZYXKeyboardType)safeKeyBoardType
     safeKeyBoardReturnType:(ZYXKeyboardReturnType)safeKeyBoardReturnType {
    
    ZYXKeyBoardView *keyboardCustom = [[ZYXKeyBoardView alloc] init];
    keyboardCustom.keyboardType = safeKeyBoardType;
    keyboardCustom.returnType = safeKeyBoardReturnType;
    [keyboardCustom setAssociateTextView:self];
}

@end
