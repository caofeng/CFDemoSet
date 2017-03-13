//
//  Table_RacViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "Table_RacViewController.h"
#import "ReactiveCocoa.h"

@interface Table_RacViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation Table_RacViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RAC_TableView";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    
    [RACObserve(self.tableView, contentOffset) subscribeNext:^(NSValue* offset) {
        CGPoint newOffset = offset.CGPointValue;
        NSLog(@"---%.0f",newOffset.y);
        
        
    }];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"下一篇-->TableView的Layout布局";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
