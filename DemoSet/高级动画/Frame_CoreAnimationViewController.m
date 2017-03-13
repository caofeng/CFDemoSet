//
//  Frame_CoreAnimationViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/21.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "Frame_CoreAnimationViewController.h"
#import "Transform_ViewController.h"

@interface Frame_CoreAnimationViewController ()
@property (nonatomic, strong) CALayer *layer1;



@end

@implementation Frame_CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图层布局";
    
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 150);
    //这个属性设置 layer 的前后，值越小的越靠后
    layer.zPosition = 1.0;
    //锚点，取值是 0---1
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    
    /*
    NSLog(@"--frame-%@",NSStringFromCGRect(layer.frame));
    NSLog(@"--position-%@",NSStringFromCGPoint(layer.position));
    NSLog(@"--bounds-%@",NSStringFromCGRect(layer.bounds));

    layer.anchorPoint = CGPointMake(0.3, 0.3);
    
    NSLog(@"-锚点改变后-frame-%@",NSStringFromCGRect(layer.frame));
    NSLog(@"-锚点改变后-position-%@",NSStringFromCGPoint(layer.position));
    NSLog(@"-锚点改变后-bounds-%@",NSStringFromCGRect(layer.bounds));
     */
    
    
    //以上看出：anchorPoint锚点改变后，bounds,position没变，但frame改变了
    
    /*  穿插一段意外
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    NSLog(@"---%ld",(long)components.hour);
    NSLog(@"---%ld",(long)components.minute);
    NSLog(@"---%ld",(long)components.second);
     */
    
    self.layer1 = [CALayer layer];
    self.layer1.bounds = CGRectMake(0, 0, 200, 200);
    self.layer1.position = CGPointMake(150, 300);
    self.layer1.zPosition = 2;
    self.layer1.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:self.layer1];
    
    /*---以下这些属性 自己看看
    self.layer1.cornerRadius
    self.layer1.masksToBounds
    self.layer1.borderColor
    self.layer1.borderWidth
    self.layer1.shadowColor
    self.layer1.shadowOffset
    self.layer1.shadowRadius
    self.layer1.shadowOpacity
    self.layer1.shadowPath 阴影形状
    self.layer1.mask 图层蒙板，也是一个图层
    self.layer1.shouldRasterize
    self.layer1.rasterizationScale
    self.layer1.magnificationFilter
    self.layer1.minificationFilter
     */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 610, 450, 80);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"下一篇(图层图层转换)" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)buttonClick:(UIButton*)button {
    
    Transform_ViewController *vc = [[Transform_ViewController alloc]initWithNibName:@"Transform_ViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGPoint point = [[touches anyObject]locationInView:self.view];
    
    //以下两种方法，可以变相实现 layer1点击
    
    //1.
   CALayer *layer = [self.view.layer hitTest:point];
    if (layer==self.layer1) {
        NSLog(@"---layer1被点击了");
    }
    
    
    /*   2.
    //这一句颇为关键
    point=[self.layer1 convertPoint:point fromLayer:self.view.layer];
    
    if ([self.layer1 containsPoint:point]) {
     
        NSLog(@"---%@",NSStringFromCGPoint(point));
    }
     */
    
    //特别提示：zPosition属性可以明显改变屏幕上图层的顺序，但不能改变事件传递的顺序，自己可以试一下确实如此
    
    
}





@end
