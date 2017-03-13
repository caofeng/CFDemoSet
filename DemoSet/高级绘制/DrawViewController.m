//
//  DrawViewController.m
//  ZRYDeno
//
//  Created by Apple on 16/11/16.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //iOS开发UI篇—Quartz2D使用
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, 100, 100));
    CGContextAddRect(context, CGRectMake(100, 100, 100, 100));
    CGContextSetRGBStrokeColor(context, 123/255.0, 244/255.0, 80/255.0, 1);
    CGContextSetLineWidth(context, 10);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 200, 200));
    CGContextStrokePath(context);
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //将绘制的图片保存
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/abc.jpg"];
    UIImageJPEGRepresentation(image, 1);
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
    NSLog(@"---%@",NSHomeDirectory());
    
    //Quartz 2D是一个二维图形绘制引擎，支持iOS环境和Mac OS X环境。我们可以使用Quartz 2D API来实现许多功能，如基本路径的绘制、透明度、描影、绘制阴影、透明层、颜色管理、反锯齿、PDF文档生成和PDF元数据访问。在需要的时候，Quartz 2D还可以借助图形硬件的功能。
    
    DrawView *drawView = [[DrawView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 400)];
    [self.view addSubview:drawView];
    
    /************绘制没多少东西啊********************/
    
    
    
    
}

@end
