//
//  VagueCoreAnimationViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/21.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "VagueCoreAnimationViewController.h"
#import "ObviousViewController.h"

@interface VagueCoreAnimationViewController ()

@property (nonatomic, strong) CALayer *layer1;
@property (nonatomic, strong) UIButton *button;


@end

@implementation VagueCoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"隐式动画";//按照我的意思去做，而不是我说的。-- 埃德娜，辛普森
    
    self.layer1 = [CALayer layer];
    self.layer1.frame = CGRectMake(0, 64, 400, 80);
    self.layer1.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.layer1];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromLeft;
    transition.duration = 5;
    self.layer1.actions = @{@"backgroundColor":transition};
    

    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 150, 450, 80);
    self.button.backgroundColor = [UIColor redColor];
    [self.button setTitle:@"下一篇(显式动画)" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseInOut animations:^{
        self.button.frame = CGRectMake(0, 400, 450, 80);

    } completion:nil];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //presentationLayer  这种方式响应运动视图的点击事件，并不高明，真做这种效果，会用一个定时器随时改变button的frame，简单省事
    CGPoint point = [[touches anyObject]locationInView:self.view];
    if ([self.button.layer.presentationLayer hitTest:point]) {
        [self buttonClick:nil];
    }
}

- (IBAction)changeColorClick:(id)sender {
    
    self.layer1.backgroundColor = [UIColor greenColor].CGColor;
    
}

- (void)buttonClick:(UIButton *)button {
    ObviousViewController *vc = [[ObviousViewController alloc]initWithNibName:@"ObviousViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
