//
//  CFProgressInfoViewController.m
//  DemoSet
//
//  Created by CaoFeng on 17/3/23.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CFProgressInfoViewController.h"
#include <sys/sysctl.h>
#import "CountdownTableViewCell.h"
#import "People.h"
@interface CFProgressInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSMutableArray       *dataArray;


@end

@implementation CFProgressInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.frame = [[UIScreen mainScreen]bounds];
    
    self.dataArray = [NSMutableArray array];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[CountdownTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    for (int i=0; i<50; i++) {
        
        People *p = [[People alloc]init];
        p.name = @"xx";
        p.height = 180;
        p.remainSeconds = 100;
        [self.dataArray addObject:p];
    }
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval time= timeInterval - [self uptime];
    NSString *timeStr = [NSString stringWithFormat:@"%.0f",time*1000];
    NSLog(@"===绝对开机时间%@",[self timeWithTimeIntervalString:timeStr]);
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CountdownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    People *p = self.dataArray[indexPath.row];
    
    p.countdownBlock = ^(long long remainS) {
        
        [cell setupInvestButtonWithRemainSeconds:remainS];
        
    };
    
    return cell;
}


- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
    
}

//返回进程时间(单位 秒)

-(time_t)uptime
{
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    time_t now;
    time_t uptime = -1;
    (void)time(&now);
    
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0)
    {
        uptime = now - boottime.tv_sec;
    }
    return uptime;
}


@end
