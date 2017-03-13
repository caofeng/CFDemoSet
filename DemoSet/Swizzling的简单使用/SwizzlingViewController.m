//
//  SwizzlingViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/18.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "SwizzlingViewController.h"
#import <objc/runtime.h>
#import "CustomViewController.h"

@interface SwizzlingViewController ()

@end

@implementation SwizzlingViewController

+(void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method method1 = class_getInstanceMethod([self class], @selector(button1Method:));
        Method method2 = class_getInstanceMethod([self class], @selector(button2Method:));
        method_exchangeImplementations(method1, method2);
        
        /*------------为分割而存在的分割线----------------*/
        Method method3 = class_getInstanceMethod([self class], @selector(button3Method:));
        Method method4 = class_getInstanceMethod([CustomViewController class], @selector(customMethod));
        method_exchangeImplementations(method3, method4);
        
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"---%@",NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.Swizzling应该在+load方法中实现
    //2.Swizzling应该在dispatch_once中实现
    
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5"];
    
    NSString *num = [array objectAtIndex:5];
    NSLog(@"---%@",num);
    
        
}
- (IBAction)button1Method:(UIButton *)sender {
    
    NSLog(@"---Method1");
}

- (IBAction)button2Method:(UIButton *)sender {
    NSLog(@"---Method2");
}

- (IBAction)button3Method:(UIButton *)sender {
    NSLog(@"---Method3");
}


@end
