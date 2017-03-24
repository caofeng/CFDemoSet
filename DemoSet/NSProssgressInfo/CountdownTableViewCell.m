//
//  CountdownTableViewCell.m
//  DemoSet
//
//  Created by CaoFeng on 17/3/23.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CountdownTableViewCell.h"
#include <sys/sysctl.h>


@interface CountdownTableViewCell ()

@property (nonatomic, strong) UILabel   *countdownLabel;

@end


@implementation CountdownTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.countdownLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 300, 30)];
        self.countdownLabel.font = [UIFont systemFontOfSize:15];
        self.countdownLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.countdownLabel];
        
    }
    
    return self;
}


- (void)setupInvestButtonWithRemainSeconds:(long long)remainSeconds {
    
    if (remainSeconds>0) {
        
        self.countdownLabel.text = [NSString stringWithFormat:@"%lld秒后发射",remainSeconds];
        
    } else {
        
        self.countdownLabel.text = @"发射";
    }
    
}


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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
