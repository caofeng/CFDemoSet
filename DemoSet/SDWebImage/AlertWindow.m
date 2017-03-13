//
//  AlertWindow.m
//  DemoSet
//
//  Created by CaoFeng on 17/3/10.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "AlertWindow.h"

@interface AlertWindow ()

@property (nonatomic, strong) UIButton  *cancel;
@property (nonatomic, copy) CompletionBlock completionblock;

@end

@implementation AlertWindow


- (instancetype)initWithFrame:(CGRect)frame completionBlock:(CompletionBlock)completionBlock {
    
    self =  [super initWithFrame:frame];
    if (self) {
        
        [self makeKeyAndVisible];
        self.windowLevel = 100;
        self.rootViewController = [UIViewController new];
        self.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self setupviews];
        [self setupConstraints];
        self.completionblock = completionBlock;
    }
    return self;
}

- (void)setupviews {
    
    self.cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancel.frame = CGRectMake(20, 200, 300, 100);
    [self addSubview:self.cancel];
    [self.cancel setTitle:@"取消" forState:UIControlStateNormal];
    self.cancel.backgroundColor = [UIColor redColor];
    [self.cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)cancelClick {
    [self removeFromSuperview];
    self.completionblock();
}

- (void)setupConstraints {
    
}

- (void)dealloc
{
    NSLog(@"window释放了");
}



@end
