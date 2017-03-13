//
//  UITextField+InputAccessoryView.h
//  DemoSet
//
//  Created by Apple.Cao on 16/12/12.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (InputAccessoryView)


@property (nonatomic, strong) NSString *rightStr;

- (void)setCustomAccessoryView;

@end
