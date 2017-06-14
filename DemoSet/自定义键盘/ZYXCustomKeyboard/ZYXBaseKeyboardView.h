//
//  ZYXBaseKeyboardView.h
//
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYXKeyBoardView.h"

typedef enum : NSUInteger {
    ZYXNumberViewImageNone = 0,
    ZYXNumberViewImageLeft = 1,  //背景弹出层 左
    ZYXNumberViewImageInner,     //背景弹出层 中
    ZYXNumberViewImageRight      //背景弹出层 右
} ZYXNumberViewImage;


//字符按钮
typedef void (^CharacterPressedBlock) (NSString *characterValue, ZYXKeyboardButtonType type);

@interface ZYXBaseKeyboardView : UIView

/** 字符数组 */
@property (nonatomic, strong) NSMutableArray *charArrayList;

/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray *buttonList;
@property (nonatomic, copy) CharacterPressedBlock characterPressedCompleted;

/** 删除按钮的定时器 */
@property (nonatomic, strong) NSTimer *deleteKeyTimer;

/**
 *  所有字符
 */
- (NSMutableArray *)getCharacterList;
  
/**
 *  弹出层背景位置  子类必须继承
 */
- (ZYXNumberViewImage)popUpToButtonPosition:(UIButton *)button;

/**
 *  删除长按
 */
- (void)startTimerDel;

/**
 *  停止长按
 */
- (void)stopTimerDel;

/**
 *  子类继承此方法可以长按删除
 */
- (void)deleteClick:(id)sender;

/**
 *  长按时间
 */
- (void)deleteLongPressed:(UILongPressGestureRecognizer *)sender;

@end
