//
//  ZYXLocationEngine.h
//
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN


@interface ZYXLocationEngine : NSObject

@property (nonatomic, assign, readonly) CLLocationCoordinate2D curCoordinate;

/**
 *  单例
 */
+ (instancetype)sharedLocationEngine;

/**
 *  启动定位
 */
- (void)startLocationEngine;

/**
 *  停止定位
 */
- (void)stopLocationEngine;

@end

NS_ASSUME_NONNULL_END
