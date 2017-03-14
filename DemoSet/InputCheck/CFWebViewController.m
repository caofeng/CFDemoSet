//
//  CFWebViewController.m
//  DemoSet
//
//  Created by CaoFeng on 17/3/14.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//


#define kProductDetailPage @"productDetail"
#define kLoginPage @"login"
#define kRegisterPage @"register"


#import "CFWebViewController.h"
#import "WYWebProgressLayer.h"
#import "UIView+Frame.h"
#import "NewsViewController.h"

@interface CFWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WYWebProgressLayer *progressLayer;

@property (nonatomic, copy) NSString *navTitle;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *html;

@end

@implementation CFWebViewController

+(instancetype)initRouteToViewControllerByURLString:(NSString *)url {
    return [self initRouteToViewControllerByURLString:url withTitle:nil];
}

+(instancetype)initRouteToViewControllerByURLString:(NSString *)url withTitle:(NSString *)title{
    return [[self alloc] initWithUrl:url title:title];
}
+(instancetype)initRouteToViewControllerByHTMLString:(NSString *)html {
    return [self initRouteToViewControllerByHTMLString:html withTitle:nil];
}

+(instancetype)initRouteToViewControllerByHTMLString:(NSString *)html withTitle:(NSString *)title {
    return [[self alloc] initWithHTML:html title:title];
}

- (instancetype)initWithHTML:(NSString *)html title:(NSString *)title {
    self = [super init];
    if (self) {
        
        self.html = html;
        self.navTitle = title;
    }
    return self;
}

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title {
    self = [super init];
    if (self) {
        self.url = url;
        self.navTitle = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.frame = [[UIScreen mainScreen]bounds];
    
    if (self.navTitle.length>0) {
        self.navigationItem.title = self.navTitle;
    } else {
        self.navigationItem.title  = @"加载中...";
    }
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    if (self.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    } else if (self.html) {
        
        [self.webView loadHTMLString:self.html baseURL:nil];
    }
    
    self.progressLayer = [WYWebProgressLayer new];
    self.progressLayer.frame = CGRectMake(0, 43, self.webView.frame.size.width, 1);
    [self.navigationController.navigationBar.layer addSublayer:self.progressLayer];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //在此拦截H5页面
    NSURL *requestUrl = request.URL;
    NSString *path = requestUrl.path;
    
    if ([path hasPrefix:@"/"]) {
       path= [path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    }
    
    if ([requestUrl.scheme isEqualToString:@"zyxrapp"]) {
        
        [self jumpDestinationPageByPath:path];
        
        return NO;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    //在此向H5页面注入函数
    [self.progressLayer startLoad];

    NSLog(@"==加载开始==");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.progressLayer finishedLoad];

    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (self.navTitle.length<=0) {
        
        self.navigationItem.title = title;
        
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.progressLayer finishedLoad];

    NSLog(@"==加载失败==");
}


//拦截路径实现跳转
- (void)jumpDestinationPageByPath:(NSString *)path {
    
    if ([path isEqualToString:kProductDetailPage]) {
        
        NewsViewController *vc= [[NewsViewController alloc]initWithNibName:@"NewsViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([path isEqualToString:kLoginPage]) {
        
        NewsViewController *vc= [[NewsViewController alloc]initWithNibName:@"NewsViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([path isEqualToString:kRegisterPage]) {
        
        NewsViewController *vc= [[NewsViewController alloc]initWithNibName:@"NewsViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
- (void)dealloc {
    
    [self.progressLayer closeTimer];
    [self.progressLayer removeFromSuperlayer];
    self.progressLayer = nil;
}

@end
