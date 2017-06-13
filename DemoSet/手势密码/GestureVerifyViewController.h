
#import <UIKit/UIKit.h>

typedef void(^GestureVerifySuccess)(BOOL success);

@interface GestureVerifyViewController : UIViewController

- (instancetype)initWithGestureVerifySuccess:(GestureVerifySuccess)success;

- (void)dissGestureVerifyViewController:(BOOL)animated;

@end
