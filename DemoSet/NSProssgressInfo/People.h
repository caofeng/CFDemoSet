//
//  People.h
//  DemoSet
//
//  Created by CaoFeng on 17/3/24.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface People : NSObject

@property (nonatomic, copy) NSString    *name;

@property (nonatomic, assign) CGFloat    height;

@property (nonatomic, assign) long long remainSeconds;
@property (nonatomic, assign) long long systemTime;

@property (nonatomic, copy) void(^countdownBlock)(long long leftSeconds);

@end
