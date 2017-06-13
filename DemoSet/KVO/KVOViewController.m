//
//  KVOViewController.m
//  DemoSet
//
//  Created by CaoFeng on 2017/6/12.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "KVOViewController.h"

@interface KVOViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"====self.class:%p===super.class:%p",self.class,super.class);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)willChangeValueForKey:(NSString *)key {
    
    
}

- (void)didChangeValueForKey:(NSString *)key {
    
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
   CGFloat offset = self.tableView.contentOffset.y;
    
    CGFloat delta = offset / 64.f + 1.f;
    delta = MAX(0, delta);
    
    self.navigationController.navigationBar.alpha = MIN(1, delta);
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    return cell;
}

- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
    self.tableView = nil;
}

@end
