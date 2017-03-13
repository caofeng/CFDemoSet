//
//  CustomWindow.h
//  DemoSet
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)();

@interface CustomWindow : UIWindow

- (instancetype)initWithFrame:(CGRect)frame completionBlock:(CompletionBlock)completionBlock;

@end
