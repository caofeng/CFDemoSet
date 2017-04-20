//
//  CFButton.h
//  DemoSet
//
//  Created by CaoFeng on 2017/4/20.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

typedef void(^eventButton)();

#import <UIKit/UIKit.h>

@interface CFButton : UIView

+ (instancetype)initWithTitle:(NSString *)title buttonHeadle:(eventButton)event;

- (void)startAnimation;
- (void)endAnimation;

@end
