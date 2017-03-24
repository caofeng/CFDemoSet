//
//  People.m
//  DemoSet
//
//  Created by CaoFeng on 17/3/24.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "People.h"
#include <sys/sysctl.h>

@interface People ()

@property (nonatomic, weak) NSTimer   *timer;
@property (nonatomic, assign) long long leftSeconds;

@end

@implementation People


-(void)setRemainSeconds:(long long)remainSeconds {
    
    self.leftSeconds = remainSeconds;
    
    if (self.leftSeconds > 0) {
        
        if (!self.timer) {
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHeadle) userInfo:nil repeats:YES];
            [self.timer fire];
            [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
            
        }
        
    } else {
        
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        
    }

}

- (void)timerHeadle
{
    
    NSLog(@"===%lld",self.leftSeconds);
    self.leftSeconds-=1;

    if (self.countdownBlock) {
        self.countdownBlock(self.leftSeconds);
    }
    
    if (self.leftSeconds<=0) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    
}
- (void)dealloc
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(time_t)uptime
{
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    time_t now;
    time_t uptime = -1;
    (void)time(&now);
    
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0)
    {
        uptime = now - boottime.tv_sec;
    }
    return uptime;
}


@end
