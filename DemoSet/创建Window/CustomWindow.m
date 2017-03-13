//
//  CustomWindow.m
//  DemoSet
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CustomWindow.h"
#import "CustomWindowRootViewController.h"

@implementation CustomWindow

- (instancetype)initWithFrame:(CGRect)frame completionBlock:(CompletionBlock)completionBlock {
    
   self =  [super initWithFrame:frame];
    if (self) {
        
        //系统的Window有三个:UIWindowLevelNormal,UIWindowLevelStatusBar,UIWindowLevelAlert,他们的Level为1，1000，2000，此外可以手动创建自己的Window,并设置Level；
        
        //Window就是一个特殊的View,但如果要手动创建Window，一定要设置它的跟视图，否则崩溃。这也就有个好处:项目的 启动图或者闪屏广告 都可以创建一个独立的window来展示，以减少和项目的主TabbarController牵扯。
        
        [self makeKeyAndVisible];
        self.windowLevel = UIWindowLevelStatusBar+1;
        
        CustomWindowRootViewController *vc = [[CustomWindowRootViewController alloc]initWithNibName:@"CustomWindowRootViewController" bundle:nil];
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
        nav.navigationBar.hidden = YES;
        self.rootViewController = nav;
        vc.removeBlock = ^ {
            if (completionBlock) {
                completionBlock();
            }
        };
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"自定义的Window被释放了");
}





@end
