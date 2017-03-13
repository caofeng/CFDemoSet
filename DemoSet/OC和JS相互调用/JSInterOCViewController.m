//
//  JSInterOCViewController.m
//  DemoSet
//
//  Created by Apple.Cao on 16/11/24.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "JSInterOCViewController.h"
#import <WebKit/WebKit.h>
@interface JSInterOCViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation JSInterOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //介绍:http://www.jianshu.com/p/99c3af6894f4
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 30.0;
    configuration.preferences = preferences;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) configuration:configuration];
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    
    
    
    
    
    
    
    
}


@end
