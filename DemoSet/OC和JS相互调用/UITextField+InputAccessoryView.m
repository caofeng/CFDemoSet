//
//  UITextField+InputAccessoryView.m
//  DemoSet
//
//  Created by Apple.Cao on 16/12/12.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "UITextField+InputAccessoryView.h"
#import <objc/runtime.h>

@implementation UITextField (InputAccessoryView)

- (void)setRightStr:(NSString *)rightStr {
    objc_setAssociatedObject(self, "rightStr", rightStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)rightStr {
    return objc_getAssociatedObject(self, "rightStr");
}

- (void)setCustomAccessoryView {
    
    UIView *inputAccessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45)];
    inputAccessoryView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self setInputAccessoryView:inputAccessoryView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [inputAccessoryView addSubview:lineView];
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(5, 1, 50, 44);
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [inputAccessoryView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-105, 1, 100, 44);
    [rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    if (!self.rightStr) {
        self.rightStr= @"完成";
    }
    [rightButton setTitle:self.rightStr forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [inputAccessoryView addSubview:rightButton];
    [rightButton addTarget:self action:@selector(completationClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)completationClick {
    [self endEditing:YES];
    if (self.delegate) {
        [self.delegate textFieldShouldReturn:self];
    }
}

- (void)cancelClick {
    [self endEditing:YES];
}


@end
