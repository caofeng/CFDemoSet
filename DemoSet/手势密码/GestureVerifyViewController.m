
#import "GestureTextConst.h"
#import "GestureVerifyViewController.h"
#import "PCCircleViewConst.h"
#import "PCCircleView.h"
#import "PCLockLabel.h"
#import "GestureViewController.h"
#import "PCCircleInfoView.h"
#import "PCCircle.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface GestureVerifyViewController ()<CircleViewDelegate>

@property (nonatomic, assign) BOOL isToSetNewGesture;

/**
 *  文字提示Label
 */
@property (nonatomic, strong) PCLockLabel *msgLabel;
/**
 *  尝试次数
 */
@property (nonatomic, assign) NSInteger     verifyNum;

@property (nonatomic, strong) PCCircleInfoView  *infoView;

@property (nonatomic, copy) GestureVerifySuccess success;

@end

@implementation GestureVerifyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (instancetype)initWithGestureVerifySuccess:(GestureVerifySuccess)success {
    
    self.isToSetNewGesture = YES;
    self.success = success;
    
    return [self init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:CircleViewBackgroundColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fd_interactivePopDisabled = YES;
    
    self.title = @"验证手势解锁";
    
    PCCircleView *lockView = [[PCCircleView alloc] init];
    lockView.delegate = self;
    [lockView setType:CircleViewTypeVerify];
    [self.view addSubview:lockView];
    
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 30);
    [msgLabel showNormalMsg:gestureTextOldGesture];
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
    
    PCCircleInfoView *infoView = [[PCCircleInfoView alloc] init];
    infoView.frame = CGRectMake(0, 0, CircleRadius * 2 * 0.6, CircleRadius * 2 * 0.6);
    infoView.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.msgLabel.frame) - CGRectGetHeight(infoView.frame)/2 - 10);
    self.infoView = infoView;
    [self.view addSubview:infoView];
    
}

#pragma mark - login or verify gesture
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    if (type == CircleViewTypeVerify) {
        
        if (equal) {
            
            NSLog(@"验证成功");
            
            if (self.isToSetNewGesture) {
                
                __block GestureVerifyViewController *weakSelf = self;
                
                GestureViewController *gestureVc = [[GestureViewController alloc] initWithGestureType:GestureViewControllerTypeSetting gestureSuccess:^(BOOL success) {
                    if (success) {
                        
                        if (weakSelf.success) {
                            weakSelf.success(YES);
                        }
                    }
                } accountLoginHeadlerEvent:nil];
                
                [self.navigationController pushViewController:gestureVc animated:NO];
                
                [self removeCurrentViewController];
                
            } else {
                
                [self dissGestureVerifyViewController:YES];
            }
            
        } else {
            
            [self infoViewDeselectedSubviews];
            
            [self infoViewSelectedSubviewsSameAsCircleView:view];
            
            self.verifyNum ++;
            
            if (self.verifyNum >= gestureTextGestureVerifyMaxErrorNum) {
                //超过错误次数
                [self.msgLabel showWarnMsgAndShake:@"错误次数太多"];
                [self dissGestureVerifyViewController:YES];
                //迫使用户退出登录
                if (self.success) {
                    self.success(NO);
                }
                
            } else {
                
                [self.msgLabel showWarnMsgAndShake:gestureTextGestureVerifyRestNum(self.verifyNum)];
            }
        }
    }
}

#pragma mark - infoView展示方法
#pragma mark - 让infoView对应按钮选中
- (void)infoViewSelectedSubviewsSameAsCircleView:(PCCircleView *)circleView
{
    for (PCCircle *circle in circleView.subviews) {
        
        if (circle.state == CircleStateSelected || circle.state == CircleStateLastOneSelected) {
            
            for (PCCircle *infoCircle in self.infoView.subviews) {
                if (infoCircle.tag == circle.tag) {
                    [infoCircle setState:CircleStateSelected];
                }
            }
        }
    }
}

#pragma mark - 让infoView对应按钮取消选中
- (void)infoViewDeselectedSubviews
{
    [self.infoView.subviews enumerateObjectsUsingBlock:^(PCCircle *obj, NSUInteger idx, BOOL *stop) {
        [obj setState:CircleStateNormal];
    }];
}


- (void)dissGestureVerifyViewController:(BOOL)animated {
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:animated completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:animated];
    }
}

- (void)removeCurrentViewController {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [array removeObjectAtIndex:array.count-2];
        self.navigationController.viewControllers = array;
    });
    
}

@end
