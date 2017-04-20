//
//  CFProgressCircleView.m
//  DemoSet
//
//  Created by CaoFeng on 2017/4/20.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CFProgressCircleView.h"

@interface CFProgressCircleView ()

@end

@implementation CFProgressCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    
    CGContextSetLineWidth(context, 1);
    
    CGContextAddArc(context, 11, 11, 8, 0, 1.7*M_PI, 0);
    
    CGContextDrawPath(context, kCGPathStroke);
    
}

- (void)startAnimation {
    
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.keyPath = @"transform.rotation.z";
    animation.toValue = @(M_PI*2);
    animation.duration = 0.6;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"rotation"];
}

- (void)endAnimation {
    
    if ([self.layer valueForKey:@"rotation"] != nil) {
        
        [self.layer removeAnimationForKey:@"rotation"];
    }
}

@end
