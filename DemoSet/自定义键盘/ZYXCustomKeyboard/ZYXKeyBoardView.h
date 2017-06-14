//
//  KeyBoardView.h
//  KeyboardTest
//
//  Created by JordanCZ on 16/1/11.
//  Copyright © 2016年 JordanCZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZYXKeyBoardTypeSpecifisSymbol,   //特殊符号键盘
    ZYXKeyboardTypeDefault,          //默认字符键盘
    ZYXKeyboardTypeNumberDefaultPad, //数字+字符键盘
    ZYXKeyboardTypeNumberOnlyPad,    //纯数字键盘
    ZYXKeyboardTypeNumberAndDotPad,  //数字+小数点键盘
    ZYXKeyboardTypeNumberIDPad,      //身份证键盘
} ZYXKeyboardType;

typedef enum : NSUInteger {
    ZYXKeyBoardButtonDelete,          //删除
    ZYXKeyBoardButtonCharacter,       //字符
    ZYXKeyBoardButtonSpace,           //空格
    ZYXKeyBoardButtonNumberPad,       //数字键盘
    ZYXKeyBoardButtonNumberPadSwitch, //数字切换
    ZYXKeyBoardButtonCharacterSwitch, //字符切换
    ZYXKeyBoardButtonSymbolsSwitch,   //特殊符号切换
    ZYXKeyBoardButtonSymbols          //特殊符号
} ZYXKeyboardButtonType;

typedef enum : NSUInteger {
    ZYXKeyboardReturnTypeFinish,    //完成
    ZYXKeyboardReturnTypeNext       //下一步
} ZYXKeyboardReturnType;



#define kAltLabel     @"123"
#define kReturnLabel  @"完 成"
#define kSafeKeyboard @"中业兴融安全键盘"

#define kNextLabel    @"下一个"
#define kSpaceLabel   @"空  格"
#define kCharacterLabel  @"ABC"

#define kVerticalY   scaleY(13)
#define kVerticalX   6
#define kButtonWidth scaleX(26)
#define kButtonHeight scaleY(79/2.0f)

#define kOtherButtonWidth  scaleX(72/2.0f)

/**
 *  自定义键盘
 */
@interface ZYXKeyBoardView : UIView<UIInputViewAudioFeedback>

@property (strong, nonatomic) UIImageView *keyboardBackground; //背景颜色
@property (assign, nonatomic) ZYXKeyboardType keyboardType;//键盘类型
@property (assign, nonatomic) ZYXKeyboardReturnType returnType; //返回类型

@property (strong, nonatomic) id<UITextInput> associateTextView;

@end
