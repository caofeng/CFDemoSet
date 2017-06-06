//
//  CFSocketConnection.h
//  DemoSet
//
//  Created by CaoFeng on 2017/6/6.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CFSocketConnectionDelegate <NSObject>

- (void)didDisconnectWithError:(NSError *)error;
- (void)didConnectToHost:(NSString *)host port:(UInt16)port;
- (void)didReceiveData:(NSData *)data tag:(long)tag;

@end

@interface CFSocketConnection : NSObject

@property (nonatomic, weak) id<CFSocketConnectionDelegate> delegate;

- (void)connectWithHost:(NSString *)hostName port:(int)port;
- (void)disconnect;

- (BOOL)isConnected;
- (void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag;
- (void)writeData:(NSData *)data timeout:(NSTimeInterval)timeout tag:(long)tag;

@end
