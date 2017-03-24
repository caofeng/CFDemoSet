//
//  People.m
//  DemoSet
//
//  Created by CaoFeng on 17/3/24.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "People.h"

@interface People ()

@property (nonatomic, weak) NSTimer   *timer;
@property (nonatomic, assign) long long leftSeconds;

@end

@implementation People


-(void)setRemainSeconds:(long long)remainSeconds {
    
    self.leftSeconds = remainSeconds;
    
    if (self.leftSeconds>0) {
        
        //定时器
        _timer =[NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            -- _leftSeconds;
            
            if (self.countdownBlock) {
                self.countdownBlock(self.leftSeconds);
            }
            
            if (_leftSeconds<=0) {
                [_timer invalidate];
                _timer = nil;
            }
        }];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer fire];
        
    } else {
        
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
        self.leftSeconds=0;
    }
    
    

}



@end
