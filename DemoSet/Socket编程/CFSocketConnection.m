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
        
        NSLog(@"[CFSocketConnection] connectWithHost error: %@", error.description);
        
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
    NSLog(@"[CFSocketConnection] didDisconnect...%@", err.description);
    
    if (_delegate && [_delegate respondsToSelector:@selector(didDisconnectWithError:)]) {
        [_delegate didDisconnectWithError:err];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"[CFSocketConnection] didConnectToHost: %@, port: %d", host, port);
    if (_delegate && [_delegate respondsToSelector:@selector(didConnectToHost:port:)]) {
        [_delegate didConnectToHost:host port:port];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"[CFSocketConnection] didReadData length: %lu, tag: %ld", (unsigned long)data.length, tag);
    
    if (_delegate && [_delegate respondsToSelector:@selector(didReceiveData:tag:)]) {
        [_delegate didReceiveData:data tag:tag];
    }
    [sock readDataWithTimeout:-1 tag:tag];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"[CFSocketConnection] didWriteDataWithTag: %ld", tag);
    [sock readDataWithTimeout:-1 tag:tag];
}


@end
