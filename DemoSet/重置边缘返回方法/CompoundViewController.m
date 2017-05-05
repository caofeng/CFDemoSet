//
//  CompoundViewController.m
//  DemoSet
//
//  Created by CaoFeng on 2017/5/5.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CompoundViewController.h"
#import "UIImage+CFExtensions.h"

@interface CompoundViewController ()

@property (nonatomic, strong) UIImageView   *myImageView;

@end

@implementation CompoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //20,50
    
    UIImage *image1 = [UIImage imageNamed:@"tableview_header_refresh_left"];
    
    image1 = [image1 imageRotatedByDegrees:2];
    
    self.myImageView = [[UIImageView alloc]initWithImage:image1];
    
    self.myImageView.frame = CGRectMake(100, 100, image1.size.width, image1.size.height);
    
    [self.view addSubview:self.myImageView];
    
    
    
}

@end
