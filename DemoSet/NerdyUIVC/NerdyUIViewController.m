//
//  NerdyUIViewController.m
//  DemoSet
//
//  Created by Apple.Cao on 17/2/20.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#define W [[UIScreen mainScreen]bounds].size.width
#define H [[UIScreen mainScreen]bounds].size.height

#import "NerdyUIViewController.h"
#import "NewsViewController.h"
@interface NerdyUIViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView     *scrollView;
@property (nonatomic, strong) NSArray          *btnArray;
@property (nonatomic, strong) NSMutableArray   *array;
@property (nonatomic, strong) UIView           *lineView;

@end

@implementation NerdyUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [NSMutableArray array];
    self.btnArray = @[@"持有中",@"投标中",@"已完成",@"已结清"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.frame = [[UIScreen mainScreen]bounds];
    NSInteger num = self.btnArray.count;

    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+41, W, H-64-41)];
    [self.scrollView setContentOffset:CGPointZero];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(num*W, self.scrollView.frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40+64, W/self.btnArray.count, 1)];
    self.lineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.lineView];
    for (int i=0; i<num; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(W/num*i, 64, W/num, 40);
        [button setTitle:self.btnArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.tag = 100+i;
        [button addTarget:self action:@selector(selectedItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        if (i==0) {
            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)selectedItemClick:(UIButton *)button {
    
    NSInteger index = button.tag-100;
    
    if (![self.array containsObject:@(index)]) {
        [self.array addObject:@(index)];
        NewsViewController *newsVC = [[NewsViewController alloc]initWithNibName:@"NewsViewController" bundle:nil];
        newsVC.index = index;
        [self addChildViewController:newsVC];
        [self.scrollView addSubview:newsVC.view];
        newsVC.view.frame = CGRectMake(index*W, 0, W, self.scrollView.frame.size.height);
    }
    [self.scrollView setContentOffset:CGPointMake(index * W, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
   
    NSInteger index = scrollView.contentOffset.x/W;
    UIButton *button = [self.view viewWithTag:100+index];
    [self selectedItemClick:button];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x<-30) {
        [self.navigationController popViewControllerAnimated:YES];
    }
   CGFloat offset_x = scrollView.contentOffset.x;
    self.lineView.frame = CGRectMake(offset_x/self.btnArray.count, 40+64, W/self.btnArray.count, 1);
}


@end
