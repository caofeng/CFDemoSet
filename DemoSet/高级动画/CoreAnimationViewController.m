//
//  CoreAnimationViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/18.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CoreAnimationViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Frame_CoreAnimationViewController.h"
//#import "UMMobClick/MobClick.h"

@interface CoreAnimationViewController ()<CALayerDelegate>
@property (nonatomic, strong) CALayer *layer;

@end

@implementation CoreAnimationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[MobClick beginLogPageView:@"核心动画页"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[MobClick endLogPageView:@"核心动画页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //http://www.open-open.com/lib/view/open1419557847453.html
    
    //核心动画 是基于图层的
    
    self.layer = [CALayer layer];
    self.layer.frame = CGRectMake(0, 64, 200, 200);
    self.layer.delegate = self;
    self.layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:self.layer];
    [self.layer display];
    
    
    //contents,一般就是张图片，其实也只能放图片
    /*
    UIImage *image = [UIImage imageNamed:@"2.jpg"];
    self.layer.contents = (__bridge id _Nullable)(image.CGImage);
    */
    
    //显示模式--有点类似 UIImageview 的 contentMode属性
    /*
    self.layer.contentsGravity = kCAGravityResizeAspectFill;
    */
    
    //这三个属性就没什么说的了
    /*
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 20;
    self.layer.contentsScale = 2.0;
    */
    
    //这个属性 效果挺奇怪的--它定义了一个固定的边框和一个在图层上可拉伸的区域
    /*
    self.layer.contentsCenter = CGRectMake(0.25, 0.25, 0.8, 0.8);
    */
    
    //这个属性通俗说，切割视图，显示其中一部分,淘宝PC版查看大图有这种效果
    //self.layer.contentsRect = CGRectMake(0.5, 0.5, 0.5, 0.5);
    
    //下面展示四张图片分别取一部分 拼接成一张图片
    
    [self jointViews];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 610, 450, 80);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"下一篇(图层布局)" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)buttonClick:(UIButton *)button {
    
    Frame_CoreAnimationViewController *vc = [[Frame_CoreAnimationViewController alloc]initWithNibName:@"Frame_CoreAnimationViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

//一般不会这样做绘制，可以自定义一个View,实现-drawRect:方法也方便管理
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
    
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    //当图层的bounds发生改变，或者图层的-setNeedsLayout方法被调用的时候，这个函数将会被执行,可以手动地重新摆放或者重新调整子图层的大小
}


- (void)jointViews {
    
    CALayer *leftTopImageLayer = [CALayer layer];
    leftTopImageLayer.frame = CGRectMake(20, 300, 150, 150);
    [self.view.layer addSublayer:leftTopImageLayer];
    UIImage *leftTopImage = [UIImage imageNamed:@"1.jpg"];
    leftTopImageLayer.contents = (__bridge id _Nullable)(leftTopImage.CGImage);
    leftTopImageLayer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
    
    CALayer *rightTopImageLayer = [CALayer layer];
    rightTopImageLayer.frame = CGRectMake(170, 300, 150, 150);
    [self.view.layer addSublayer:rightTopImageLayer];
    UIImage *rightTopImage = [UIImage imageNamed:@"1.jpg"];
    rightTopImageLayer.contents = (__bridge id _Nullable)(rightTopImage.CGImage);
    rightTopImageLayer.contentsRect = CGRectMake(0.5, 0, 0.5, 0.5);

    
    CALayer *leftBottomImageLayer = [CALayer layer];
    leftBottomImageLayer.frame = CGRectMake(20, 450, 150, 150);
    [self.view.layer addSublayer:leftBottomImageLayer];
    UIImage *leftBottomImage = [UIImage imageNamed:@"1.jpg"];
    leftBottomImageLayer.contents = (__bridge id _Nullable)(leftBottomImage.CGImage);
    leftBottomImageLayer.contentsRect = CGRectMake(0, 0.5, 0.5, 0.5);

    
    CALayer *rightBottomImageLayer = [CALayer layer];
    rightBottomImageLayer.frame = CGRectMake(170, 450, 150, 150);
    [self.view.layer addSublayer:rightBottomImageLayer];
    UIImage *rightBottomImage = [UIImage imageNamed:@"1.jpg"];
    rightBottomImageLayer.contents = (__bridge id _Nullable)(rightBottomImage.CGImage);
    rightBottomImageLayer.contentsRect = CGRectMake(0.5, 0.5, 0.5, 0.5);
}

- (void)dealloc
{
//    self.layer.delegate = nil;
}


@end
