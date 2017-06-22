//
//  CFLunboViewController.m
//  DemoSet
//
//  Created by CaoFeng on 2017/6/21.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kItemWidth kWidth - 20

#import "CFLunboViewController.h"
#import "CFCycleView.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "WSPageView.h"
#import "WSIndexBanner.h"

@interface CFLunboViewController ()<WSPageViewDelegate,WSPageViewDataSource>

@property (nonatomic, strong) CFCycleView *cycleView;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) NSArray       *array;

@end

@implementation CFLunboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.fd_interactivePopDisabled = YES;
    
//    self.cycleView = [[CFCycleView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
//    [self.view addSubview:self.cycleView];
//    
//    [self.cycleView setLocationImageArray:@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"]];
//    
//    self.cycleView.selectedImageIndex = ^(NSInteger index) {
//        
//        NSLog(@"====%ld",index);
//    };
    
//
    
    
    self.array = [NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg", nil];
    
    WSPageView *pageView = [[WSPageView alloc]initWithFrame:CGRectMake(0, 200, kWidth, 200) originalPageCount:5];
    pageView.delegate = self;
    pageView.dataSource = self;
    pageView.autoTime = 5;
    [self.view addSubview:pageView];
    
}

- (CGSize)sizeForPageInFlowView:(WSPageView *)flowView {
    
    return CGSizeMake(kWidth-60, 200);
}

#pragma mark NewPagedFlowView Datasource

- (NSInteger)numberOfPagesInFlowView:(WSPageView *)flowView {
    
    return self.array.count;
}

- (UIView *)flowView:(WSPageView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    WSIndexBanner *bannerView = (WSIndexBanner *)[flowView dequeueReusableCell];
    
    if (!bannerView) {
        bannerView = [[WSIndexBanner alloc] initWithFrame:CGRectMake(0, 0, kWidth - 60, 200)];
    }
    
    bannerView.mainImageView.image = [UIImage imageNamed:self.array[index]];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(WSPageView *)flowView {
    
    //    NSLog(@"滚动到了第%ld页",pageNumber);
}

- (void)dealloc
{
    NSLog(@"===%@",NSStringFromClass([self class]));
}


@end
