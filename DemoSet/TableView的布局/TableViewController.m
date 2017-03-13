//
//  TableViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "TableViewController.h"
#import "TableCell.h"
#import "Masonry.h"

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *cacheDic;
@property (nonatomic, strong) UIView      *headerView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.cacheDic = [NSMutableDictionary dictionary];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[TableCell class] forCellReuseIdentifier:@"cell"];
    
    //表头
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 100)];
    self.headerView.backgroundColor = [UIColor greenColor];
    self.tableView.tableHeaderView = self.headerView;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [self.headerView addSubview:titleLabel];
    titleLabel.numberOfLines = 0;
    titleLabel.text = @"今年三季度，工信部对50家手机应用商店的应用软件进行技术检测，发现违规软件29款，涉及违规收集使用用户个人信息、恶意“吸费”、强行捆绑推广其他无关应用软件等问题。";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.right.equalTo(@-10);
    }];
    
    titleLabel.preferredMaxLayoutWidth =CGRectGetWidth(self.tableView.frame)-20;
    
    UILabel *conLabel = [[UILabel alloc]init];
    [self.headerView addSubview:conLabel];
    conLabel.numberOfLines = 0;
    conLabel.text = @"今年三季度，工信部对50家手机应用商店的应用软件进行技术检测，发现违规软件29款，涉及违规收集使用用户个人信息、恶意“吸费”、强行捆绑推广其他无关应用软件等问题。今年三季度，工信部对50家手机应用商店的应用软件进行技术检测，发现违规软件29款，涉及违规收集使用用户个人信息、恶意“吸费”、强行捆绑推广其他无关应用软件等问题。";
    [conLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@-10).priorityLow();
    }];
    
    conLabel.preferredMaxLayoutWidth =CGRectGetWidth(self.tableView.frame)-20;
    
    self.headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableCell *cell = (TableCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.row%2==0) {
        
        cell.label.text = @"下一篇-->微信照片浏览效果";
        
    } else {
        
        cell.label.text = @"textField上的内容绝对不会被重用";
    }
    cell.textField.tag = indexPath.row;
    [cell.textField addTarget:self action:@selector(textFieldChangedEditing:) forControlEvents:UIControlEventEditingChanged];
    
    return cell;
}

- (void)textFieldChangedEditing:(UITextField *)textField {
    
    NSString *tag = [NSString stringWithFormat:@"%ld",(long)textField.tag];
    [self.cacheDic setObject:textField.text forKey:tag];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCell *cell_ = (TableCell *)cell;
    NSString *content = [self.cacheDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
    cell_.textField.text = content;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    
}



@end
