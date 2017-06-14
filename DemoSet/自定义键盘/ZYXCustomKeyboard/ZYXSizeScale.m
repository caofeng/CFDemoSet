//
//  ZYXSizeScale.m
//  ZhongYeXingRong
//
//  Created by Jiandong on 8/4/16.
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "ZYXSizeScale.h"

CGFloat autoSizeScale() {
    
    if ([[UIScreen mainScreen] bounds].size.height > 568.0f) {
        return MIN(autoSizeScaleX(), autoSizeScaleY());
    }
    
    return 1.0f;
}

CGFloat autoSizeScaleX() {
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat autoSizeScaleX = 1.0f;
    if ([[UIScreen mainScreen] bounds].size.height > 480.0f) {
        autoSizeScaleX = screenWidth / 320.0f;
    }
    
    return autoSizeScaleX;
}

CGFloat autoSizeScaleY() {
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat autoSizeScaleY = 1.0f;
    if (screenHeight > 480.0f) {
        autoSizeScaleY = screenHeight / 568.0f;
    }
    return autoSizeScaleY;
}

CGFloat scaleX(CGFloat value) {
    
    return value * autoSizeScaleX();
}

CGFloat scaleY(CGFloat value) {
    
    return value * autoSizeScaleY();
}
