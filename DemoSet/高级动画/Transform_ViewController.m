//
//  Transform_ViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/21.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "Transform_ViewController.h"
#import "SpecializedLayerVC.h"

@interface Transform_ViewController ()

@end

@implementation Transform_ViewController

CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图层转换";
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 200, 200);
    [self.view.layer addSublayer:layer];
    UIImage *image = [UIImage imageNamed:@"4.jpg"];
    layer.contents = (__bridge id _Nullable)(image.CGImage);
    
    //复合变换
    /*
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, 0.8, 0.8);
    transform = CGAffineTransformRotate(transform, M_PI_4);
    transform = CGAffineTransformTranslate(transform, 100, 200);
    
    layer.affineTransform = transform;
    
    */
    
    //斜切变换
    /*
    layer.affineTransform = CGAffineTransformMakeShear(1, 0);
    */
    
    //3D变换---很少用到，了解一下就行
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    layer.transform = transform;
    
    /*--------------关于变换就到这吧-------------*/
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 610, 450, 80);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"下一篇(专有图层简单介绍)" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
- (void)buttonClick:(UIButton *)button {
    SpecializedLayerVC *vc = [[SpecializedLayerVC alloc]initWithNibName:@"SpecializedLayerVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
