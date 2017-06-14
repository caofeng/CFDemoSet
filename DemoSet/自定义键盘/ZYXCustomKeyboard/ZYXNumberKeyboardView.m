//
//  ZYXNumberKeyboardView.m
//
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "ZYXNumberKeyboardView.h"
#import "ZYXKeyButton.h"

#define kNumberChar @[ @"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"]   //数字字符


@interface ZYXNumberKeyboardView() <ZYXKeyboardKeyButtonDelegate>

/** 数字键盘类型 */
@property (nonatomic, assign) ZYXKeyboardType numKeyBoardType;
/** "删除"按钮 */
@property (nonatomic, strong) UIButton *deleteButton;
/** "Alt切换"按钮 */
@property (nonatomic, strong) UIButton *altButton;

/** 0数字左侧的按钮 */
@property (nonatomic, copy) NSString *bottomLeftButtonText;
/** 0数字左侧的按钮 */
@property (nonatomic, strong) UIFont *bottomLeftButtonFont;

@end


@implementation ZYXNumberKeyboardView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _numKeyBoardType = ZYXKeyboardTypeNumberDefaultPad;
        [self numberInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame keyboardType:(ZYXKeyboardType)type {

    self = [super initWithFrame:frame];
    if (self) {
        _numKeyBoardType = type;
        [self numberInit];
    }
    
    return self;
}


- (void)numberInit {
    
    CGFloat buttonWidth = self.frame.size.width / 3.0f;
    CGFloat buttonHeight = self.frame.size.height/4.0f;
    
    CGRect frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    for (int i = 0; i< self.charArrayList.count; i++) {
        
        ZYXKeyButton *btnTmp = [[ZYXKeyButton alloc] init];
        btnTmp.frame = frame;
        btnTmp.delegate = self;
        btnTmp.titleLabel.font = [UIFont systemFontOfSize:30];
        btnTmp.backgroundColor = [UIColor whiteColor];
        btnTmp.titleLabel.text = [self.charArrayList objectAtIndex:i];
        
        btnTmp.selectBackgroundColor = [UIColor colorWithRed:208/255.0 green:213/255.0 blue:219/255.0 alpha:1];
        btnTmp.normalBackgroundColor = [UIColor whiteColor];
        [self addSubview:btnTmp];
        [self.buttonList addObject:btnTmp];
        
        frame.origin.x  = frame.origin.x + frame.size.width;
        if ((i +1) == 3 || (i +1) == 6) {
            //第二行
            frame.origin.x = 0;
            frame.origin.y = frame.origin.y + frame.size.height;

        } else if((i +1) == 9) {
            
            //切换按钮
            frame.origin.x = frame.size.width;
            frame.origin.y = frame.origin.y + frame.size.height; 
            _altButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _altButton.frame = CGRectMake(0, frame.origin.y, buttonWidth, buttonHeight);
            [_altButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            
            [_altButton setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:208/255.0 green:213/255.0 blue:219/255.0 alpha:1]] forState:UIControlStateHighlighted];
            
            [_altButton setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:208/255.0 green:213/255.0 blue:219/255.0 alpha:1]] forState:UIControlStateNormal];
            
            [_altButton addTarget:self action:@selector(characterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_altButton];
            
            //删除按钮
            _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _deleteButton.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, buttonWidth, buttonHeight);
            _deleteButton.backgroundColor = [UIColor colorWithRed:208/255.0 green:213/255.0 blue:219/255.0 alpha:1];
            [_deleteButton setImage:[UIImage imageNamed:@"keyboard_num_del"] forState:UIControlStateNormal];
            [_deleteButton setImage:[UIImage imageNamed:@"keyboard_num_del"] forState:UIControlStateHighlighted];
            [_deleteButton setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:208/255.0 green:213/255.0 blue:219/255.0 alpha:1]] forState:UIControlStateHighlighted];
            [_deleteButton setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:208/255.0 green:213/255.0 blue:219/255.0 alpha:1]] forState:UIControlStateSelected];
            [_deleteButton setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:208/255.0 green:213/255.0 blue:219/255.0 alpha:1]] forState:UIControlStateNormal];
            [_deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
            UILongPressGestureRecognizer  *longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteLongPressed:)];
            longPressed.minimumPressDuration = 0.5f;
            [self addSubview:_deleteButton];
            [_deleteButton addGestureRecognizer:longPressed];
            
            [self addSubview:_deleteButton];
        }
    }
    
    //线条
    for (int i = 0; i<= 3; i++) {
        UIImageView  *line_1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height*i, self.frame.size.width, 0.5f)];
        line_1.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
        [self addSubview:line_1];
        
        UIImageView  *verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width *i, 0, 0.5f, self.frame.size.height)];
        verticalLine.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
        [self addSubview:verticalLine];
    }
    
    [self setupWithBottomLeftButtonWithKeyBoardType:_numKeyBoardType];
}

