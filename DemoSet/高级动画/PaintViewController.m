//
//  PaintViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/23.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "PaintViewController.h"
#import "PaintView.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface PaintViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation PaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"高效绘图";
    self.fd_interactivePopDisabled = YES;
    
    PaintView *paintView = [[PaintView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:paintView];
    
    
    
    
    
}





@end
