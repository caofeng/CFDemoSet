//
//  NSArray+Swizzling.m
//  DemoSet
//
//  Created by Apple on 16/11/18.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "NSArray+Swizzling.h"
#import <objc/runtime.h>
@implementation NSArray (Swizzling)

+(void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method originalMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method swizzlingMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(my_objectAtIndex:));
        method_exchangeImplementations(originalMethod, swizzlingMethod);
    });
}

- (id)my_objectAtIndex:(NSInteger)index {
    if (index>self.count-1) {
        @try {
            return [self my_objectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"%@---%@--%@",[exception callStackSymbols],exception.reason,exception.name);
        } @finally {
        }
        return nil;
    } else {
        return [self my_objectAtIndex:index];
    }
}

@end
