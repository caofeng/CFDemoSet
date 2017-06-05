//
//  CompoundViewController.m
//  DemoSet
//
//  Created by CaoFeng on 2017/5/5.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CompoundViewController.h"
#import "UIImage+CFExtensions.h"

@interface CompoundViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;

@property (nonatomic, assign) NSInteger     deleteSection;
@property (nonatomic, assign) NSInteger     lastSection;

@end

@implementation CompoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.deleteSection = -1;
    self.lastSection = -1;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = [UIColor redColor];
    
    [button setTitle:[NSString stringWithFormat:@"%ld",section] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.tag = 100+section;
    
    [button addTarget:self action:@selector(refreshCellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==self.deleteSection) {
        return 0;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void)refreshCellClick:(UIButton *)button {
    
    self.deleteSection =  button.tag - 100;
    
    NSMutableIndexSet *indexset = [NSMutableIndexSet indexSet];
    NSMutableIndexSet *indexset_ = [NSMutableIndexSet indexSet];
    
    
    [indexset addIndex:self.deleteSection];
    
    
    
    
    
    [self.tableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationAutomatic];
    //...
    [self.tableView reloadSections:indexset_ withRowAnimation:UITableViewRowAnimationAutomatic];
    
//    [indexset_ removeAllIndexes];
    
    self.lastSection = self.deleteSection;

    [indexset_ addIndex:self.lastSection];
//    [indexset removeAllIndexes];
    
}

@end
