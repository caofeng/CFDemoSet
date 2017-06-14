//
//  ZYXCharKeyboardView.m
//
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//


#import "ZYXCharKeyboardView.h"
#import "ZYXKeyButton.h"
#import "ZYXSizeScale.h"

#define kChar @[@"q", @"w", @"e", @"r", @"t", @"y", @"u", @"i", @"o", @"p", @"a", @"s", @"d", @"f", @"g", @"h", @"j", @"k", @"l", @"z", @"x", @"c", @"v", @"b", @"n", @"m"]   //小写字符


@interface ZYXCharKeyboardView()<ZYXKeyboardKeyButtonDelegate>

/** "Shift大写切换"按键 */
@property (nonatomic, strong) UIButton *shiftButton;
/** "Alt切换"按键 */
@property (nonatomic, strong) UIButton *altButton;
/** "删除"按键 */
@property (nonatomic, strong) UIButton *deleteButton;
/** "空格"按键 */
@property (nonatomic, strong) UIButton *spaceButton;
/** "特殊字符"按键 */
@property (nonatomic, strong) UIButton *symbolsButton;

/** 是否启用大写 */
@property (nonatomic, assign) BOOL shifted;

@end


@implementation ZYXCharKeyboardView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self charInit];
    }
    
    return self;
}

