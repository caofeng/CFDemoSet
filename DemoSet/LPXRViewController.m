//
//  LPXRViewController.m
//  DemoSet
//
//  Created by CaoFeng on 2017/6/23.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "LPXRViewController.h"

@interface LPXRViewController ()

@end

@implementation LPXRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /*
     
     「直接将图层合成到帧的缓冲区中(在屏幕上)比先创建屏幕外缓冲区，然后渲染到纹理中，最后将结果渲染到帧的缓冲区中要廉价很多。因为这其中涉及两次昂贵的环境转换(转换环境到屏幕外缓冲区，然后转换环境到帧缓冲区)。」触发离屏渲染后这种转换发生在每一帧，在界面的滚动过程中如果有大量的离屏渲染发生时会严重影响帧率。
     
     官方公开的的资料里关于离屏渲染的信息最早是在 2011年的 WWDC， 在多个 session 里都提到了尽量避免会触发离屏渲染的效果，包括：mask, shadow, group opacity, edge antialiasing。
     
     最初应该是从英文开发者那里传开的：使用 Core Graphics 里的绘制 API 也会触发离屏渲染，比如重写 drawRect:
     
     Core Graphics 的绘制 API 的确会触发离屏渲染，但不是那种 GPU 的离屏渲染。使用 Core Graphics 绘制 API 是在 CPU 上执行，触发的是 CPU 版本的离屏渲染
     
     */
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    bgView.backgroundColor = [UIColor redColor];
    bgView.layer.cornerRadius = 50;
    bgView.layer.masksToBounds = YES;
    bgView.layer.shouldRasterize = YES;//开启 Rasterization 后，GPU 只合成一次内容，然后复用合成的结果
    [self.view addSubview:bgView];
    
    
    UIView *bgView_ = [[UIView alloc]initWithFrame:CGRectMake(100, 350, 100, 100)];
    bgView_.backgroundColor = [UIColor greenColor];
    bgView_.layer.cornerRadius = 50;
    [self.view addSubview:bgView_];
    
    
//    for (int i=1;i<=9;i++) {
//        for(int j=1;j<=i;j++){
//            System.out.print(j+"*"+i+"="+i*j+" ");
//        }
//        System.out.println();
//    }
    
}



@end
