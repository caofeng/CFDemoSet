//
//  CFLunboViewController.m
//  DemoSet
//
//  Created by CaoFeng on 2017/6/21.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CFLunboViewController.h"
#import "CFCycleView.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface CFLunboViewController ()

@property (nonatomic, strong) CFCycleView *cycleView;

@end

@implementation CFLunboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.fd_interactivePopDisabled = YES;
    
    self.cycleView = [[CFCycleView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.view addSubview:self.cycleView];
    
    [self.cycleView setLocationImageArray:@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"]];
    
    self.cycleView.selectedImageIndex = ^(NSInteger index) {
        
        NSLog(@"====%ld",index);
    };
}

- (void)dealloc
{
    NSLog(@"===%@",NSStringFromClass([self class]));
}


@end
