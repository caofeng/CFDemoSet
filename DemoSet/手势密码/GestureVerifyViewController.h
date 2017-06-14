
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GestureVerifyType) {
    GestureVerifyTypeReset,
    GestureVerifyTypeCheck,
};

typedef void(^GestureVerifySuccess)(BOOL success);

@interface GestureVerifyViewController : UIViewController

- (instancetype)initWithGestureVerifyType:(GestureVerifyType)type GestureSuccess:(GestureVerifySuccess)success;

- (void)dissGestureVerifyViewController:(BOOL)animated;

@end
