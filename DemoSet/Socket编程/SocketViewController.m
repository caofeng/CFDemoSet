//
//  SocketViewController.m
//  DemoSet
//
//  Created by CaoFeng on 2017/6/5.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "SocketViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import "AFNetworkReachabilityManager.h"
#import "CFSocketConnection.h"

@interface SocketViewController ()<CFSocketConnectionDelegate>

@property (nonatomic, copy) NSString    *serverHost;
@property (nonatomic, assign) int       serverPort;
@property (nonatomic, strong) CFSocketConnection    *connection;

@end

@implementation SocketViewController


- (IBAction)buttonClick:(UIButton *)sender {
    
    
    [self shakeAnimationForView:sender];
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"===ststus:%ld",(long)status);
        
        NSString *networkTypeString = [[AFNetworkReachabilityManager sharedManager] localizedNetworkReachabilityStatusString];
        
        NSLog(@"networkTypeString:%@",networkTypeString);
        
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    
    //使用第三方 CocoaAsyncSocket 实现长连接
    self.serverHost = @"www.baidu.com";
    self.serverPort = 80;
    //[self openConnection];
    
    
    // 原生 C 语言形式的实现长连接方法
    
  //  [self loadDataFromServer];
    
}


- (void)openConnection
{
    [self closeConnection];
    self.connection = [[CFSocketConnection alloc] init];
    self.connection.delegate = self;
    
    [self.connection connectWithHost:self.serverHost port:self.serverPort];
    [self.connection readDataWithTimeout:-1 tag:1];
   
    [self.connection writeData:[@"GET / HTTP/1.1\r\n"
                                "Host: www.baidu.com\r\n"
                                "User-Agent: iphone\r\n"
                                "Connection: close\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding] timeout:-1 tag:1];
}

- (void)closeConnection
{
    if (self.connection) {
        self.connection.delegate = nil;
        [self.connection disconnect];
        self.connection = nil;
    }
}

- (void)didDisconnectWithError:(NSError *)error
{
    NSLog(@"didDisconnectWithError...==%@",[error description]);
}

- (void)didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"didConnectToHost:%@ port:%d",host,port);
}

- (void)didReceiveData:(NSData *)data tag:(long)tag
{
    NSLog(@"didReceiveData:%@",data);
    
   NSString *receiveString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"===receiveString:%@",receiveString);
    
}


//以下是原生Socket请求，了解--5步

- (void)loadDataFromServer {
    
    // 1.创建客户端Socket
    /**
     参数
     参数1 : domain,协议域/协议簇，AF_INET（IPV4的网络开发）
     参数2 : type,Socket类型，SOCK_STREAM(TCP)/SOCK_DGRAM(UDP，报文)
     参数3 : protocol,IPPROTO_TCP，协议，如果输入0，可以根据第二个参数，自动选择协议
     
     返回值
     int类型,如果 > 0 就表示创建客户端Socket成功,返回socket
     */
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    if (clientSocket > 0) {
        NSLog(@"创建客户端Socket成功");
    }
    
    // 2.客户端Socket连接到服务器Socket
    /**
     参数
     参数1 :  客户端socket
     参数2 :  指向数据结构sockaddr的指针，其中包括目的端口和IP地址
     服务器的"结构体"地址
     提示：C 语言中没有对象
     参数3 :  结构体数据长度
     
     返回值
     0 成功/其他 错误代号，(不是非0即真)
     */
   
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_port = htons(80);
    addr.sin_addr.s_addr = inet_addr("119.75.217.109");
    
    int isConnected = connect(clientSocket, (const struct sockaddr *)&addr, sizeof(addr));
    if (isConnected == 0) {
        NSLog(@"连接到服务器成功");
    }
    
    // 3.客户端Socket向服务器Socket发送请求
    /**
     参数
     参数1 : 客户端socket
     参数2 : 发送内容地址 void * == id
     参数3 : 发送内容长度
     参数4 : 发送方式标志，一般为0
     
     返回值
     如果成功，则返回发送的字节数，失败则返回SOCKET_ERROR
     */
    
    NSString *sendMsg = @"GET / HTTP/1.1\r\n"
    "Host: www.baidu.com\r\n"
    "User-Agent: iphone\r\n"
    "Connection: close\r\n\r\n"
    ;
    
    ssize_t sendCount = send(clientSocket, sendMsg.UTF8String, strlen(sendMsg.UTF8String), 0);
    NSLog(@"发送字符数 %ld",sendCount);
    
    // 4.客户端Socket接收服务器Socket发送的数据(响应)
    /**
     参数
     参数1 : 客户端socket
     参数2 : 接收内容缓冲区地址
     参数3 : 接收内容缓存区长度
     参数4 : 接收方式，0表示阻塞，必须等待服务器返回数据
     
     返回值
     如果成功，则返回读入的字节数，失败则返回SOCKET_ERROR
     
     提示 : 服务器发送给客户端数据时,是一点一点发送的
     提示 : 当服务器把数据都发送完了以后,再次发送时,只发送0字节,
     */
    
    // 创建接收服务器发送的数据的容器 / 缓冲区 ,并且指定了容量
    uint8_t buffer[1024];
    // 需要创建一个容器
    NSMutableData *dataM = [NSMutableData data];
    
    // 循环的接收服务器发送的数据
    ssize_t recvCount = -1;
    while (recvCount != 0) {
        // 值接收了一次
        recvCount = recv(clientSocket, buffer, sizeof(buffer), 0);
        NSLog(@"接收的内容数 %ld",recvCount);
        [dataM appendBytes:buffer length:recvCount];
    }
    NSString *html = [[NSString alloc] initWithData:dataM encoding:NSUTF8StringEncoding];
    NSLog(@"%@",html);
    
    // 5.关闭Socket
    close(clientSocket);
}

/**
 *  抖动效果
 *
 *  @param view 要抖动的view
 */
- (void)shakeAnimationForView:(UIView *) view {
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(position.x + 5, position.y);
    CGPoint y = CGPointMake(position.x - 5, position.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:.06];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}

@end
