//
//  CFSocketConnection.m
//  DemoSet
//
//  Created by CaoFeng on 2017/6/6.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CFSocketConnection.h"
#import "GCDAsyncSocket.h"  

@interface CFSocketConnection ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket    *asyncSocket;

@end

@implementation CFSocketConnection

- (instancetype)init {
    self = [super init];
    if (self) {
        
        //仅展示Socket的简单使用
        
        self.asyncSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    
    return self;
}

- (void)dealloc
{
    self.asyncSocket.delegate = nil;
    self.asyncSocket = nil;
    
}

- (void)connectWithHost:(NSString *)hostName port:(int)port {
    
    NSError *error = nil;
    
    [self.asyncSocket connectToHost:hostName onPort:port error:&error];
    
    if (error) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(didDisconnectWithError:)]) {
            [_delegate didDisconnectWithError:error];
        }
    }
}
- (void)disconnect {
    
    [self.asyncSocket disconnect];
}

- (BOOL)isConnected {
    
    return [self.asyncSocket isConnected];
    
}
- (void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag {
    
    [self.asyncSocket readDataWithTimeout:timeout tag:tag];
}
- (void)writeData:(NSData *)data timeout:(NSTimeInterval)timeout tag:(long)tag {
    
    [self.asyncSocket writeData:data withTimeout:timeout tag:tag];
    
}

#pragma mark GCDAsyncSocketDelegate method

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    if (_delegate && [_delegate respondsToSelector:@selector(didDisconnectWithError:)]) {
        [_delegate didDisconnectWithError:err];
    }
}


- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    if (_delegate && [_delegate respondsToSelector:@selector(didConnectToHost:port:)]) {
        
        [_delegate didConnectToHost:host port:port];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if (_delegate && [_delegate respondsToSelector:@selector(didReceiveData:tag:)]) {
        [_delegate didReceiveData:data tag:tag];
    }
    [sock readDataWithTimeout:-1 tag:tag];//设置参数 -1 可以保持长连接状态
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
    [sock readDataWithTimeout:-1 tag:tag];
}

@end
