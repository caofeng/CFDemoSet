//
//  InputCheckViewController.m
//  DemoSet
//
//  Created by CaoFeng on 17/3/13.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "InputCheckViewController.h"
#import "Masonry.h"
#import "CFWebViewController.h"
@interface InputCheckViewController ()

@property (nonatomic, assign) NSInteger i;

@end

@implementation InputCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.frame = [[UIScreen mainScreen]bounds];
    
    
    UITextField *moneyTextField = [[UITextField alloc]init];
    moneyTextField.placeholder = @"输入数字和逗点";
    moneyTextField.borderStyle = UITextBorderStyleRoundedRect;
    moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:moneyTextField];
    [moneyTextField addTarget:self action:@selector(moneyTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(64+20));
        make.left.equalTo(@20);
        make.right.equalTo(@-10);
        make.height.equalTo(@30);
    }];
    
    UITextField *numTextField = [[UITextField alloc]init];
    numTextField.placeholder = @"输入数字";
    numTextField.borderStyle = UITextBorderStyleRoundedRect;
    numTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:numTextField];
    [numTextField addTarget:self action:@selector(numTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyTextField.mas_bottom).offset(30);
        make.left.equalTo(@20);
        make.right.equalTo(@-10);
        make.height.equalTo(@30);
    }];

    
    UITextField *phoneTextField = [[UITextField alloc]init];
    phoneTextField.placeholder = @"输入银行卡号";
    phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
//    phoneTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:phoneTextField];
    [phoneTextField addTarget:self action:@selector(phoneTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numTextField.mas_bottom).offset(30);
        make.left.equalTo(@20);
        make.right.equalTo(@-10);
        make.height.equalTo(@30);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击试试" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTextField.mas_bottom).offset(30);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.equalTo(@100);
    }];
    
    
}

- (void)buttonClick {
    
    CFWebViewController *vc = [CFWebViewController initRouteToViewControllerByURLString:@"https://www.baidu.com" withTitle:@"中业兴融"];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)moneyTextFieldEditingChanged:(UITextField *)textField {
    NSString *text = textField.text;
    text =  [self extractNumberAndDotFormString:text];
    textField.text = text;
}

- (void)numTextFieldEditingChanged:(UITextField *)textField {
    NSString *text = textField.text;
    text =  [self extractNumberFormString:text];
    textField.text = text;
}

- (void)phoneTextFieldEditingChanged:(UITextField *)textField {
    
    textField.text =[self transverterPhoneFormString:textField.text];
    
}


//限制输入金额类数字
- (NSString *)formatAmount:(NSString *)amount {
    
    NSString *text = [self extractNumberAndDotFormString:amount];
    if ([text hasPrefix:@"."]) {//不能.开头
        text = [text substringFromIndex:1];
    }
    if ([text hasPrefix:@"0"]) {//0开头
        if (text.length >= 2) {
            NSString *secondChar = [text substringWithRange:NSMakeRange(1, 1)];
            if (![secondChar isEqualToString:@"."]) {//0开头，第二个字符不是小数点，则去掉0
                text = [text substringFromIndex:1];
            }
        }
    }
    
    NSArray *components = [text componentsSeparatedByString:@"."];
    if (components.count > 2) {//只能有一个小数点
        text = [NSString stringWithFormat:@"%@.%@", components[0], components[1]];
    } else if (components.count == 2) {//有一个小数点时，后面保留两位小数
        NSString *lastComponent = components[1];
        if (lastComponent.length > 2) {
            lastComponent = [lastComponent substringWithRange:NSMakeRange(0, 2)];
        }
        text = [NSString stringWithFormat:@"%@.%@", components[0], lastComponent];
    }
    
    return text;
}



//提取数字和逗点
- (NSString *)extractNumberAndDotFormString:(NSString *)string {
    
    NSCharacterSet* tmpSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:tmpSet]componentsJoinedByString:@""];
    return filtered;
}

//提取数字
- (NSString *)extractNumberFormString:(NSString *)string {
    
    NSCharacterSet* tmpSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:tmpSet]componentsJoinedByString:@""];
    return filtered;
}

//提取数字和字母
- (NSString *)extractNumberAndAlphabetFormString:(NSString *)string {
    
    NSCharacterSet* tmpSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKMLNOPQRSTUVWSYZabcdefghijklmonpqrstuvwxyz"]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:tmpSet]componentsJoinedByString:@""];
    return filtered;
}


//提取字母

- (NSString *)extractAlphabetFormString:(NSString *)string {
    
    NSCharacterSet* tmpSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKMLNOPQRSTUVWSYZabcdefghijklmonpqrstuvwxyz"]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:tmpSet]componentsJoinedByString:@""];
    return filtered;
}

//把输入文本转换成银行卡号
- (NSString *)transverterBankIDFormString:(NSString *)string {
    
    NSCharacterSet* tmpSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789 "]invertedSet];
    string = [[string componentsSeparatedByCharactersInSet:tmpSet]componentsJoinedByString:@""];

    NSString *newString = @"";
    
    while (string.length > 0) {
        
        NSString *subString = [string substringToIndex:MIN(string.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        string = [string substringFromIndex:MIN(string.length, 4)];
    }
    
    
    return newString;
}

//把输入文本转换成手机号
- (NSString *)transverterPhoneFormString:(NSString *)string {
    
    NSCharacterSet* tmpSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789 "]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:tmpSet]componentsJoinedByString:@""];
    
    if (filtered.length > self.i) {
        if (filtered.length == 4 || filtered.length == 9 ) {//输入
            NSMutableString * str = [[NSMutableString alloc ] initWithString:filtered];
            [str insertString:@" " atIndex:(filtered.length-1)];
            filtered = str;
        }if (filtered.length >= 13 ) {//输入完成
            filtered = [filtered substringToIndex:13];
        }
        
        self.i = filtered.length;
        
    }else if (filtered.length < self.i){//删除
        if (filtered.length == 4 || filtered.length == 9) {
            filtered = [NSString stringWithFormat:@"%@",filtered];
            filtered = [filtered substringToIndex:(filtered.length-1)];
        }
        self.i = filtered.length;
    }
    
    return filtered;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
