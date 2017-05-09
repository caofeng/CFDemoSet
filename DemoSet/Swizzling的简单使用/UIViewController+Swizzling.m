//
//  UIViewController+Swizzling.m
//  DemoSet
//
//  Created by Apple on 16/11/18.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import <objc/runtime.h>
//#import "UMMobClick/MobClick.h"
//#import "BaiduMobStat.h"

@implementation UIViewController (Swizzling)

+(void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzlingSelector = @selector(my_viewWillAppear:);

        Method originalMethod = class_getInstanceMethod([self class], originalSelector);
        Method swizzlingMethod = class_getInstanceMethod([self class], swizzlingSelector);

        BOOL didAddMethod =
        class_addMethod([self class],
                        originalSelector,
                        method_getImplementation(swizzlingMethod),
                        method_getTypeEncoding(swizzlingMethod));
        
        if (didAddMethod) {
            class_replaceMethod([self class],
                                swizzlingSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzlingMethod);
        }
        
        
        Method ori1Method = class_getInstanceMethod([self class], @selector(viewWillDisappear:));
        Method swizz1Method = class_getInstanceMethod([self class], @selector(xxx_viewWillDisappear:));

        method_exchangeImplementations(ori1Method, swizz1Method);
        
        
    });
}

- (void)my_viewWillAppear:(BOOL)animated {
    
//     [MobClick beginLogPageView:NSStringFromClass([self class])];
//    [[BaiduMobStat defaultStat] pageviewStartWithName:NSStringFromClass([self class])];
}


- (void)xxx_viewWillDisappear:(BOOL)animated {
    
    
//    [MobClick endLogPageView:NSStringFromClass([self class])];
//    [[BaiduMobStat defaultStat] pageviewEndWithName:NSStringFromClass([self class])];
}

@end
