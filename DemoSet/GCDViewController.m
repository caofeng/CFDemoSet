//
//  GCDViewController.m
//  DemoSet
//
//  Created by CaoFeng on 2017/6/23.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1.dispatch_async 函数如何实现，分发到主队列和全局队列有什么区别，一定会新建线程执行任务么？
    //2.dispatch_sync 函数如何实现，为什么说 GCD 死锁是队列导致的而不是线程，死锁不是操作系统的概念么？
    //3.信号量是如何实现的，有哪些使用场景？
    //4.dispatch_group 的等待与通知、dispatch_once 如何实现？
    //5.dispatch_source 用来做定时器如何实现，有什么优点和用途？
    //6.dispatch_suspend 和 dispatch_resume 如何实现，队列的的暂停和计时器的暂停有区别么？

    
    
    dispatch_queue_t queue = dispatch_queue_create("com.bestswifter.queue", nil);
    
    dispatch_sync(queue, ^{
        
        NSLog(@"current thread==1 = %@", [NSThread currentThread]);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            NSLog(@"current thread==2 = %@", [NSThread currentThread]);
            
        });
        
    });
    
    
    
    
    
    
    
    
    
}


@end