- (void)setupWithBottomLeftButtonWithKeyBoardType:(ZYXKeyboardType)keyBoardType {
    
    self.numKeyBoardType = keyBoardType;
    
    if (self.numKeyBoardType == ZYXKeyboardTypeNumberDefaultPad) {
        //字符切换
        self.bottomLeftButtonText = kCharacterLabel;
        self.bottomLeftButtonFont = [UIFont systemFontOfSize:19];
        
    } else if (self.numKeyBoardType == ZYXKeyboardTypeNumberIDPad) {
        //身份证键盘
        self.bottomLeftButtonText = @"X";
        self.bottomLeftButtonFont = [UIFont systemFontOfSize:26];
        
    } else if (self.numKeyBoardType == ZYXKeyboardTypeNumberAndDotPad) {
        //数字+小数点键盘
        self.bottomLeftButtonText = @"·";
        self.bottomLeftButtonFont = [UIFont systemFontOfSize:26];
        
    } else if (self.numKeyBoardType == ZYXKeyboardTypeNumberOnlyPad) {
        //纯数字键盘: 点击无反应
        self.bottomLeftButtonText = @"";
        self.bottomLeftButtonFont = [UIFont systemFontOfSize:28];
    }

    self.altButton.titleLabel.font = self.bottomLeftButtonFont;
    [self.altButton setTitle:self.bottomLeftButtonText forState:UIControlStateNormal];
}

- (NSMutableArray *)getCharacterList {
    
    return [[NSMutableArray alloc] initWithArray:kNumberChar];
}

//数字符号
- (void)characterPressed:(NSString *)charValue {
    
    NSString *character = [NSString stringWithString:charValue];
    if (self.characterPressedCompleted) {
        self.characterPressedCompleted(character,ZYXKeyBoardButtonNumberPad);
    }
}

- (ZYXNumberViewImage)popUpToButtonPosition:(UIButton *)button {
    
    return ZYXNumberViewImageNone;
}

//删除字符
- (void)deleteClick:(id)sender {
    
    if (self.characterPressedCompleted) {
        self.characterPressedCompleted(nil,ZYXKeyBoardButtonDelete);
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

//字符切换
- (void)characterButtonClick:(id)sender {
    
    if (self.numKeyBoardType == ZYXKeyboardTypeNumberDefaultPad) {
        //字符切换
        if (self.characterPressedCompleted) {
            self.characterPressedCompleted(nil, ZYXKeyBoardButtonCharacterSwitch);
        }
        
    } else if (self.numKeyBoardType == ZYXKeyboardTypeNumberIDPad ||
               self.numKeyBoardType == ZYXKeyboardTypeNumberAndDotPad) {
        //身份证键盘或者数字+小数点键盘
        UIButton *button = (UIButton *)sender;
        NSString *character = [NSString stringWithString:button.titleLabel.text];
        if (self.numKeyBoardType == ZYXKeyboardTypeNumberAndDotPad) { character = @"."; }
        
        if (self.characterPressedCompleted) {
            self.characterPressedCompleted(character, ZYXKeyBoardButtonNumberPad);
        }
        
    } else if (self.numKeyBoardType == ZYXKeyboardTypeNumberOnlyPad) {
        //纯数字键盘: 点击无反应
    }
}

-(UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end


