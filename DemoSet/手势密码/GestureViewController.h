
#import <UIKit/UIKit.h>

typedef enum{
    GestureViewControllerTypeSetting = 1,
    GestureViewControllerTypeLogin
}GestureViewControllerType;

typedef enum{
    buttonTagReset = 1,
    buttonTagManager,
    buttonTagForget
    
}buttonTag;

typedef void(^HeadlerEvent)();
typedef void(^GestureSuccess)(BOOL success);


@interface GestureViewController : UIViewController

/**
 *  控制器来源类型
 */
@property (nonatomic, assign) GestureViewControllerType type;


/*
 * type 手势类型
 * success 手势是否成功
 * headlerEvent 使用账号密码登录
 */

- (instancetype)initWithGestureType:(GestureViewControllerType)type gestureSuccess:(GestureSuccess)success accountLoginHeadlerEvent:(HeadlerEvent)headlerEvent;

- (void)dissGestureViewController:(BOOL)animated;

@end
