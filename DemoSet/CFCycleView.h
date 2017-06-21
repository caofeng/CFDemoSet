//
//  CFCycleView.h
//  DemoSet
//
//  Created by CaoFeng on 2017/6/21.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CFCycleView : UIView

- (void)setLocationImageArray:(NSArray *)imageArray;

- (void)setRemoteImageArray:(NSArray *)imageArray placeholderImage:(NSString *)placeholder;

@property (nonatomic, copy) void (^selectedImageIndex)(NSInteger index);

@end
