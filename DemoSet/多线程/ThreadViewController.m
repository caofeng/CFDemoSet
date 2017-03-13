//
//  Thread ViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/18.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "ThreadViewController.h"
#import "SwizzlingViewController.h"

@interface ThreadViewController ()

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //有4个术语比较容易混淆：同步、异步、并发、串行
    //同步和异步决定了要不要开启新的线程
    //同步：在当前线程中执行任务，不具备开启新线程的能力
    //异步：在新的线程中执行任务，具备开启新线程的能力
    //并发和串行决定了任务的执行方式
    //并发：多个任务并发（同时）执行
    //串行：一个任务执行完毕后，再执行下一个任务
    
    
    NSLog(@"-----%@",[NSThread mainThread]);


    //1.全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //异步执行，执行顺序不确定，同时开启三个子线程
    dispatch_async(queue, ^{
        NSLog(@"--任务1---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"--任务2---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"--任务3---%@",[NSThread currentThread]);
    });
    
    
    
    //2.创建串行队列
    dispatch_queue_t queue2 = dispatch_queue_create("CF", NULL);
    
    //添加任务到队列中异步执行 4-->5-->6（因为是串行队列），只会开一个线程
    dispatch_async(queue2, ^{
        NSLog(@"--任务4---%@",[NSThread currentThread]);
    });
    dispatch_async(queue2, ^{
        NSLog(@"--任务5---%@",[NSThread currentThread]);
    });
    dispatch_async(queue2, ^{
        NSLog(@"--任务6---%@",[NSThread currentThread]);
    });
    
    
    //3.创建全局并发队列
    dispatch_queue_t queue3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    //添加任务到队列中，同步执行,不会开启新的线程，并发队列失去了并发的功能
    dispatch_sync(queue3, ^{
        NSLog(@"--任务7---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue3, ^{
        NSLog(@"--任务8---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue3, ^{
        NSLog(@"--任务9---%@",[NSThread currentThread]);
    });
    
    //4.创建串行队列
    dispatch_queue_t queue4 = dispatch_queue_create("CYF", NULL);

    //添加任务到队列中，同步执行，不会开启新线程
    dispatch_sync(queue4, ^{
        NSLog(@"--任务10---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue4, ^{
        NSLog(@"--任务11---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue4, ^{
        NSLog(@"--任务12---%@",[NSThread currentThread]);
    });
    
    //小结
    
    //说明：同步函数不具备开启线程的能力，无论是什么队列都不会开启线程；异步函数具备开启线程的能力，开启几条线程由队列决定（串行队列只会开启一条新的线程，并发队列会开启多条线程）。
    
    //同步函数
    //并发队列：不会开线程
    //串行队列：不会开线程
    
    //异步函数
    //并发队列：能开启N条线程
    //串行队列：开启1条线程
    
    
    //GCD常用函数
    
    //1.延迟执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"需要延迟执行的代码");
    });
    
    //2.单例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"只执行一次的代码");
    });
    
    //3.dispatch_group_notify,还挺有用的
    
    dispatch_queue_t queue5 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue5, ^{
        NSLog(@"任务1");
    });
    dispatch_group_async(group, queue5, ^{
        NSLog(@"任务2");
    });
    dispatch_group_async(group, queue5, ^{
        NSLog(@"任务3");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"任务1，2，3完成之后再执行此处");
    });
    
    //4.dispatch_group_wait，提供了一种类似超时的机制
    
    dispatch_queue_t queue6 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_t group2 = dispatch_group_create();
    
    dispatch_group_async(group2, queue6, ^{
        NSLog(@"任务4");
    });
    dispatch_group_async(group2, queue6, ^{
        NSLog(@"任务5");
    });
    dispatch_group_async(group2, queue6, ^{
        NSLog(@"任务6");
    });
    
    dispatch_group_wait(group2, DISPATCH_TIME_FOREVER);
    
    //5. dispatch_barrier_async 栅栏函数
    //6. dispatch_apply
    //7. dispatch semaphore
    //8. dispatch_semaphore_create
    //9. dispatch_semaphore_wait
    //10. dispatch_semaphore_signal
    
    /*--------------------------暂时到这吧------------------------------*/
    
    
    
}


- (void)dealloc
{
    NSLog(@"----%@-----",NSStringFromClass([self class]));
}

@end
