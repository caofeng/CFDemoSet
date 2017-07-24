//
//  NSCodingViewController.m
//  DemoSet
//
//  Created by MountainCao on 2017/7/24.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "NSCodingViewController.h"
#import "People.h"

@interface NSCodingViewController ()

@end

@implementation NSCodingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",NSHomeDirectory());
    
    People *p = [[People alloc]init];
    
    p.name = @"曹峰";
    p.age = 25;
    p.height = 172;
    p.address = @"深圳宝安区西乡";
    
    
    NSMutableData* data = [NSMutableData data];
    
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    [archiver encodeObject:p forKey:@"cf"];
    
    [archiver finishEncoding];
    
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"teacher"];
    
    [data writeToFile:path atomically:YES];
    
    
    NSData* data2 = [NSData dataWithContentsOfFile:path];
    
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data2];
    
    People *p1 = [unarchiver decodeObjectForKey:@"cf"];
    
    [unarchiver finishDecoding];
    
    NSLog(@"===%@",p1.name);
    
    
}



@end
