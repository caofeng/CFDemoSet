//
//  PaintView.m
//  DemoSet
//
//  Created by Apple on 16/11/23.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "PaintView.h"

@interface PaintView ()
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@end

@implementation PaintView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.path = [[UIBezierPath alloc]init];
        self.shapeLayer = [CAShapeLayer layer];
        self.shapeLayer.frame = self.frame;
        [self.layer addSublayer:self.shapeLayer];
        self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
        self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
        self.shapeLayer.lineJoin = kCALineJoinRound;
        self.shapeLayer.lineCap = kCALineCapRound;
        self.shapeLayer.lineWidth = 5;
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject]locationInView:self];
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject]locationInView:self];
    
    [self.path addLineToPoint:point];
    self.shapeLayer.path = self.path.CGPath;
}


@end
