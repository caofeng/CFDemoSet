//
//  SDViewController.m
//  DemoSet
//
//  Created by Apple.Cao on 17/2/6.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "SDViewController.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
@interface SDViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, assign) BOOL          open;
@property (nonatomic, strong) UIImageView   *headerImageView;

@end

@implementation SDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.frame = [[UIScreen mainScreen]bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    
    NSString *url =@"https://static.zyxr.com/g1/M00/07/42/oYYBAFjHaBOAHD6XAAS-2IzvnUQ853.jpg";
    
    
    //查看是否有缓存
    UIImage *cachedImage = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:url];
    
    //移除缓存
    //[[SDImageCache sharedImageCache]removeImageForKey:url];
    
    
    if (!cachedImage) {
        
        NSLog(@"没有缓存");
        
        [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            NSLog(@"下载成功");
            
            if (image) {
                
                [[SDImageCache sharedImageCache] storeImage:image forKey:url completion:^{
                    
                }];
                
            }
            
        }];
        
    } else {
        
        NSLog(@"有缓存");
        self.headerImageView = [[UIImageView alloc]initWithImage:cachedImage];
        self.headerImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
        [self.tableView.tableHeaderView addSubview:self.headerImageView];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIButton *sectionHeaderView = [UIButton buttonWithType:UIButtonTypeCustom];
    sectionHeaderView.tag = 100+section;
    sectionHeaderView.backgroundColor = [UIColor lightGrayColor];
    [sectionHeaderView setTitle:[NSString stringWithFormat:@"第%ld区",section] forState:UIControlStateNormal];
    [sectionHeaderView addTarget:self action:@selector(sectionheaderButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    return sectionHeaderView;
}

- (void)sectionheaderButtonPress:(UIButton *)button {    
    if (button.tag==100) {
        self.open = !self.open;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        if (self.open) {
            return 0;
        } else {
            return 10;
        }
    } else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
