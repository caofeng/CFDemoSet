//
//  UIImage+DrawImage.h
//  DemoSet
//
//  Created by MountainCao on 2017/7/11.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DrawImage)

//图片切圆角，避免离屏渲染
- (UIImage *)circleImage;

@end
