//
//  UIControl+EnlargeEdge.h
//
//  Created by Jandy on 6/17/14.
//

#import <UIKit/UIKit.h>


/**
 * UIControl扩展
 * 增加方法扩大触摸事件响应区域
 */
@interface UIControl (EnlargeEdge)


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
- (void)zyx_setEnlargeEdge:(CGFloat)size;

/**
 * @brief 分别设置上、下、左、右4个方向的扩大区域的大小
 *
 * @param top 上方扩大区域的大小
 * @param right 右侧扩大区域的大小
 * @param bottom 底部扩大区域的大小
 * @param left 左侧扩大区域的大小
 */
- (void)zyx_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end


/*
 From:http://www.myexception.cn/operating-system/1492312.html
 原理
 
 利用 objective-c 中的 objc_setAssociatedObject 來記錄要變大的範圍。
 
 objc_setAssociatedObject 是 objective-c runtime library 裡面的 function。
 
 需要#import <objc/runtime.h>
 
 最后，最重要的是去 override - (UIView) hitTest:(CGPoint) point withEvent:(UIEvent) event
 
 用新设定的 Rect 来当着点击范围。
 
 使用
 [enlargeButton setEnlargeEdge:20.0];
 或者[enlargeButton setEnlargeEdgeWithTop:20 right:20 bottom:20 left:10];
 */
