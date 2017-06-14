//
//  CFKeyboardViewController.m
//  DemoSet
//
//  Created by CaoFeng on 2017/6/14.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CFKeyboardViewController.h"
#import "UITextField+ZYXKeyboard.h"

@interface CFKeyboardViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldNum;

@property (weak, nonatomic) IBOutlet UITextField *textFieldIDCard;

@property (weak, nonatomic) IBOutlet UITextField *textFieldMoney;

@property (weak, nonatomic) IBOutlet UITextField *textFieldAlpha;

@property (weak, nonatomic) IBOutlet UITextField *textFieldNormal;

@end

@implementation CFKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.textFieldNum setSafeKeyBoardType:ZYXKeyboardTypeNumberOnlyPad safeKeyBoardReturnType:ZYXKeyboardReturnTypeFinish];
    self.textFieldNum.delegate = self;

    [self.textFieldIDCard setSafeKeyBoardType:ZYXKeyboardTypeNumberIDPad safeKeyBoardReturnType:ZYXKeyboardReturnTypeFinish];
    self.textFieldIDCard.delegate = self;

    [self.textFieldMoney setSafeKeyBoardType:ZYXKeyboardTypeNumberAndDotPad safeKeyBoardReturnType:ZYXKeyboardReturnTypeFinish];
    self.textFieldMoney.delegate = self;

    [self.textFieldAlpha setSafeKeyBoardType:ZYXKeyboardTypeNumberDefaultPad safeKeyBoardReturnType:ZYXKeyboardReturnTypeFinish];
    self.textFieldAlpha.delegate = self;

    [self.textFieldNormal setSafeKeyBoardType:ZYXKeyboardTypeDefault safeKeyBoardReturnType:ZYXKeyboardReturnTypeFinish];
    self.textFieldNormal.delegate = self;
    
    
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.textFieldIDCard) {
        
        [self.textFieldIDCard resignFirstResponder];
    }
    
    return YES;
}



@end
