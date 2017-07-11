//
//  TextFieldViewController.m
//  DemoSet
//
//  Created by MountainCao on 2017/7/11.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "TextFieldViewController.h"
#import "CFTextField.h"

@interface TextFieldViewController ()

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    UIBarButtonItem *doneButton_ = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton,doneButton_, nil]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    CFTextField *textField = [[CFTextField alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
    textField.placeholder = @"这是placeholder";
    textField.keyboardAppearance = UIKeyboardAppearanceDark;
    textField.insets = UIEdgeInsetsMake(10, 10, 10, 0);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.inputAccessoryView = keyboardDoneButtonView;
    [self.view addSubview:textField];
    
}

- (void)doneClicked:(UIBarButtonItem *)buttonItem {
    
    NSLog(@"===");
    
    
}




@end
