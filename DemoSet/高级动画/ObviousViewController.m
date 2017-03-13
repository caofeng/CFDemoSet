//
//  ObviousViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/22.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "ObviousViewController.h"
#import "PaintViewController.h"

@interface ObviousViewController ()<CAAnimationDelegate>
@property (nonatomic, strong) CALayer   *layer1;
@property (nonatomic, strong) CALayer *tranLayer;
@property (nonatomic, assign) BOOL      normal;
@end

@implementation ObviousViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图层显式动画";
    
    self.layer1 = [CALayer layer];
    self.layer1.frame = CGRectMake(0, 64, 100, 100);
    self.layer1.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.layer1];
    
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc]init];
    [bezierPath moveToPoint:CGPointMake(50, 250)];
    //三次贝塞尔曲线--还是挺有用的
    [bezierPath addCurveToPoint:CGPointMake(350, 250) controlPoint1:CGPointMake(125, 100) controlPoint2:CGPointMake(274, 400)];
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    shapelayer.path = bezierPath.CGPath;
    shapelayer.strokeColor = [UIColor redColor].CGColor;
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    shapelayer.lineWidth = 5;
    [self.view.layer addSublayer:shapelayer];
    
    CALayer *dongLayer = [CALayer layer];
    dongLayer.bounds = CGRectMake(0, 0, 10, 10);
    dongLayer.position = CGPointMake(50, 250);
    dongLayer.cornerRadius = 5;
    dongLayer.masksToBounds = YES;
    dongLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:dongLayer];
    
    CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animation];
    keyAnim.keyPath = @"position";
//    keyAnim.duration = 3;
//    keyAnim.autoreverses = YES;
//    keyAnim.repeatCount = MAXFLOAT;
    keyAnim.rotationMode = kCAAnimationRotateAuto;
    keyAnim.path = bezierPath.CGPath;
//    [dongLayer addAnimation:keyAnim forKey:nil];
    
    CABasicAnimation *basicAnim = [CABasicAnimation animation];
    basicAnim.keyPath = @"backgroundColor";
//    basicAnim.duration = 3;
//    basicAnim.repeatCount = MAXFLOAT;
//    basicAnim.autoreverses = YES;
    basicAnim.toValue = (__bridge id _Nullable)([UIColor blueColor].CGColor);
//    [dongLayer addAnimation:basicAnim forKey:nil];
    
    //组动画
    CAAnimationGroup *groupAnim = [CAAnimationGroup animation];
    groupAnim.animations = @[keyAnim,basicAnim];
    groupAnim.duration = 3;
    groupAnim.repeatCount = MAXFLOAT;
    groupAnim.autoreverses = YES;
    [dongLayer addAnimation:groupAnim forKey:nil];
    
    
    /************用一下 CATransition ************/
    
    self.tranLayer = [CALayer layer];
    self.tranLayer.frame = CGRectMake(200, 300, 200, 200);
    self.tranLayer.contents = (__bridge id)[UIImage imageNamed:@"1.jpg"].CGImage;
    
    [self.view.layer addSublayer:self.tranLayer];
    
    
    
}
- (IBAction)transitionAnimationClick:(UIButton *)sender {
    CATransition *tranAnimation = [CATransition animation];
    tranAnimation.duration = 1;
    
    //很多属性--有兴趣试一下
    tranAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];//时间缓冲
    //tranAnimation.fillMode
    
    //tranAnimation.type = kCATransitionFade;
    //下面这两个属性还有很多私有API，可以玩玩
    tranAnimation.type = @"pageCurl";
    tranAnimation.subtype = kCATransitionFromLeft;
    
    if (!self.normal) {
        self.tranLayer.contents = (__bridge id)[UIImage imageNamed:@"2.jpg"].CGImage;
    } else {
        self.tranLayer.contents = (__bridge id)[UIImage imageNamed:@"1.jpg"].CGImage;
    }
    [self.tranLayer addAnimation:tranAnimation forKey:nil];
    
    self.normal = !self.normal;
}



- (IBAction)changeClick:(id)sender {
    
    //1.基础动画CABasicAnimation:CAPropertyAnimation:CAAnimation
    
    /*
    UIColor *color = [UIColor greenColor];
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"backgroundColor";
    basicAnimation.delegate = self;
    basicAnimation.toValue = (__bridge id _Nullable)(color.CGColor);
    [self.layer1 addAnimation:basicAnimation forKey:nil];
     */
    
    
    //关键帧动画CAKeyframeAnimation:CAPropertyAnimation:CAAnimation
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"backgroundColor";
    keyAnimation.duration = 5;
    keyAnimation.delegate = self;
    keyAnimation.values = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor,(__bridge id)[UIColor cyanColor].CGColor,(__bridge id)[UIColor grayColor].CGColor];
    [self.layer1 addAnimation:keyAnimation forKey:nil];
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    //在动画结束的时候把相应的隐式动画关闭
    NSLog(@"动画已结束");
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.layer1.backgroundColor = [UIColor grayColor].CGColor;
    [CATransaction commit];
    
}

- (IBAction)nextPage:(id)sender {
    PaintViewController *vc = [[PaintViewController alloc]initWithNibName:@"PaintViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
