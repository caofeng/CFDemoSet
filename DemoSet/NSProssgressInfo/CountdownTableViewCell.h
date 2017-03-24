//
//  CountdownTableViewCell.h
//  DemoSet
//
//  Created by CaoFeng on 17/3/23.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountdownTableViewCell : UITableViewCell

- (void)setupInvestButtonWithRemainSeconds:(long long)remainSeconds;

@end