//初始化字符
- (void)charInit {
    
    CGFloat buttonHeight = kButtonHeight;
    CGRect frame = CGRectMake(scaleX(2.5), scaleY(5), kButtonWidth, kButtonHeight);
    CGFloat space = scaleX(2.5); //左右间隔
    CGFloat verticalY = kVerticalY;
    
    //按钮背景
    UIImage *keyboardImg = [[UIImage imageNamed:@"keyboard_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 11)
                                                                                   resizingMode:UIImageResizingModeStretch];
    UIImage *keyboardImg_sel = [[UIImage imageNamed:@"keyboard_button_s"] resizableImageWithCapInsets:UIEdgeInsetsMake(9, 9, 10, 11)
                                                                                         resizingMode:UIImageResizingModeStretch];
    
    UIImage *keyboardalt_nor = [[UIImage imageNamed:@"keyboard_alt"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 38, 15, 40)
                                                                                    resizingMode:UIImageResizingModeStretch];
    UIImage *keyboardalt_sel = [[UIImage imageNamed:@"keyboard_alt_h"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 38, 15, 40)
                                                                                      resizingMode:UIImageResizingModeStretch];
    
    for (int i = 0; i< self.charArrayList.count; i++) {
        ZYXKeyButton *btnTmp = [[ZYXKeyButton  alloc] init]; 
        btnTmp.frame = frame;
        btnTmp.delegate = self;
        UIImageView *buttonImgView = [[UIImageView alloc] initWithImage:keyboardImg];
        buttonImgView.frame = frame;
        buttonImgView.userInteractionEnabled = NO;
        [self addSubview:buttonImgView];
        
        frame.origin.x  = frame.origin.x + frame.size.width + scaleX(kVerticalX);
        btnTmp.titleLabel.text = [self.charArrayList objectAtIndex:i];
        [self addSubview:btnTmp];
        [self.buttonList addObject:btnTmp];
 
        if ((i + 1) == 10) {
            //第二行
            frame.origin.x = scaleX(38/2.0f);
            frame.origin.y = frame.origin.y + frame.size.height + verticalY;
        }
        else if((i +1) == 19){
            //第三行
            frame.origin.x = scaleX(104/2.0f);
            frame.origin.y = frame.origin.y + frame.size.height + verticalY;
            
            //删除按钮
            _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _deleteButton.frame = CGRectMake(self.frame.size.width - kOtherButtonWidth - space, frame.origin.y, kOtherButtonWidth, frame.size.height);
            [_deleteButton setBackgroundImage:[UIImage imageNamed:@"keyboard_delete"] forState:UIControlStateNormal];
            [_deleteButton setBackgroundImage:[UIImage imageNamed:@"keyboard_delete_h"] forState:UIControlStateHighlighted];
            [_deleteButton setBackgroundImage:[UIImage imageNamed:@"keyboard_delete_h"] forState:UIControlStateSelected];
            [_deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
            UILongPressGestureRecognizer  *longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteLongPressed:)];
            longPressed.minimumPressDuration = 0.5f;
            [self addSubview:_deleteButton];
            [_deleteButton addGestureRecognizer:longPressed];
            
            //大小写
            _shiftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _shiftButton.frame = CGRectMake(scaleX(space), frame.origin.y, kOtherButtonWidth, buttonHeight);
            [_shiftButton setBackgroundImage:keyboardImg_sel forState:UIControlStateNormal];
            [_shiftButton setImage:[UIImage imageNamed:@"keyboard_uppercase"] forState:UIControlStateNormal];
            [_shiftButton addTarget:self action:@selector(shiftPressedClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_shiftButton];
        }
    }
    
    //Alt 空格 和字符
    frame.origin.x = space;
    frame.origin.y = frame.origin.y + frame.size.height + verticalY;
    CGFloat  buttonWidth = scaleX(148/2.0f);
    //80  39
    
    _altButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _altButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    _altButton.frame = CGRectMake(space, frame.origin.y, buttonWidth, buttonHeight);
    [_altButton setTitle:kAltLabel forState:UIControlStateNormal];
    [_altButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_altButton setBackgroundImage:keyboardalt_nor forState:UIControlStateNormal];
    [_altButton setBackgroundImage:keyboardalt_sel forState:UIControlStateHighlighted];
    [_altButton addTarget:self action:@selector(numberButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_altButton];
    
    //空格
    _spaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _spaceButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    _spaceButton.frame = CGRectMake(_altButton.frame.origin.x + _altButton.frame.size.width + 5, frame.origin.y, (self.frame.size.width - buttonWidth * 2 - space*2 - scaleX(10)), buttonHeight);
//    [_spaceButton setImage:[UIImage imageNamed:@"keyboard_space"] forState:UIControlStateNormal];
    
    [_spaceButton setTitle:@"空格" forState:UIControlStateNormal];
    
    [_spaceButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    
    [_spaceButton setBackgroundImage:keyboardalt_sel forState:UIControlStateHighlighted];
    [_spaceButton addTarget:self action:@selector(spaceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_spaceButton setBackgroundImage:keyboardImg forState:UIControlStateNormal];
    [self addSubview:_spaceButton];
    
    _symbolsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _symbolsButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _symbolsButton.frame = CGRectMake(_spaceButton.frame.origin.x + _spaceButton.frame.size.width + 5, frame.origin.y, buttonWidth, buttonHeight);
    [_symbolsButton addTarget:self action:@selector(symbolsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_symbolsButton setTitle:@"#+=" forState:UIControlStateNormal];
    [_symbolsButton setBackgroundImage:[UIImage imageNamed:@"keyboard_alt"] forState:UIControlStateNormal];
    [_symbolsButton setBackgroundImage:[UIImage imageNamed:@"keyboard_alt_h"] forState:UIControlStateHighlighted];
    [self addSubview:_symbolsButton];
}

- (NSMutableArray *)getCharacterList {
    
    return [[NSMutableArray alloc] initWithArray:kChar];
}

- (ZYXNumberViewImage)popUpToButtonPosition:(ZYXKeyButton *)button {
    
    ZYXNumberViewImage  popNumberType = ZYXNumberViewImageInner;
    if (button == [self.buttonList objectAtIndex:0]) {
        popNumberType = ZYXNumberViewImageLeft;
        
    } else if(button == [self.buttonList objectAtIndex:9]) {
        
        popNumberType = ZYXNumberViewImageRight;
    }
    
    return popNumberType;
}

- (void)characterPressed:(NSString *)charValue {
    
    if (self.characterPressedCompleted) {
        self.characterPressedCompleted(charValue,ZYXKeyBoardButtonCharacter);
    }
}

//大小写切换
- (void)shiftPressedClick:(id)sender {
    
    _shifted = !self.shifted;
    [self resetCharUpperCaseWithShifted:self.shifted];
    
    UIImage *keyboardImg = [[UIImage imageNamed:@"keyboard_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 11)
                                                                                   resizingMode:UIImageResizingModeStretch];
    
    UIImage *keyboardalt_sel = [[UIImage imageNamed:@"keyboard_button_s"] resizableImageWithCapInsets:UIEdgeInsetsMake(9, 9, 10, 11)
                                                                                         resizingMode:UIImageResizingModeStretch];
    
    if (_shifted) {
        [_shiftButton setImage:[UIImage imageNamed:@"keyboard_uppercase_h"]
                      forState:UIControlStateNormal];
        [_shiftButton setBackgroundImage:keyboardImg
                                forState:UIControlStateNormal];
        
    } else {
        [_shiftButton setImage:[UIImage imageNamed:@"keyboard_uppercase"]
                      forState:UIControlStateNormal];
        [_shiftButton setBackgroundImage:keyboardalt_sel
                                forState:UIControlStateNormal];
    }
}

/**
 *  重置按钮字符  大小写
 *
 *  @param isShift YES:大写  NO:小写
 */
- (void)resetCharUpperCaseWithShifted:(BOOL)isShift {
    
    [self.buttonList enumerateObjectsUsingBlock:^(ZYXKeyButton *  _Nonnull  obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *contentValue = obj.titleLabel.text;
        if (isShift) {
            obj.titleLabel.text = [contentValue uppercaseString];
        }
        else{
            obj.titleLabel.text = [contentValue lowercaseString];
        }
    }]; 
}

//删除字符
- (void)deleteClick:(id)sender {
    
    if (self.characterPressedCompleted) {
        self.characterPressedCompleted(nil,ZYXKeyBoardButtonDelete);
    }
}

- (void)deleteLongPressed:(UILongPressGestureRecognizer *)sender {
    
    [super deleteLongPressed:sender];
    
    if (sender.state == UIGestureRecognizerStateBegan ||
        sender.state == UIGestureRecognizerStateChanged) {
        _deleteButton.selected = YES;
        
    } else {
        _deleteButton.selected = NO;
    }
}

//空格按钮
- (void)spaceButtonClick:(id)sender {
    
    if (self.characterPressedCompleted) {
        self.characterPressedCompleted(nil, ZYXKeyBoardButtonSpace);
    }
}

//数字按钮切换
- (void)numberButtonClick:(id)sender {
    
    if (self.characterPressedCompleted) {
        self.characterPressedCompleted(nil, ZYXKeyBoardButtonNumberPadSwitch);
    }
}

//特殊符号
- (void)symbolsButtonClick:(id)sender {
    
    if (self.characterPressedCompleted) {
        self.characterPressedCompleted(nil, ZYXKeyBoardButtonSymbolsSwitch);
    }
}

 
@end
