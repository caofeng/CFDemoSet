//
//  KeyBoardView.m
//  KeyboardTest
//
//  Created by JordanCZ on 16/1/11.
//  Copyright © 2016年 JordanCZ. All rights reserved.
//

#import "ZYXKeyBoardView.h"

#import "ZYXCharKeyboardView.h"
#import "ZYXSymbolsKeyboardView.h"
#import "ZYXNumberKeyboardView.h"
#import "ZYXSizeScale.h"
#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ZYXKeyBoardView() {
    
    CGFloat  keyTopViewHeight;
    id<UITextInput> _associateTextView;
}

/** 字符键盘 */
@property (nonatomic, strong) ZYXCharKeyboardView *vwCharBoard;
/** 特殊字符 */
@property (nonatomic, strong) ZYXSymbolsKeyboardView *vwSymbolsBoard;
/** 数字字符 */
@property (nonatomic, strong) ZYXNumberKeyboardView *vwNumberBoard;
/** 头部视图 */
@property (nonatomic, strong) UIView *topView;
/** 完成按钮 */
@property (nonatomic, strong) UIButton *doneButton;

//@property (nonatomic, strong) UIView *relatedTextView;

@end


@implementation ZYXKeyBoardView

- (id)init {

    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, scaleY(486/2.0f));
    self = [super initWithFrame:frame];
    [self setUp];
    return self;
}

- (ZYXCharKeyboardView *)vwCharBoard {
    
    if (!_vwCharBoard) {
        _vwCharBoard = [[ZYXCharKeyboardView alloc] initWithFrame:CGRectMake(0, keyTopViewHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - keyTopViewHeight)];
        _vwCharBoard.userInteractionEnabled = YES;
        
        WS(weakSelf);
        _vwCharBoard.characterPressedCompleted = ^(NSString *characterValue,ZYXKeyboardButtonType  type){
            [weakSelf keyboardButtonClick:type contentValue:characterValue];
        };
    }
    
    return _vwCharBoard;
}

- (ZYXSymbolsKeyboardView *)vwSymbolsBoard {
    
    if (_vwSymbolsBoard == nil) {
        
        _vwSymbolsBoard = [[ZYXSymbolsKeyboardView  alloc] initWithFrame:CGRectMake(0, keyTopViewHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - keyTopViewHeight)];
        
        WS(weakSelf);
        _vwSymbolsBoard.characterPressedCompleted = ^(NSString *characterValue,ZYXKeyboardButtonType  type){
            [weakSelf keyboardButtonClick:type contentValue:characterValue];
        };
    }
    
    return _vwSymbolsBoard;
}

- (ZYXNumberKeyboardView *)vwNumberBoard {
    
    if (_vwNumberBoard == nil) {
        CGRect frame = CGRectMake(0, keyTopViewHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - keyTopViewHeight);
        _vwNumberBoard = [[ZYXNumberKeyboardView  alloc] initWithFrame:frame keyboardType:self.keyboardType];
        
        WS(weakSelf);
        _vwNumberBoard.characterPressedCompleted = ^(NSString *characterValue,ZYXKeyboardButtonType  type){
            [weakSelf keyboardButtonClick:type contentValue:characterValue];
        };
    }
    
    return _vwNumberBoard;
}


- (void)setUp {
    
    WS(weakSelf);
    
    
    self.backgroundColor = [UIColor colorWithRed:208/255.0 green:213/255.0 blue:219/255.0 alpha:1];
    
    keyTopViewHeight = scaleY(38);
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, keyTopViewHeight)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.equalTo(@(keyTopViewHeight));
    }];
    
    UIImageView *topLine = [[UIImageView  alloc] init];
    
    topLine.backgroundColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1];
    [self.topView addSubview:topLine];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf.topView);
        make.height.equalTo(@(0.3));
    }];
    
