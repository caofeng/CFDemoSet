//
//  CoordConvertViewController.m
//  DemoSet
//
//  Created by CaoFeng on 17/3/15.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CoordConvertViewController.h"
#import "Masonry.h"
#import "CoordTableViewCell.h"

@interface CoordConvertViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView    *bigView;
@property (nonatomic, strong) UIView    *smallView;
@property (nonatomic, strong) UITableView   *tableView;

@end

@implementation CoordConvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.frame = [[UIScreen mainScreen]bounds];

    /*
    self.bigView = [[UIView alloc]init];
    self.bigView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.bigView];
    [self.bigView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(20+64);
        make.height.mas_equalTo(500);
    }];
    
    self.smallView = [[UIView alloc]init];
    self.smallView.backgroundColor = [UIColor blueColor];
    [self.bigView addSubview:self.smallView];
    [self.smallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-30);
    }];
    [self.view layoutIfNeeded];
    NSLog(@"====%@",NSStringFromCGRect(self.smallView.frame));
    CGRect newRect = [self.bigView convertRect:self.smallView.frame toView:self.view];
    NSLog(@"====%@",NSStringFromCGRect(newRect));
     */
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CoordTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CoordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //把cell的位置映射到self.view上
    if (indexPath.row==5) {
        
        CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
        
        CGRect rectInTableView = [tableView convertRect:rect toView:self.view];
        
        NSLog(@"===%@",NSStringFromCGRect(rectInTableView));
        
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
