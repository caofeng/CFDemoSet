//
//  CustomWindowRootViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CustomWindowRootViewController.h"
#import "PINCache.h"
@interface CustomWindowRootViewController ()

@end

@implementation CustomWindowRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //可以在这个类中做很多事情，启动图，闪屏之类的
    
    
}
- (IBAction)removeWindowClick:(id)sender {
    
    if (self.removeBlock) {
        self.removeBlock();
    }
}

- (void)dealloc
{
    self.view.hidden = YES;
    NSLog(@"%@被释放了",NSStringFromClass([self class]));
}


@end
