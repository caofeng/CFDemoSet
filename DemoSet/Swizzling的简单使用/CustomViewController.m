//
//  CustomViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/18.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"---%@",NSStringFromClass([self class]));
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)customMethod {
    NSLog(@"---%@的方法",NSStringFromClass([self class]));
}


@end
