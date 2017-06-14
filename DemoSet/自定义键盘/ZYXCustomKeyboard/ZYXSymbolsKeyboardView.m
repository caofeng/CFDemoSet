//
//  ZYXSymbolsKeyboardView.m
//
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "ZYXSymbolsKeyboardView.h"
#import "ZYXKeyButton.h"
#import "ZYXSizeScale.h"

#define kSymbolsChar @[@"!", @"@", @"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"'",@"\"",@"=",@"_",@":",@";",@"?",@"~",@"|",@"•",@"+",@"-",@"\\",@"/",@"[",@"]",@"{",@"}",@",",@".",@"<",@">",@"`",@"£",@"¥"]   //小写字符

 //• ･ .  ¥ £ •


@interface ZYXSymbolsKeyboardView() <ZYXKeyboardKeyButtonDelegate>

/** "删除"按钮 */
@property (strong, nonatomic) UIButton *deleteButton;
/** "Alt切换"按钮 */
@property (strong, nonatomic) UIButton *altButton;
/** 字符切换按钮 */
@property (strong, nonatomic) UIButton *characterButton;

@end


@implementation ZYXSymbolsKeyboardView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self symbolsInit];
    }
    
    return self;
}

- (void)symbolsInit {
    
    CGFloat buttonHeight = kButtonHeight;
    CGRect frame = CGRectMake(scaleX(2.5), scaleY(5), kButtonWidth, kButtonHeight);
    CGFloat space = scaleX(4); //左右间隔
    CGFloat verticalY = kVerticalY;
    
    //按钮背景
    UIImage *keyboardImg = [[UIImage imageNamed:@"keyboard_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 11)
                                                                                    resizingMode:UIImageResizingModeStretch];
    for (int i = 0; i< self.charArrayList.count; i++) {
        
        ZYXKeyButton *btnTmp = [[ZYXKeyButton alloc] init];
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
            frame.origin.x = scaleX(2.5);
            frame.origin.y = frame.origin.y + frame.size.height + verticalY;
            
        } else if((i +1) == 20) {
            
            //第三行
            frame.origin.x = scaleX(12);
            frame.origin.y = frame.origin.y + frame.size.height + verticalY;
            
            //删除按钮
            _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _deleteButton.frame = CGRectMake(self.frame.size.width - kOtherButtonWidth - scaleX(10), frame.origin.y, kOtherButtonWidth, frame.size.height);
            [_deleteButton setBackgroundImage:[UIImage imageNamed:@"keyboard_delete"] forState:UIControlStateNormal];
            [_deleteButton setBackgroundImage:[UIImage imageNamed:@"keyboard_delete_h"] forState:UIControlStateHighlighted];
            [_deleteButton setBackgroundImage:[UIImage imageNamed:@"keyboard_delete_h"] forState:UIControlStateSelected];
            [_deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
            UILongPressGestureRecognizer  *longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteLongPressed:)];
            longPressed.minimumPressDuration = 0.5f;
            [self addSubview:_deleteButton];
            [_deleteButton addGestureRecognizer:longPressed];
            
        } else if((i +1) == 28) {
            //第四行
            frame.origin.x = scaleX(84/2.0f + 2.5 + kVerticalX);
            frame.origin.y = frame.origin.y + frame.size.height + verticalY;
        }
    }
    
    //Alt   和字符
    CGFloat buttonWidth = scaleX(84/2.0f);
    UIImage *keyboardalt_nor = [[UIImage imageNamed:@"keyboard_alt"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 35, 15,38)
                                                                                    resizingMode:UIImageResizingModeStretch];
    UIImage *keyboardalt_sel = [[UIImage imageNamed:@"keyboard_alt_h"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 38, 15, 40)
                                                                                      resizingMode:UIImageResizingModeStretch];
    
    _altButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _altButton.titleLabel.font = [UIFont systemFontOfSize:18];
    _altButton.frame = CGRectMake(space, frame.origin.y, buttonWidth, buttonHeight);
    [_altButton setTitle:kAltLabel forState:UIControlStateNormal];
    [_altButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_altButton setBackgroundImage:keyboardalt_nor forState:UIControlStateNormal];
    [_altButton setBackgroundImage:keyboardalt_sel forState:UIControlStateHighlighted];
    [_altButton addTarget:self action:@selector(numberButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_altButton];
    
    //字符
    _characterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _characterButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _characterButton.frame = CGRectMake(self.frame.size.width - buttonWidth - space, frame.origin.y, buttonWidth, buttonHeight);
    [_characterButton setTitle:kCharacterLabel forState:UIControlStateNormal];
    [_characterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_characterButton setBackgroundImage:[UIImage imageNamed:@"keyboard_alt"] forState:UIControlStateNormal];
    [_characterButton setBackgroundImage:[UIImage imageNamed:@"keyboard_alt_h"] forState:UIControlStateHighlighted];
    [_characterButton addTarget:self action:@selector(characterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_characterButton];
}

- (NSMutableArray *)getCharacterList {
    
    return [[NSMutableArray alloc] initWithArray:kSymbolsChar];
}

- (ZYXNumberViewImage)popUpToButtonPosition:(UIButton *)button {
    
    ZYXNumberViewImage  popNumberType = ZYXNumberViewImageInner;
    if (button == [self.buttonList objectAtIndex:0] || button == [self.buttonList objectAtIndex:10]) {
        popNumberType = ZYXNumberViewImageLeft;
        
    } else if(button == [self.buttonList objectAtIndex:9] || button == [self.buttonList objectAtIndex:19]){
        popNumberType = ZYXNumberViewImageRight;
    }
    return popNumberType;
}

//特殊符号
- (void)characterPressed:(NSString *)charValue {
    
    NSString *character = [NSString stringWithString:charValue];
    if (self.characterPressedCompleted) {
        self.characterPressedCompleted(character, ZYXKeyBoardButtonSymbols);
    }
}

//删除字符
- (void)deleteClick:(id)sender {
    
    if (self.characterPressedCompleted) {
        self.characterPressedCompleted(nil, ZYXKeyBoardButtonDelete);
    }
}

- (void)deleteLongPressed:(UILongPressGestureRecognizer *)sender {
    
    [super deleteLongPressed:sender];
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
        _deleteButton.selected = YES;
    } else {
        _deleteButton.selected = NO;
    }
}

//“数字”切换
- (void)numberButtonClick:(id)sender {
    
    if (self.characterPressedCompleted) {
        self.characterPressedCompleted(nil, ZYXKeyBoardButtonNumberPadSwitch);
    }
}

//“英文字母”切换
- (void)characterButtonClick:(id)sender {
    
    if (self.characterPressedCompleted) {
        self.characterPressedCompleted(nil, ZYXKeyBoardButtonCharacterSwitch);
    }
}

@end