//    UIImageView *bottomLine = [[UIImageView alloc] init];
//    bottomLine.backgroundColor = topLine.backgroundColor;
//    [self.topView addSubview:bottomLine];
//    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(weakSelf.topView);
//        make.height.equalTo(@(kLineHeight));
//    }];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    iconImageView.image = [UIImage imageNamed:@"keyboard_icon"];
    [self.topView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.topView).offset(10);
        make.centerY.equalTo(weakSelf.topView);
    }];
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.font = [UIFont systemFontOfSize:13];
    infoLabel.text = kSafeKeyboard;
    
    
    infoLabel.textColor = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1];
    
    [self.topView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(5);
        make.centerY.equalTo(iconImageView);
    }];
    
    self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.doneButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.doneButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    [self.doneButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    
    [self.doneButton addTarget:self action:@selector(hiddenKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.doneButton setTitle:kReturnLabel forState:UIControlStateNormal];
    [self addSubview:self.doneButton];
    [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topView);
        make.bottom.equalTo(weakSelf.topView);
        make.right.equalTo(@-10.0f);
        make.width.equalTo(@(75));
    }];
    
    //扩大完成按钮点击区域
    //[self.doneButton zyx_setEnlargeEdgeWithTop:0 right:20 bottom:0 left:20];
}

- (void)setReturnType:(ZYXKeyboardReturnType)returnType {
    
    if (returnType == ZYXKeyboardReturnTypeNext) {
        [self.doneButton setTitle:kNextLabel forState:UIControlStateNormal];
    } else {
        [self.doneButton setTitle:kReturnLabel forState:UIControlStateNormal];
    }
    _returnType = returnType;
}

- (void)setKeyboardType:(ZYXKeyboardType)keyboardType{
    
    _keyboardType = keyboardType;
}

- (void)showKeyBoard {
    
    self.vwCharBoard.hidden = YES;
    self.vwSymbolsBoard.hidden = YES;
    self.vwNumberBoard.hidden = YES;
    
    if (self.keyboardType == ZYXKeyboardTypeDefault) {
        [self addSubview:self.vwCharBoard];
        self.vwCharBoard.hidden = NO;
        
    } else if(self.keyboardType == ZYXKeyBoardTypeSpecifisSymbol){
        [self addSubview:self.vwSymbolsBoard];
        self.vwSymbolsBoard.hidden = NO;
        
    } else if (self.keyboardType == ZYXKeyboardTypeNumberDefaultPad ||
              self.keyboardType == ZYXKeyboardTypeNumberOnlyPad ||
              self.keyboardType == ZYXKeyboardTypeNumberAndDotPad ||
              self.keyboardType == ZYXKeyboardTypeNumberIDPad) {
        
        [self.vwNumberBoard setupWithBottomLeftButtonWithKeyBoardType:self.keyboardType];
        [self addSubview:self.vwNumberBoard];
        self.vwNumberBoard.hidden = NO;
    }
}

- (void)hiddenKeyBoard {
    
    if ([self.associateTextView isKindOfClass:[UITextView class]]) {
        
        [self.associateTextView insertText:@"\n"];
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.associateTextView];
        
    } else if ([self.associateTextView isKindOfClass:[UITextField class]]) {
        
        if ([[(UITextField *)self.associateTextView delegate] respondsToSelector:@selector(textFieldShouldReturn:)]) {
            [[(UITextField *)self.associateTextView delegate] textFieldShouldReturn:(UITextField *)self.associateTextView];
        }
    }
}

- (void)setAssociateTextView:(id<UITextInput>)associateTextView {
    
    if ([associateTextView isKindOfClass:[UITextView class]]) {
        [(UITextView *)associateTextView setInputView:self];
        
        /*[[NSNotificationCenter defaultCenter] addObserver:self
         selector:@selector(checkShouldEnableReturnButton:)
         name:UITextViewTextDidChangeNotification
         object:relatedTextView];*/
    } else if ([associateTextView isKindOfClass:[UITextField class]]) {
        [(UITextField *)associateTextView setInputView:self];
        /*[[NSNotificationCenter defaultCenter] addObserver:self
         selector:@selector(checkShouldEnableReturnButton:)
         name:UITextFieldTextDidChangeNotification
         object:relatedTextView];*/
    }
    
    _associateTextView = associateTextView;
    [self showKeyBoard];
}

