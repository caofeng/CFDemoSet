//
//  PictureViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "PictureViewController.h"
#import "XHImageViewer.h"
#import "XHBottomToolBar.h"

@interface PictureViewController ()<XHImageViewerDelegate>

@property (nonatomic, strong) NSMutableArray    *array;
@property (nonatomic, strong) XHImageViewer     *imager;
@property (nonatomic, strong) XHBottomToolBar   *toolBar;
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray array];
    
    for (int i=0; i<5; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30+(150+20)*(i%2), 150+(150+20)*(i/2), 150, 150)];
        imageView.userInteractionEnabled =YES;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
        [self.view addSubview:imageView];
        imageView.tag=i;
        [self.array addObject:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesturerecognizer:)];
        [imageView addGestureRecognizer:tap];
        
    }
    
}


- (void)tapGesturerecognizer:(UITapGestureRecognizer *)tap {
    
    __block PictureViewController *weakSelf = self;
    
    self.imager = [[XHImageViewer alloc]initWithImageViewerWillDismissWithSelectedViewBlock:^(XHImageViewer *imageViewer, UIImageView *selectedView) {
        
    } didDismissWithSelectedViewBlock:^(XHImageViewer *imageViewer, UIImageView *selectedView) {
        
    } didChangeToImageViewBlock:^(XHImageViewer *imageViewer, UIImageView *selectedView) {
        
        NSInteger index = [weakSelf.array indexOfObject:selectedView];
        
        weakSelf.toolBar.label.text = [NSString stringWithFormat:@"%ld/%lu",(long)index+1,(unsigned long)weakSelf.array.count];
    }];
    
    self.imager.delegate = self;
    self.imager.disableTouchDismiss = NO;
    [self.imager showWithImageViews:self.array selectedView:(UIImageView *)tap.view];
    self.toolBar.label.text = [NSString stringWithFormat:@"%ld/%lu",tap.view.tag+1,(unsigned long)self.array.count];
    
}

- (UIView *)customBottomToolBarOfImageViewer:(XHImageViewer *)imageViewer {
    
    self.toolBar = [[XHBottomToolBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    
    return self.toolBar;
}


@end
