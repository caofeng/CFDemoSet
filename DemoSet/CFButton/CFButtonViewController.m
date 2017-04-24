//
//  CFButtonViewController.m
//  DemoSet
//
//  Created by CaoFeng on 2017/4/20.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CFButtonViewController.h"
#import "CFButton.h"
#import "Masonry.h"
#import "CFTool.h"

@interface CFButtonViewController ()

@property (nonatomic, strong) CFButton  *button;
@property (nonatomic, assign) BOOL  open;

@end

@implementation CFButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)];
    
    NSLog(@"===nativeBounds.size.width:%f", [UIScreen mainScreen].nativeBounds.size.width);
    NSLog(@"===bounds.size.width:%f", [UIScreen mainScreen].bounds.size.width);
    NSLog(@"===applicationFrame.size.width:%f", [UIScreen mainScreen].applicationFrame.size.width);
    
    self.open = YES;
    
    self.button = [CFButton initWithTitle:@"下一步" buttonHeadle:^{
    
        [self buttonClick];
        
    }];
    [self.view addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    
}

- (void)buttonClick {
    
    if (self.open) {
        
        [self.button startAnimation];
        
    } else {
        
        [self.button endAnimation];
    }
    
    self.open = !self.open;
    
}

@end