- (id<UITextInput>)associateTextView {
    
    return _associateTextView;
}

- (BOOL)enableInputClicksWhenVisible {
    
    return YES;
}

- (void)characterPressedValue:(NSString *)character {
    
    if ([self.associateTextView isKindOfClass:[UITextView class]]) {
        [self.associateTextView insertText:character];
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.associateTextView];
        
    } else if ([self.associateTextView isKindOfClass:[UITextField class]]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.associateTextView];
        UITextField *textField = (UITextField *)self.associateTextView;
        
        if ([textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            if ([textField.delegate textField:textField
                shouldChangeCharactersInRange:[self selectedRangeInTextField:textField]
                            replacementString:character]) {
                
                [self.associateTextView insertText:character];
            }
        }
    }
}

- (NSRange)selectedRangeInTextField:(UITextField *)textField {
    
    UITextPosition *beginning = textField.beginningOfDocument;
    
    UITextRange *selectedRange = textField.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    NSInteger location = [textField offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [textField offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void)deleteCharacter {
    
    [self.associateTextView deleteBackward];
    
    if ([self.associateTextView isKindOfClass:[UITextView class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.associateTextView];

    } else if ([self.associateTextView isKindOfClass:[UITextField class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.associateTextView];
    }
}

- (void)spaceCharacter {
    
    [[UIDevice currentDevice] playInputClick];
    
    if ([self.associateTextView isKindOfClass:[UITextView class]]) {
        [self.associateTextView insertText:@" "];
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.associateTextView];
        
    } else if ([self.associateTextView isKindOfClass:[UITextField class]]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.associateTextView];
        UITextField *textField = (UITextField *)self.associateTextView;
        
        if ([textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            
            if ([textField.delegate textField:textField
                shouldChangeCharactersInRange:[self selectedRangeInTextField:textField]
                            replacementString:@" "]) {
                
                [self.associateTextView insertText:@" "];
            }
        }
    }
}

- (void)keyboardButtonClick:(ZYXKeyboardButtonType)type contentValue:(NSString *)characterValue {
    
    if (type == ZYXKeyBoardButtonCharacter || type == ZYXKeyBoardButtonSymbols || type == ZYXKeyBoardButtonNumberPad) {
        //字符 数字  特殊字符
        [self characterPressedValue:characterValue];
        
    } else if(type == ZYXKeyBoardButtonDelete) {
        //删除
        [self deleteCharacter];
        
    } else if(type == ZYXKeyBoardButtonSpace) {
        //空格
        [self spaceCharacter];
        
    } else if(type == ZYXKeyBoardButtonNumberPadSwitch) {
        //数字键盘
        self.keyboardType = ZYXKeyboardTypeNumberDefaultPad;
        [self showKeyBoard];
        
    } else if(type == ZYXKeyBoardButtonSymbolsSwitch) {
        //特殊符号切换
        self.keyboardType = ZYXKeyBoardTypeSpecifisSymbol;
        [self showKeyBoard];
        
    } else if(type == ZYXKeyBoardButtonCharacterSwitch) {
        //字符键盘切换
        self.keyboardType = ZYXKeyboardTypeDefault;
        [self showKeyBoard];
    }
}

- (void)addPopupToButton:(UIButton *)button {
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 52, 60)];
    [textLabel setFont:[UIFont systemFontOfSize:22]];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    [textLabel setAdjustsFontSizeToFitWidth:YES];
    [textLabel setText:button.titleLabel.text];
    
    UIImageView *keyPopImageView = nil;
    keyPopImageView.layer.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0].CGColor;
    keyPopImageView.layer.shadowOffset = CGSizeMake(0, 2.0);
    keyPopImageView.layer.shadowOpacity = 0.30;
    keyPopImageView.layer.shadowRadius = 3.0;
    keyPopImageView.clipsToBounds = NO;
    [keyPopImageView addSubview:textLabel];
    
    [button addSubview:keyPopImageView];
}

@end
