//
//  DrawView.m
//  ZRYDeno
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor grayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    //起点
    CGContextMoveToPoint(context, 10, 100);
    //终点
    CGContextAddLineToPoint(context, 100, 100);
    //填充色
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    //线宽
    CGContextSetLineWidth(context, 5);
    //线的样式
    CGContextSetLineCap(context, kCGLineCapButt);
    //拐点样式
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    //完成绘制
    CGContextStrokePath(context);
    
    
    /*------------------为分割而存在的分割线---------------------*/
    
    
    CGContextMoveToPoint(context, 200, 50);
    CGContextAddLineToPoint(context, 200, 100);
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextStrokePath(context);

    /*------------------绘制三角形的分割线---------------------*/
    
    CGContextMoveToPoint(context, 350, 50);
    CGContextAddLineToPoint(context, 300, 100);
    CGContextAddLineToPoint(context, 400, 100);
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
    CGContextSetLineWidth(context,3);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    
    /*------------------绘制饼状图的分割线---------------------*/

    CGContextMoveToPoint(context, 100, 200);
    CGContextAddArc(context, 100, 200, 50, 0, M_PI/2, 0);
    CGContextSetRGBFillColor(context, 0.8, 0.6, 0.2, 1);
    CGContextFillPath(context);
    
    
    /*------------------绘制（椭）圆形的分割线---------------------*/

    CGContextAddEllipseInRect(context,CGRectMake(200, 200, 200, 100));
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextStrokePath(context);
    
    /*------------------绘制圆弧的分割线---------------------*/

    
    CGContextAddArc(context, 100, 300, 50, 0, M_PI, 0);
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextStrokePath(context);
    
    
}


@end
