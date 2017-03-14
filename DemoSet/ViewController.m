//
//  ViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "ViewController.h"
#import "RacViewController.h"
#import "TableViewController.h"
#import "PictureViewController.h"
#import "ThreadViewController.h"
#import "SwizzlingViewController.h"
#import "DrawViewController.h"
#import "CoreAnimationViewController.h"
#import "JSInterOCViewController.h"
#import "JSPatchViewController.h"
#import "SDViewController.h"
#import "NerdyUIViewController.h"
#import "InputCheckViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray    *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo集";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat Width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat Height = [[UIScreen mainScreen] bounds].size.height;
   

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64) style:UITableViewStylePlain];
    tableView.bounces = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.array = @[@"RAC的简单使用",@"TableView的布局",@"微信照片浏览器",@"多线程",@"Swizzling使用",@"高级绘制",@"高级动画",@"JS和OC相互调用",@"iOS热修复",@"SDWebImage使用",@"NerdyUI库使用",@"输入检查"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.textLabel.text = self.array[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = nil;
    
    switch (indexPath.row) {
        case 0:
        {
            vc = [[RacViewController alloc]initWithNibName:@"RacViewController" bundle:nil];
            
        }
            break;
        case 1:
        {
            vc = [[TableViewController alloc]initWithNibName:@"TableViewController" bundle:nil];
           
        }
            break;
        case 2:
        {
            vc = [[PictureViewController alloc]initWithNibName:@"PictureViewController" bundle:nil];
            
        }
            break;
        case 3:
        {
            vc = [[ThreadViewController alloc]initWithNibName:@"ThreadViewController" bundle:nil];
            
        }
            break;
        case 4:
        {
            vc = [[SwizzlingViewController alloc]initWithNibName:@"SwizzlingViewController" bundle:nil];
            
        }
            break;
        case 5:
        {
            vc = [[DrawViewController alloc]initWithNibName:@"DrawViewController" bundle:nil];
            
        }
            break;
        case 6:
        {
            vc = [[CoreAnimationViewController alloc]initWithNibName:@"CoreAnimationViewController" bundle:nil];
            
        }
            break;
        case 7:
        {
            vc = [[JSInterOCViewController alloc]initWithNibName:@"JSInterOCViewController" bundle:nil];
            
        }
            break;
        case 8:
        {
            vc = [[JSPatchViewController alloc]initWithNibName:@"JSPatchViewController" bundle:nil];
            
        }
            break;
        case 9:
        {
            vc = [[SDViewController alloc]initWithNibName:@"SDViewController" bundle:nil];
            
        }
            break;
        case 10:
        {
            vc= [[NerdyUIViewController alloc]initWithNibName:@"NerdyUIViewController" bundle:nil];
        }
            break;
        case 11:
        {
            vc = [[InputCheckViewController alloc]initWithNibName:@"InputCheckViewController" bundle:nil];
        }
            
        default:
            break;
    }
    
    vc.title = self.array[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
