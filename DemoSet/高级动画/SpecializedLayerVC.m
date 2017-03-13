//
//  SpecializedLayerVC.m
//  DemoSet
//
//  Created by Apple on 16/11/21.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "SpecializedLayerVC.h"
#import "VagueCoreAnimationViewController.h"

@interface SpecializedLayerVC ()

@end

@implementation SpecializedLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"专有图层使用";
    
    
     //CAShapeLayer
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
    
    
    //CAGradientLayer  渐变
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(50, 300, 300, 100);
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];
    gradientLayer.locations = @[@0,@0.5,@1];
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //用的不多，不再一一介绍
    
    //CATextLayer
    //CATransformLayer
    //CAReplicatorLayer
    //...
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 610, 450, 80);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"下一篇(隐式动画)" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)buttonClick:(UIButton *)button {
    
    VagueCoreAnimationViewController *vc = [[VagueCoreAnimationViewController alloc]initWithNibName:@"VagueCoreAnimationViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
