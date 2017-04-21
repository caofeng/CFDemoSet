//
//  UIControl+EnlargeEdge.m
//
//  Created by Jandy on 6/17/14.
//

#import "UIControl+EnlargeEdge.h"
#import <objc/runtime.h>


@implementation UIControl (EnlargeEdge)

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

/**
 * @brief 设置[上、下、左、右]扩大区域的大小, 四个方向设置为一样
 *
 * 比如原来是 orginal: x=100, y=100, size: width=100, height=50
 * 如果这里的size设置为10， 则上、下、左、右都扩大10， 可响应事件区域变成:
 * x=100-左扩大10=90
 * y=100-上扩大10=90
 * width=100+左扩大10+右扩大10=120
 * height=50+上扩大10+下扩大10=70
 *
 * @param size [上、下、左、右]4个方向扩大区域的大小
 */
- (void)zyx_setEnlargeEdge:(CGFloat)size {
    
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 * @brief 分别设置上、下、左、右4个方向的扩大区域的大小
 *
 * @param top 上方扩大区域的大小
 * @param right 右侧扩大区域的大小
 * @param bottom 底部扩大区域的大小
 * @param left 左侧扩大区域的大小
 */
- (void)zyx_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*) event {
    
    CGRect rect = [self zyx_enlargedRect];

    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
        
    } else {
        if (self.hidden || self.alpha == 0 || !self.enabled || !self.isUserInteractionEnabled) {
            return [super hitTest:point withEvent:event];
        }
        
        return CGRectContainsPoint(rect, point) ? self : nil;
    }
    
    return nil;
}

/**
 * @brief 计算扩大后的可响应区域大小
 *
 * @return 返回扩大后的可响应区域大小(CGRect)
 */
- (CGRect)zyx_enlargedRect {
    
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
        
    } else {
        
        return self.bounds;
    }
}

@end

