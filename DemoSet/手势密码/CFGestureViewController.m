//
//  CFGestureViewController.m
//  DemoSet
//
//  Created by CaoFeng on 2017/6/13.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CFGestureViewController.h"
#import "GestureViewController.h"
#import "GestureVerifyViewController.h"

@interface CFGestureViewController ()

@end

@implementation CFGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}


- (IBAction)gestureButtonClick:(UIButton *)sender {
    
    
    if (sender.tag == 10) {
        
        GestureViewController *vc = [[GestureViewController alloc]initWithGestureType:GestureViewControllerTypeSetting gestureSuccess:^(BOOL success) {
            
            if (success) {
                
                NSLog(@"设置手势密码成功");
                
            }
            
        } accountLoginHeadlerEvent:nil];
        
        [self presentViewController:vc animated:YES completion:nil];

    } else if (sender.tag == 20) {
        
        GestureVerifyViewController *vc = [[GestureVerifyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (sender.tag == 30) {
        
        
        //修改密码失败要退出登录
        
        GestureVerifyViewController *vc = [[GestureVerifyViewController alloc]init];
        vc.isToSetNewGesture = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (sender.tag == 40) {
        
        GestureViewController *vc = [[GestureViewController alloc]initWithGestureType:GestureViewControllerTypeLogin gestureSuccess:^(BOOL success) {
            
            if (success) {
                
                NSLog(@"登录成功了");
                
            } else {
                
                NSLog(@"登录失败了");

            }
            
        } accountLoginHeadlerEvent:^{
            
            NSLog(@"使用账号密码登录了");
        }];
        
        [self presentViewController:vc animated:YES completion:nil];

    }
    
}

@end
